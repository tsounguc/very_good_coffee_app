# Very Good Coffee ☕

A Flutter application that displays random coffee images from the [Coffee API](https://coffee.alexflipnote.dev) and lets you save your favorites locally. Built with **Clean Architecture**, **BLoC (Cubit)** state management, and **Hive** for persistence.

---

## Features

- Fetch a random coffee image from the API
- Refresh to load a new image
- Save coffee images as favorites
- View saved favorites offline (stored in Hive)
- Loading and error states handled gracefully
- Unit tests for data sources and cubits
- Consistent architecture using Clean Architecture and BLoC

---

## Tech Stack

- [Flutter](https://flutter.dev) (stable channel)
- [BLoC / Cubit](https://bloclibrary.dev) for state management
- [Dartz](https://pub.dev/packages/dartz) for functional error handling
- [Hive](https://pub.dev/packages/hive) for local persistence
- [http](https://pub.dev/packages/http) for API calls
- [get_it](https://pub.dev/packages/get_it) for dependency injection
- [mocktail](https://pub.dev/packages/mocktail) and [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) for testing

---

## Project Structure

ib/ 

┣ core/ # Errors, utils, typedefs, Service locator setup (get_it)

┣ features/coffee/ 

┃ ┣ data/ # Data sources, repositories, models 

┃ ┣ domain/ # Entities, repositories, usecases 

┃ ┣ presentation/ # Cubits, UI (pages & widgets)

┗ main.dart # App entrypoint


---

## Getting Started

### 1. Prerequisites

- Install [Flutter](https://docs.flutter.dev/get-started/install) (>=3.22 recommended)
- Ensure you have Xcode (for iOS) or Android Studio / Android SDK (for Android)

Check your environment:

```bash
flutter doctor
```

### 2. Clone the Repository

git clone https://github.com/tsounguc/very_good_coffee_app.git
cd very_good_coffee_app

### 3. Install Dependencies

flutter pub get

### 4. Run the App

On Android emulator / device:

flutter run


On iOS simulator / device:

flutter run -d ios
