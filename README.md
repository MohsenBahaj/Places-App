# Places App

Places App is a Flutter mobile app for saving memorable places with a title, a photo, and a precise location. Users can capture an image with the camera, choose their current GPS position or pick a point on Google Maps, and store everything locally on the device using SQLite.

## What the app does

The current app flow in this repository is:

1. Open the app and load saved places from local SQLite storage.
2. Tap the add button to create a new place.
3. Enter a title.
4. Capture a photo using the device camera.
5. Choose a location either by:
   - using the current device location, or
   - selecting a point on an interactive Google Map
6. Save the place locally.
7. View saved places in a list.
8. Open a place to see its photo, address, static map preview, and full map view.

## Features currently implemented

- Riverpod-based state management for the saved places list
- SQLite persistence with `sqflite`
- Image capture with `image_picker`
- Device location access with `location`
- Interactive Google Maps picker with `google_maps_flutter`
- Reverse geocoding through the Google Geocoding API
- Static map preview on the place details screen
- Local image copy into the app documents directory

## Tech stack

- Flutter
- Dart
- `flutter_riverpod`
- `sqflite`
- `image_picker`
- `location`
- `http`
- `google_maps_flutter`
- `path` / `path_provider`
- `google_fonts`

## Project structure

```text
lib/
  main.dart
  models/
    place.dart
  providers/
    places_provider.dart
  screens/
    add_place.dart
    map.dart
    place_details.dart
    places.dart
  widgets/
    image_picker.dart
    location.dart
    places_list.dart
```

## Requirements

Before running the app, make sure you have:

- Flutter SDK installed
- An emulator or physical Android/iOS device
- A Google Maps Platform API key

## Google Maps and Geocoding setup

This repository still contains placeholder values like `Enter your API key here.` and needs a real Google API key before maps and address lookup will work.

Enable the APIs used by the code:

- Maps SDK for Android
- Maps SDK for iOS
- Geocoding API
- Static Maps API

Then add your key in these files:

- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/AppDelegate.swift`
- `ios/Runner/Info.plist`
- `lib/widgets/location.dart`
- `lib/screens/place_details.dart`

## Getting started

```bash
flutter pub get
flutter run
```

## How data is stored

- Place metadata is stored in a local SQLite database named `place.db`
- Images are copied into the app documents directory before saving
- Saved places are loaded on app startup

## Screens

### 1. Places list

Shows all saved places. If no places exist yet, the app displays an empty-state message.

### 2. Add new place

Lets the user enter:

- a title
- a camera image
- a selected location

### 3. Map picker

Allows the user to tap on Google Maps and save the selected coordinates.

### 4. Place details

Shows:

- the saved image
- the resolved address
- a static map preview
- navigation into a larger map screen

## Screenshots

<div align="center">
  <table style="width: 100%; border-collapse: collapse;">
    <tr>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/my%20places%20list.png" width="90%" alt="Home"/><br/>
        <b>Home</b>
      </td>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/add%20%20a%20new%20place.jpg" width="90%" alt="Add Place"/><br/>
        <b>Add Place</b>
      </td>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/place%20details.png" width="90%" alt="Place Details"/><br/>
        <b>Place Details</b>
      </td>
    </tr>
    <tr>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/pick%20location.png" width="90%" alt="Pick Location"/><br/>
        <b>Pick Location</b>
      </td>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/fetch%20current%20location.jpg" width="90%" alt="Fetch Location"/><br/>
        <b>Fetch Location</b>
      </td>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/preview%20a%20saved%20location.png" width="90%" alt="Preview Location"/><br/>
        <b>Preview Location</b>
      </td>
    </tr>
    <tr>
      <td width="33.33%" align="center">
        <img src="lib/assets/screenshots/app%20poster.png" width="90%" alt="App Poster"/><br/>
        <b>App Poster</b>
      </td>
      <td width="33.33%"></td>
      <td width="33.33%"></td>
    </tr>
  </table>
</div>

## Notes about the current codebase

- The app is primarily implemented for mobile use because it depends on camera, location, and Google Maps flows.
- The repository includes Flutter platform folders for Android, iOS, web, Windows, Linux, and macOS, but the main feature set is clearly targeted at Android and iOS.
- The test file in `test/widget_test.dart` is still the default Flutter counter example and does not reflect the actual app behavior yet.

## Possible future improvements

- Add form validation for missing image and location
- Replace hardcoded API placeholders with environment-based configuration
- Add delete and edit place support
- Add real widget and integration tests
- Improve permission handling and error messages
- Add polished screenshot assets to this README

## License

This project currently does not include a license file.
