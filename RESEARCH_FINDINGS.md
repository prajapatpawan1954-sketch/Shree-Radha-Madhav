# Research Findings for Shree Radha Madhav Decoration App

## 1. Background Removal Implementation

### Options Evaluated:
1. **react-native-background-remover** - Uses MLKit (Android) and Vision (iOS)
   - Pros: Native performance, works offline
   - Cons: Limited to iOS 17+ and specific Android versions
   
2. **Server-side LLM API** (Recommended for this project)
   - Use the built-in server LLM vision capabilities
   - Send image to server, get back processed image with background removed
   - Pros: Works on all devices, consistent results, no external API keys needed
   - Cons: Requires network connection

3. **@imgly/background-removal-js** - Browser-based solution
   - Pros: Works in browser and Node.js
   - Cons: Not ideal for React Native

### Decision:
**Use server-side LLM API** - The project already has a built-in server with LLM capabilities. We'll:
- Upload image to server
- Call LLM vision API to remove background
- Return processed image URI
- Cache result locally in AsyncStorage

## 2. Notifications & 24-Hour Reminders

### Key Findings from Expo Notifications Documentation:
- **Local Notifications**: Can be scheduled using `Notifications.scheduleNotificationAsync()`
- **Trigger Types**: 
  - `TIME_INTERVAL`: Schedule for X seconds from now
  - `DATE`: Schedule for a specific date/time
  - `CALENDAR`: Schedule for recurring times (calendar-based)
- **Limitations**: Remote push notifications unavailable in Expo Go on Android from SDK 53+
- **Local notifications work fine in Expo Go**

### Implementation Strategy for 24-Hour Reminders:
1. When user books an event, store event details with date/time
2. Calculate 24 hours before event time
3. Use `Notifications.scheduleNotificationAsync()` with `DATE` trigger
4. For background delivery: Use `expo-task-manager` for periodic checks
5. On app launch, check for upcoming events and schedule notifications

### Code Pattern:
```typescript
const eventDate = new Date(bookingDate);
const reminderDate = new Date(eventDate.getTime() - 24 * 60 * 60 * 1000);

await Notifications.scheduleNotificationAsync({
  content: {
    title: 'Event Reminder',
    body: `Your event "${eventName}" is tomorrow!`,
    data: { eventId },
  },
  trigger: {
    type: Notifications.SchedulableTriggerInputTypes.DATE,
    date: reminderDate,
  },
});
```

## 3. AI Suggestion Engine Architecture

### Requirements:
- Analyze real-time available stock inventory
- Generate design suggestions respecting inventory limits
- Prevent over-suggestion (don't suggest 21 pillars if only 20 available)
- Suggest optimal item placement on venue photos

### Implementation Strategy:
1. **Inventory Analysis Phase**:
   - Read all stock items with their quantities
   - Calculate available items per category
   - Create inventory profile

2. **Suggestion Generation Phase**:
   - Use server LLM to analyze venue photo
   - Provide inventory constraints to LLM
   - Request design suggestions with placement coordinates
   - LLM respects inventory limits in suggestions

3. **Placement Optimization**:
   - LLM suggests x,y coordinates for items
   - Respects venue dimensions
   - Avoids overlapping suggestions
   - Considers visual balance

### Data Structure:
```typescript
interface InventoryConstraint {
  itemId: string;
  category: string;
  available: number;
  suggested: number; // Don't exceed available
}

interface SuggestionRequest {
  venuePhotoUri: string;
  venueDimensions: { width: number; height: number };
  constraints: InventoryConstraint[];
}

interface SuggestedPlacement {
  itemId: string;
  x: number;
  y: number;
  width: number;
  height: number;
  quantity: number;
}
```

## 4. Multi-Photo Venue Scanning

### Architecture:
1. **Venue Photo Capture**:
   - Allow 3-4 photos from different angles
   - Store with metadata (angle label, timestamp)
   - Compress for storage efficiency

2. **Photo Management**:
   - Gallery view showing all venue photos
   - Ability to switch between photos
   - AR overlay persists per photo

3. **Storage Structure**:
```typescript
interface VenuePhoto {
  id: string;
  uri: string; // Local file URI
  angle: string; // "Front", "Left", "Right", "Top"
  timestamp: number;
  placements: PositionedItem[]; // Specific placements for this photo
}

interface Venue {
  id: string;
  name: string;
  photos: VenuePhoto[];
  createdAt: number;
}
```

## 5. Booking Calendar & Event Management

### Features:
1. **Event Booking**:
   - Date picker for event date
   - Event name and details
   - Venue selection
   - Items to be used (from stock)

2. **Notification Scheduling**:
   - Calculate 24 hours before event
   - Schedule local notification
   - Store event in AsyncStorage

3. **Inventory Tracking**:
   - Mark items as "used" for event
   - Reduce available count temporarily
   - Restore after event date passes

### Data Structure:
```typescript
interface BookedEvent {
  id: string;
  name: string;
  date: number; // Timestamp
  venueId: string;
  itemsUsed: Array<{ itemId: string; quantity: number }>;
  notificationId: string;
  createdAt: number;
}
```

## 6. Technology Stack Summary

- **Background Removal**: Server-side LLM API
- **Notifications**: expo-notifications with local scheduling
- **AI Suggestions**: Server-side LLM with inventory constraints
- **Storage**: AsyncStorage for local data, FileSystem for images
- **State Management**: React Context (StockProvider, VenueProvider, EventProvider)
- **Gestures**: react-native-gesture-handler + Reanimated
- **Camera**: expo-camera for live feed and photo capture
- **Image Picker**: expo-image-picker for gallery selection

## 7. Implementation Priority

1. **Phase 3**: Strict Inventory Control (quantity tracking)
2. **Phase 4**: Multi-Photo Venue Scanning
3. **Phase 5**: AI Suggestion Engine (with server integration)
4. **Phase 6**: Booking Calendar & Notifications
5. **Phase 7**: Background Removal (server-side LLM)
6. **Phase 8**: Polish & Refinement
