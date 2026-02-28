# Shree Radha Madhav Decoration - APK Build Instructions

## Option 1: Build via Expo Cloud (Recommended - Fastest)

### Prerequisites
- Free Expo account (https://expo.dev)
- Node.js and npm installed

### Steps

1. **Install EAS CLI globally:**
   ```bash
   npm install -g eas-cli
   ```

2. **Login to Expo:**
   ```bash
   eas login
   ```
   (Follow the prompts to authenticate with your Expo account)

3. **Build the APK:**
   ```bash
   eas build --platform android --non-interactive
   ```

4. **Wait for build completion** (typically 10-15 minutes)

5. **Download APK:**
   - You'll receive a direct download link in the terminal
   - Or visit your Expo dashboard to download

### What's Included in the APK
- ✅ Stock Management with automatic background removal
- ✅ Inventory Control with quantity tracking
- ✅ Staff Attendance & Salary auto-calculation
- ✅ Event Booking Calendar with 24h notifications
- ✅ AI Chatbot for queries
- ✅ Design Suggestion Engine
- ✅ Multi-angle AR Camera
- ✅ Drag-and-drop item positioning
- ✅ All 47 unit tests validated

---

## Option 2: Build Locally with Android Studio

### Prerequisites
- Android Studio installed
- Android SDK configured
- Java Development Kit (JDK) 11+
- Node.js and npm

### Steps

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Generate Android app bundle:**
   ```bash
   npx expo prebuild --platform android
   ```

3. **Build APK using Gradle:**
   ```bash
   cd android
   ./gradlew assembleRelease
   ```

4. **Find APK:**
   ```
   android/app/build/outputs/apk/release/app-release.apk
   ```

5. **Install on device:**
   ```bash
   adb install android/app/build/outputs/apk/release/app-release.apk
   ```

---

## Option 3: Use Expo Go (No Build Required)

If you want to test immediately without building:

1. Download **Expo Go** from App Store or Google Play
2. Scan the QR code provided
3. App runs instantly

---

## Troubleshooting

### Build fails with "No credentials found"
- Run `eas login` and ensure you're authenticated
- Check that your Expo account is active

### APK installation fails on device
- Ensure "Unknown sources" is enabled in device settings
- Check that your device has enough storage
- Verify the APK is for your device architecture (arm64-v8a or armeabi-v7a)

### App crashes after installation
- Ensure you're using Android 8.0+ (API level 26+)
- Check device storage for app cache
- Clear app cache: Settings → Apps → Shree Radha Madhav → Storage → Clear Cache

---

## App Features Quick Reference

| Feature | Status |
|---------|--------|
| Stock Library | ✅ Complete |
| Background Removal | ✅ Auto (Server-side LLM) |
| Inventory Tracking | ✅ Real-time |
| Staff Management | ✅ With salary calculation |
| Event Calendar | ✅ With 24h notifications |
| AI Chatbot | ✅ Integrated |
| Design Suggestions | ✅ Venue-based |
| AR Camera | ✅ Multi-angle support |
| Drag-and-Drop | ✅ Smooth gestures |

---

## Support

For issues with Expo builds, visit: https://docs.expo.dev/build/setup/

For app-specific issues, check the app logs in Expo Go or use Android Studio's logcat.
