# Wedding & Flower Decoration AR App - Technical Research

## Background Removal Solutions

### Option 1: Server-Side LLM (Recommended)
- **Approach**: Use the built-in server LLM capabilities to process images and remove backgrounds
- **Advantages**: 
  - Accurate AI-powered background removal
  - No external API keys needed
  - Processes on server, reducing mobile app complexity
  - Works with any image type
- **Implementation**: Upload image to server, process with LLM vision, return PNG with transparent background
- **Fallback**: If server LLM unavailable, use native platform APIs

### Option 2: Native Platform APIs
- **iOS**: Vision framework (iOS 17+) for semantic segmentation
- **Android**: MLKit Vision for image segmentation
- **Package**: `@six33/react-native-bg-removal` or `@react-native-background-remover/react-native-background-remover`
- **Advantages**: Works offline, no server dependency
- **Disadvantages**: Limited to supported object types, may not work well for complex arrangements

### Option 3: External API (Not Recommended)
- **Services**: remove.bg, PicsArt API
- **Disadvantages**: Requires API keys, additional cost, external dependency
- **Use Case**: Only if native/server solutions fail

**Decision**: Implement server-side LLM as primary, with native API fallback.

---

## Camera & AR Overlay Implementation

### Expo Camera (expo-camera)
- **Status**: Fully supported in Expo SDK 54
- **Features**:
  - Live camera feed with CameraView component
  - Photo capture and video recording
  - Zoom, torch, and flash control
  - Barcode scanning
- **Permissions**: Requires camera permission (handled by expo-camera)
- **Implementation**:
  - Use `CameraView` component for live feed
  - Render overlay items on top using absolute positioning
  - Use `CameraView.getAvailableCameraTypes()` to detect camera availability

### AR Overlay Strategy
- **Approach**: Render background-removed images as overlays on camera feed
- **Implementation**: 
  - Use absolute positioning to place items over camera
  - Store item positions as { x, y, width, height, rotation }
  - Render items as `Image` components with transparent backgrounds
- **Performance**: Use `FlatList` or memoization to prevent unnecessary re-renders

---

## Drag-and-Drop Implementation

### React Native Gesture Handler + Reanimated
- **Status**: Pre-installed in project (react-native-gesture-handler 2.28, react-native-reanimated 4.1.6)
- **Approach**: Use `Gesture.Pan()` for dragging
- **Key Concepts**:
  - `useSharedValue()`: Store position state that can be accessed in worklets
  - `Gesture.Pan()`: Detect pan gestures with `onChange` and `onFinalize` callbacks
  - `useAnimatedStyle()`: Apply animated transforms to views
  - `GestureDetector`: Wrap draggable items with gesture detector
  - `GestureHandlerRootView`: Wrap app root (already in place)

### Pinch-to-Zoom for Resizing
- **Approach**: Use `Gesture.Pinch()` for resize
- **Implementation**:
  - Track scale value with `useSharedValue()`
  - Update item width/height based on scale
  - Combine with Pan gesture for simultaneous drag + resize

### Implementation Pattern
```typescript
// Pseudo-code for draggable item
const translateX = useSharedValue(initialX);
const translateY = useSharedValue(initialY);

const pan = Gesture.Pan()
  .onChange((event) => {
    translateX.value += event.changeX;
    translateY.value += event.changeY;
  })
  .onFinalize(() => {
    // Save position to AsyncStorage
    saveItemPosition(itemId, { x: translateX.value, y: translateY.value });
  });

const animatedStyle = useAnimatedStyle(() => ({
  transform: [
    { translateX: translateX.value },
    { translateY: translateY.value },
  ],
}));

return (
  <GestureDetector gesture={pan}>
    <Animated.View style={[styles.item, animatedStyle]}>
      <Image source={{ uri: backgroundRemovedImageUri }} />
    </Animated.View>
  </GestureDetector>
);
```

---

## Image Storage & Management

### Local Storage Strategy
- **Primary**: AsyncStorage for item metadata (name, category, uri)
- **Image Files**: Store in `FileSystem.documentDirectory` or `FileSystem.cacheDirectory`
- **Arrangement Data**: Store as JSON with item positions, sizes, rotations

### Image Processing
- **Upload Flow**:
  1. User selects photo from gallery/camera
  2. Save original to FileSystem
  3. Send to server for background removal
  4. Receive PNG with transparent background
  5. Save processed image to FileSystem
  6. Store metadata in AsyncStorage

### File Structure
```
FileSystem.documentDirectory/
├── stock/
│   ├── item-1-original.jpg
│   ├── item-1-processed.png
│   ├── item-2-original.jpg
│   └── item-2-processed.png
└── arrangements/
    ├── arrangement-1.json
    └── arrangement-1-screenshot.jpg
```

---

## Screenshot Capture

### Options
1. **react-native-view-shot**: Capture view as image
2. **expo-media-library**: Save to device gallery
3. **expo-sharing**: Share captured image

### Implementation
- Capture AR camera view with positioned items
- Save to device gallery with timestamp
- Allow user to share or export

---

## Data Structures

### Stock Item
```typescript
interface StockItem {
  id: string;
  name: string;
  category: 'flowers' | 'vases' | 'lights' | 'greenery' | 'other';
  originalImageUri: string;
  processedImageUri: string; // Background removed
  width: number;
  height: number;
  createdAt: number;
}
```

### Positioned Item (on AR canvas)
```typescript
interface PositionedItem {
  id: string;
  stockItemId: string;
  x: number;
  y: number;
  width: number;
  height: number;
  rotation: number;
  zIndex: number;
}
```

### Arrangement
```typescript
interface Arrangement {
  id: string;
  name: string;
  items: PositionedItem[];
  screenshotUri?: string;
  createdAt: number;
  updatedAt: number;
}
```

---

## Performance Considerations

1. **Image Optimization**: Compress images before upload, store processed images efficiently
2. **Gesture Performance**: Use `runOnJS()` for non-animation callbacks to avoid blocking
3. **Rendering**: Memoize item components to prevent unnecessary re-renders
4. **Memory**: Clear old arrangements and cache periodically
5. **Camera**: Use appropriate resolution for camera feed (not full resolution)

---

## Security & Permissions

### Required Permissions
- **Camera**: `expo-camera` handles automatically
- **Photo Library**: `expo-image-picker` handles automatically
- **Media Library Write**: For saving screenshots

### No Backend Data Sync
- Default: Local-only storage with AsyncStorage
- Future: Could add cloud sync with server if needed
- User data stays on device by default

