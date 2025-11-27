# Health Monitor System

**A comprehensive solution for real-time health tracking and data visualization.**

## Overview
The **Health Monitor System** is a cross-platform mobile application built with **Flutter** that enables users to monitor vital health metrics in real-time. The system likely interfaces with hardware sensors (via C++/native integration) to collect data, which is then visualized on a user-friendly dashboard and synchronized continuously with **Firebase** for cloud storage and remote access.

## ✨ Key Features
*   **Interactive Dashboard:** A clean, real-time graphical interface (`dashboard.dart`) for viewing health parameters.
*   **Cloud Integration:** Seamless data synchronization and backend management using **Firebase**.
*   **User Management:** Secure handling of user profiles and health records (`userModel.dart`).
*   **Hardware/Native Integration:** Utilizes C++ and CMake for efficient low-level data processing or hardware communication.

## 🛠️ Tech Stack
*   **Mobile Framework:** Flutter (Dart 37.5%)
*   **Native/Hardware Logic:** C++, CMake (55%+)
*   **Backend/BaaS:** Firebase (Auth, Firestore/Realtime DB)
*   **Architecture:** MVC/MVVM pattern with custom widgets

## 📸 Project Visuals & Demo

You can view the project demonstration and screenshots via the links below:

### 📂 [View Full Project Drive Folder](https://drive.google.com/drive/folders/17w3HDvKYEf5WIaB31X_lUooz--jcwUXJ?usp=sharing)

| Screenshot 1 | Screenshot 2 | Video Demo |
|:---:|:---:|:---:|
| ![Screenshot 1](https://drive.google.com/file/d/1o53b9NmHEnwVpJmOduW1Uw-ZXe02DBzi/view?usp=sharing) | ![Screenshot 2](https://drive.google.com/file/d/1oPH9dlxjp7ucINz6oZL2eqJSw4KLZmno/view?usp=sharing) | [▶️ Watch Video](https://drive.google.com/file/d/1FNiiFdYXnrrzvVD4rbcojgwXBqnA7W_E/view?usp=drive_link) |

*(Note: If images do not render directly due to Drive security settings, please click the links to view them.)*

## 🚀 Getting Started

### Prerequisites
*   **Flutter SDK:** Latest stable version.
*   **IDE:** VS Code or Android Studio with Flutter/Dart plugins.
*   **C++ Build Tools:** CMake (for compiling native components).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/om-vastre/Health-Monitor-System.git
    ```

2.  **Install Dependencies:**
    ```bash
    cd Health-Monitor-System
    flutter pub get
    ```

3.  **Firebase Configuration:**
    *   This project relies on `firebase_options.dart`. Ensure you have your valid Firebase configuration set up for the app to launch correctly.

4.  **Run the App:**
    ```bash
    flutter run
    ```

## 📂 Project Structure
```text
lib/
├── custom_widget.dart   # Reusable UI components
├── dashboard.dart       # Main visualization screen
├── firebase_options.dart# Firebase configuration
├── main.dart            # App entry point
└── userModel.dart       # Data modeling
```

## Contact
**om-vastre** - [GitHub Profile](https://github.com/om-vastre)

## Drive Link (All Documents):
https://drive.google.com/drive/folders/17w3HDvKYEf5WIaB31X_lUooz--jcwUXJ?usp=sharing
