# emombti

A Flutter application focused on MBTI (Myers-Briggs Type Indicator) personality types. Explore, analyze, and interact with personality insights.

## 🚀 Features

Based on the integrated modules, **emombti** offers:

*   **Personality Insights:** In-depth content regarding MBTI types.
*   **Interactive UI:** Smooth transitions and carousels using `carousel_slider`.
*   **Multimedia Support:** Integration of high-quality SVGs, network images, and video playback.
*   **Voice Interaction:** Support for Speech-to-Text (`speech_to_text`) for hands-free input.
*   **Hardware Integration:**
    *   **Scanner:** Built-in QR and Barcode scanning using `mobile_scanner`.
    *   **Sensors:** Utilization of device sensors via `sensors_plus`.
*   **Notifications:** Local system notifications for engagement.
*   **Web Integration:** In-app browser experiences via `webview_flutter`.
*   **Social Sharing:** Easily share personality results using `share_plus`.

## 🛠 Tech Stack

*   **Framework:** Flutter
*   **State Management:** Provider
*   **Navigation:** GoRouter
*   **Data Modeling:** Freezed & JSON Serializable
*   **Networking:** HTTP
*   **Storage:** Shared Preferences

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

*   **Flutter SDK:** `^3.11.1` (Refer to `pubspec.yaml`)
*   **Dart SDK:** Compatible with the Flutter version above.
*   **Android Studio / VS Code** with Flutter extensions.

## ⚙️ Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd emombti
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Generate code (Freezed/JSON Models):**
    Since this project uses `build_runner`, generate the necessary files by running:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

## 📁 Project Structure

*   `lib/`: Main source code.
*   `assets/json/`: Configuration and static data files.
*   `assets/images/`: Local image assets and logos.
*   `assets/policies/`: Legal and privacy policy documents.

## 📱 Platform Specifics

*   **Android:** Minimum SDK 21 (as configured for launcher icons).
*   **Permissions:** Ensure you have configured Camera (for `mobile_scanner`), Microphone (for `speech_to_text`), and Internet permissions in your `AndroidManifest.xml` and `Info.plist`.

## 📄 License

This project is set to `publish_to: 'none'` in the pubspec. 

---
*Version 0.1.0+1*
