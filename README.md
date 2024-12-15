# GamersTag Stream App

A Flutter application designed using Clean Architecture principles and GetX for state management. The app allows users to manage streaming links with precise UI adherence to provided designs.

## Features

### Functional Features

1. **Add Unlimited Streams**
   - Users can create and add an unlimited number of streams.

2. **URL Checker & Metadata Fetching**
   - Automatically validates streaming platform links pasted by the user.
   - Fetches metadata using a free API such as OpenGraph or Link Preview API to populate:
     - Platform Name (e.g., YouTube, Twitch).
     - Stream/Video Title.
     - Thumbnail Image.

3. **Edit Stream Details**
   - Users can update previously added stream details.

4. **Delete Stream**
   - Users can delete streams with a confirmation dialog.
   - Includes options for **Delete** and **Cancel**.
   - Enhanced user experience with Lottie animations.

5. **Search Functionality**
   - Search bar to locate streams by keywords efficiently.

6. **Pagination**
   - Streams are displayed in a paginated format with 10 streams per page.

7. **Buttons**
   - Functional buttons: **Create Stream**, **Update Stream**, **Delete Stream**, and **Cancel**.
   - All buttons adhere to design specifications and are fully functional.

### UI Features

- All icons used are in SVG format and represent brand icons exclusively.
- Hardcoded UI elements ensure precise alignment with the provided designs.
- Lottie animations are used for enhanced user interaction.

## Tech Stack

- **Framework:** Flutter
- **State Management:** GetX
- **Architecture:** Clean Architecture
- **API Integration:** OpenGraph or Link Preview API for metadata fetching
- **UI Assets:** SVG icons

## Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone <repository-link>
   cd gamerstag_stream_app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **API Key Setup:**
   - If required by the metadata-fetching API, add the API key in `lib/config/api_config.dart`.

4. **Run the App:**
   ```bash
   flutter run
   ```

5. **Build APK:**
   ```bash
   flutter build apk --release
   ```

## Error Handling

- Invalid URLs display error messages, ensuring a smooth user experience.
- Fallback UI in case metadata-fetching API requests fail.

## Folder Structure

```plaintext
lib/
├── core/          # Core utilities (helpers, constants, etc.)
├── data/          # Data layer (models, repositories, etc.)
├── domain/        # Domain layer (entities, use cases, etc.)
├── presentation/  # UI layer (GetX controllers, widgets, screens, etc.)
├── config/        # Configuration files
└── main.dart      # App entry point
```

## Additional Notes

- Ensure a stable internet connection for metadata-fetching functionality.
- Lottie animations are included in `assets/animations/`.
- SVG icons are included in `assets/icons/`.

## Submission Details

- **GitHub Repository:** [Link](<https://github.com/PrakharSinghG/gamerstag_stream_app?tab=readme-ov-file>)
- **APK File:** [Download APK](<https://github.com/PrakharSinghG/gamerstag_stream_app/releases/tag/v1.0.0>)

## License

This project is licensed under the MIT License. See the LICENSE file for details.

