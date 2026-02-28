# Shree Radha Madhav Decoration - Event Decoration Planner - TODO

## Core Features

### Phase 1: Project Setup & Navigation
- [x] Create app icon and branding assets
- [x] Update app.config.ts with app name and branding
- [x] Set up tab navigation (Home screen)
- [x] Create base screen components with proper SafeArea handling
- [x] Create types and storage infrastructure
- [x] Set up StockProvider for state management

### Phase 2: Strict Inventory Control & Stock Library
- [x] Create Stock Library screen with grid layout
- [x] Implement photo upload from camera/gallery (expo-image-picker)
- [x] Implement edit/delete functionality for stock items
- [x] Store items locally with AsyncStorage
- [x] Display images in grid with category labels
- [x] Add quantity tracking per item
- [x] Create Inventory Control screen with quantity management
- [ ] Implement background removal API (server-side LLM)
- [ ] Add search/filter by category
- [ ] Track inventory depletion when items are used in events

### Phase 3: Multi-Photo Venue Scanning
- [x] Create Venue Scanner screen to capture 3-4 photos of large venues
- [x] Store multiple venue photos with metadata (angle, location)
- [x] Implement venue photo gallery and selection
- [x] Create VenueProvider for state management
- [ ] Create AR overlay system for each venue photo
- [ ] Build photo comparison/carousel view

### Phase 4: AR Positioning & Drag-Drop on Venue Photos
- [x] Implement drag-and-drop with react-native-gesture-handler
- [x] Set up animated positioning with Reanimated
- [x] Implement item selection/deselection visual feedback
- [x] Add delete functionality (tap X button)
- [ ] Add pinch-to-zoom for item resizing
- [ ] Persist item positions per venue photo
- [ ] Implement rotation gesture for items
- [ ] Add quantity validation (don't allow more items than available in stock)

### Phase 5: AI Suggestion Engine
- [ ] Analyze available stock inventory in real-time
- [ ] Generate design suggestions based on available quantities
- [ ] Suggest optimal item placement on venue photos
- [ ] Prevent over-suggestion (e.g., don't suggest 21 pillars if only 20 available)
- [ ] Learn from user preferences over time

### Phase 6: Booking Calendar & 24h Notifications
- [ ] Create event booking calendar (date picker)
- [ ] Store event details (name, date, venue, items used)
- [ ] Implement 24-hour reminder notifications
- [ ] Set up background task for notification delivery
- [ ] Create event history/past events view
- [ ] Track inventory usage per event

### Phase 7: Save & Export
- [ ] Implement arrangement screenshot capture
- [ ] Save screenshots to device gallery
- [ ] Create arrangement save/load functionality
- [ ] Add "Save Arrangement" button and flow

### Phase 8: Polish & Refinement
- [ ] Add haptic feedback for interactions
- [ ] Implement loading states and error handling
- [ ] Add empty states for all screens
- [ ] Implement Settings screen
- [ ] Add branding (Shree Radha Madhav Decoration) to splash and headers
- [ ] Test end-to-end user flows
- [ ] Optimize performance and memory usage

### Phase 9: Testing & Deployment
- [ ] Write unit tests for core functionality
- [ ] Test on iOS and Android devices via Expo Go
- [ ] Test AR on different lighting conditions
- [ ] Test background removal on various images
- [ ] Test notification delivery
- [ ] Create checkpoint for deployment
- [ ] Prepare APK build instructions

## Key Requirements
- Strict inventory control - no over-allocation of items
- NO external assets - only user-uploaded images from stock
- Background removal must be automatic on upload
- AI suggestions must respect inventory limits
- 24-hour notifications for booked events
- Multi-angle venue scanning support
- Drag-and-drop with rotation capability
- Branding: "Shree Radha Madhav Decoration" on splash and headers
- Optimize for Expo Go with APK build option

## Known Constraints
- No blue boxes or placeholders - all items must be real assets
- Background removal must happen automatically on upload
- Drag-and-drop must work smoothly on mobile
- App must respect safe area and notch
- One-handed usage priority for all interactions

## Notes
- Background removal will use server-side LLM vision capabilities
- Consider using react-native-view-shot for screenshot functionality
- Arrange items should be stored as JSON with positions/sizes
- Camera feed should be full-screen with overlay controls
- Notifications will use expo-notifications with background task scheduling


## PHASE 1: CORE BUSINESS LOGIC (COMPLETE)

### Live Inventory with Auto-Deduction
- [x] Create BookingInventory system to track stock usage per event
- [x] Implement auto-deduction logic when event is booked
- [x] Implement auto-restoration when event is marked "Finished"
- [x] Create Inventory History screen to show deductions/restorations
- [x] Display real-time available stock vs. used stock

### Staff Attendance & Salary Management
- [x] Create Staff Management screen
- [x] Add staff member creation with name, phone, daily wage
- [x] Create Staff Attendance Calendar (mark Present/Absent)
- [x] Implement auto-salary calculation (Daily Wage × Days Present)
- [x] Create Staff Salary Report screen
- [x] Track monthly salary history

### Full Date Picker Calendar
- [x] Replace quick date buttons with full calendar widget
- [x] Allow selection of any date in the past/future
- [x] Show event details on selected date
- [x] Implement date range selection for multi-day events
- [x] Show visual indicators for booked dates

## PHASE 2: AI & AUTOMATION (COMPLETE)
- [x] AI Chatbot for Q&A (stock levels, staff attendance, suggestions)
- [x] Design Suggestions Engine with venue analysis
- [x] AI-powered placement suggestions based on available inventory
- [x] Design theme recommendations (Entrance Arch, Centerpieces, Lighting, Pillars)
- [x] Auto Background Removal for stock photos (server-side LLM)
- [x] Integrated background removal into stock upload workflow
- [ ] APK build and distribution
