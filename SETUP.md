# Setup Instructions

## Prerequisites

1. **Install Flutter SDK**
   - Download from: https://flutter.dev/docs/get-started/install
   - Follow installation instructions for your platform
   - Verify installation: `flutter doctor`

2. **Install IDE/Editor** (optional but recommended)
   - Android Studio / IntelliJ IDEA with Flutter plugin
   - VS Code with Flutter extension
   - Or use any text editor

## Setup Steps

1. **Navigate to project directory**
   ```bash
   cd /Users/aleksandarkalabic/tona/mvp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify setup**
   ```bash
   flutter doctor
   flutter analyze
   ```

4. **Run the app**
   ```bash
   # For iOS Simulator (macOS)
   flutter run -d ios
   
   # For Android Emulator
   flutter run -d android
   
   # Or list available devices
   flutter devices
   ```

## Project Verification Checklist

- ✅ All 31 Dart files created
- ✅ Project structure follows clean architecture
- ✅ All imports verified
- ✅ No linting errors
- ✅ Design system implemented
- ✅ State management with Provider
- ✅ Mock data configured

## Troubleshooting

### Flutter not found
- Add Flutter to your PATH
- On macOS/Linux: Add to `~/.zshrc` or `~/.bashrc`:
  ```bash
  export PATH="$PATH:/path/to/flutter/bin"
  ```

### Dependencies issues
- Run `flutter clean`
- Delete `pubspec.lock`
- Run `flutter pub get` again

### Build errors
- Run `flutter clean`
- Delete `build/` folder
- Run `flutter pub get`
- Try building again

## Next Steps

Once the app is running:
1. Test meal logging functionality
2. Navigate between screens
3. Generate a progress report
4. Test all user flows from the readme

