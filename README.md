# Cupertino Studios

A modern, multi-platform Flutter web and mobile application designed to serve as the digital hub for Cupertino Studios.

## ✨ Features

* Clean, scalable Flutter architecture
* Full cross-platform support (iOS, Android, Web, Desktop)
* Modular codebase for easy feature expansion
* Admin dashboard integration
* Interactive support and feedback pages
* Dark mode / Theming support
* Firebase integration

## 🏁 Getting Started

This is a Flutter project built with maintainability and growth in mind. To get started:

### 1. Prerequisites

* [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.0)
* Dart enabled
* Firebase project configured (optional but recommended)

### 2. Clone the Repository

```bash
git clone https://github.com/Modexanderson/cupertino_studios.git
cd cupertino_studios
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
flutter run -d chrome     # For web
dart run lib/main.dart    # For CLI debugging (if supported)
```

## 🗂️ Project Structure

```
lib/
├── config/             # App-wide constants and settings
├── models/             # Data models
├── screens/            # UI Screens (Home, Admin, Support, etc.)
├── services/           # Firebase and API logic
├── theme/              # App theming
├── utils/              # Utility functions
├── widgets/            # Reusable UI components
├── main.dart           # Entry point
```

## 🔧 Configuration

Firebase setup requires the `firebase_options.dart` file which is already provided. Make sure to link it with your Firebase project.

You may also need to configure `cors.json` and `firebase.json` when deploying to web.

## 🧪 Testing

```bash
flutter test
```

## 📦 Deployment

For web deployment:

```bash
flutter build web
```

Deploy contents of `/build/web` to your preferred hosting provider.

## 📚 Resources

* [Flutter Documentation](https://flutter.dev/docs)
* [Firebase Docs](https://firebase.google.com/docs)

## 👨‍💻 Author

**Modexanderson**

---

Feel free to contribute by submitting issues or pull requests!
