# Wedding & Flower Decoration AR App - Design Document

## Overview
A mobile app for wedding and event planners to visualize flower and decoration arrangements in real-time using AR. Users can build a personal stock library of their flowers and decor items, then use the AR camera to position and arrange them virtually before physical setup.

---

## Screen List

1. **Home Screen** - Main entry point with quick actions
2. **My Stock Library** - Browse, upload, and manage flower/decor photos
3. **Stock Item Detail** - View item details, edit, delete
4. **AR Camera Screen** - Live camera view with positioned items overlay
5. **AR Positioning Editor** - Drag-and-drop interface for item placement
6. **Settings Screen** - App preferences and storage management

---

## Primary Content and Functionality

### 1. Home Screen
- **Purpose**: Quick navigation hub
- **Content**:
  - Welcome header with app branding
  - Quick action buttons: "Open AR Camera" and "Manage Stock"
  - Recent items preview (last 3 items from stock)
  - Statistics: Total items in stock, recent arrangements
- **Functionality**:
  - Navigate to AR Camera
  - Navigate to Stock Library
  - Quick access to recent items

### 2. My Stock Library
- **Purpose**: Manage personal collection of flowers and decor items
- **Content**:
  - Grid view of uploaded items (3 columns)
  - Each item card shows:
    - Thumbnail image (background removed)
    - Item name
    - Category badge (Flowers, Vases, Lights, Greenery, etc.)
    - Quick action buttons (Edit, Delete, Use in AR)
  - Empty state with upload prompt
- **Functionality**:
  - Upload new photos from camera or gallery
  - Automatic background removal on upload
  - Edit item name and category
  - Delete items
  - Select item to use in AR camera
  - Search/filter by category

### 3. Stock Item Detail
- **Purpose**: View and manage individual items
- **Content**:
  - Full-size image preview (background removed)
  - Item name (editable)
  - Category selector
  - Upload date
  - Item size indicator
  - Delete button
  - "Use in AR" button
- **Functionality**:
  - Edit item metadata
  - Delete item with confirmation
  - Launch AR camera with this item pre-selected

### 4. AR Camera Screen
- **Purpose**: Live camera feed with AR overlay
- **Content**:
  - Full-screen live camera feed
  - Positioned items overlay (background-removed images)
  - Top bar with:
    - Back button
    - "Add Item" button (opens stock selector)
    - Settings/help icon
  - Bottom bar with:
    - "Clear All" button
    - "Save Arrangement" button
    - "Edit Mode" toggle
- **Functionality**:
  - Display live camera feed
  - Show selected items as overlays with background removed
  - Allow drag-and-drop in edit mode
  - Add/remove items from arrangement
  - Save arrangement as screenshot

### 5. AR Positioning Editor
- **Purpose**: Drag-and-drop interface for precise item placement
- **Content**:
  - Camera feed background
  - Draggable item overlays
  - Each item has:
    - Drag handle
    - Resize handles (pinch-to-zoom)
    - Delete button (X)
  - Bottom action bar:
    - "Done" button
    - "Clear All" button
- **Functionality**:
  - Drag items to reposition
  - Pinch-to-zoom to resize
  - Tap to select/deselect
  - Swipe to delete
  - Save final arrangement

### 6. Settings Screen
- **Purpose**: App preferences and management
- **Content**:
  - Storage usage indicator
  - Clear cache option
  - App version info
  - About section
- **Functionality**:
  - Manage app storage
  - Clear cached images
  - View app information

---

## Key User Flows

### Flow 1: Upload and Prepare Stock Items
1. User opens app → Home Screen
2. Taps "Manage Stock" → My Stock Library
3. Taps "+" button → Camera/Gallery picker
4. Selects photo of flower/decor
5. App automatically removes background
6. User enters item name and selects category
7. Item saved to library
8. User returns to My Stock Library (item now visible)

### Flow 2: Plan Arrangement Using AR
1. User opens app → Home Screen
2. Taps "Open AR Camera" → AR Camera Screen
3. Camera feed displays with empty overlay area
4. User taps "Add Item" → Stock selector modal
5. User selects item from stock → Item appears on camera feed
6. User taps "Edit Mode" → AR Positioning Editor
7. User drags item to desired position
8. User pinches to resize if needed
9. User taps "Done" → Returns to AR Camera Screen
10. User repeats steps 4-9 for additional items
11. User taps "Save Arrangement" → Screenshot saved to gallery

### Flow 3: Modify Existing Arrangement
1. User is in AR Camera Screen with items positioned
2. User taps "Edit Mode" → AR Positioning Editor
3. User drags items to new positions
4. User can delete items by swiping or tapping X
5. User can add more items via "Add Item" button
6. User taps "Done" → Returns to AR Camera Screen
7. User taps "Save Arrangement" → Updated screenshot saved

---

## Color Choices

**Brand Colors** (Wedding & Event Theme):
- **Primary**: `#D4A574` (Warm Gold) - Elegant, wedding-appropriate
- **Secondary**: `#8B5A3C` (Rich Brown) - Earthy, natural
- **Accent**: `#E8D4C4` (Soft Cream) - Light, sophisticated
- **Success**: `#6BA587` (Sage Green) - Natural, calming
- **Background**: `#FFFFFF` (White) - Clean, minimal
- **Dark Background**: `#1A1A1A` (Near Black) - For dark mode
- **Text Primary**: `#2C2C2C` (Dark Gray) - High contrast
- **Text Secondary**: `#666666` (Medium Gray) - Secondary information
- **Border**: `#E0D5CC` (Light Beige) - Subtle dividers

**Semantic Colors**:
- **Success**: `#6BA587` (Item uploaded, saved)
- **Warning**: `#D4A574` (Confirmation needed)
- **Error**: `#C85A54` (Delete, error states)

---

## Design Principles

1. **One-Handed Usage**: All interactive elements positioned within thumb reach on bottom half of screen
2. **iOS-First Design**: Follow Apple HIG for spacing, typography, and interactions
3. **Real Assets Only**: No placeholder images or blue boxes; all items show actual background-removed photos
4. **Minimal Visual Clutter**: Clean, spacious layout with clear visual hierarchy
5. **Haptic Feedback**: Subtle vibrations on interactions (drag, drop, delete)
6. **Accessibility**: High contrast, readable fonts, clear touch targets (min 44pt)

---

## Technical Considerations

- **Background Removal**: Use server-side AI (LLM vision) to remove backgrounds on upload
- **AR Overlay**: Use React Native Gesture Handler for drag-and-drop interactions
- **Camera Integration**: Use `expo-camera` for live camera feed
- **Image Storage**: Store background-removed images locally in AsyncStorage with file URIs
- **Arrangement Persistence**: Save arrangements as JSON (item positions, sizes) in AsyncStorage
- **Screenshot Capture**: Use `react-native-view-shot` or similar to capture AR arrangements

---

## Navigation Structure

```
Home Screen
├── My Stock Library
│   └── Stock Item Detail
│       └── AR Camera (with item pre-selected)
├── AR Camera Screen
│   ├── Stock Selector Modal
│   ├── AR Positioning Editor
│   └── Save Arrangement
└── Settings Screen
```

---

## Interaction Patterns

| Action | Feedback |
|--------|----------|
| Tap button | Scale 0.97, light haptic |
| Drag item | Continuous haptic, shadow elevation |
| Drop item | Medium haptic, snap-to-grid (optional) |
| Delete item | Confirmation dialog, error haptic |
| Upload photo | Loading spinner, success notification |
| Save arrangement | Toast notification, success haptic |

