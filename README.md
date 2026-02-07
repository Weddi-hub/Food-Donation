# Food Donation Tracker

A Flutter-based mobile application designed to streamline the process of donating excess food. This app allows users to track their donations, manage their donation history, and connect with a community focused on reducing food waste.

## 🚀 Features

-   **User Authentication**: Secure Login, Sign-up, and Forgot Password functionality powered by Firebase Authentication.
-   **Splash Screen**: Professional entry screen on app launch.
-   **Home Dashboard**: A clean and intuitive interface to manage and view food donations.
-   **Donation Management**: 
    -   Create new food donation entries easily via a dedicated bottom sheet.
    -   Track details such as food type, quantity, and pick-up availability.
    -   View personal donation history in "My Donations".
-   **Real-time Synchronization**: Data is stored and updated in real-time using Cloud Firestore.
-   **Modern UI**: Built with Material 3 design principles for a polished and responsive user experience.
-   **State Management**: Efficiently handles app state using the `Provider` package.

## 🛠️ Built With

-   [Flutter](https://flutter.dev/) - UI Toolkit for building natively compiled applications.
-   [Firebase Auth](https://firebase.google.com/docs/auth) - For secure user authentication.
-   [Cloud Firestore](https://firebase.google.com/docs/firestore) - NoSQL cloud database for real-time data storage.
-   [Provider](https://pub.dev/packages/provider) - State management library.
-   [Intl](https://pub.dev/packages/intl) - Internationalization and date formatting.

## 📁 Project Structure

```text
lib/
├── models/         # Data models (Donation, etc.)
├── screens/        # UI screens (Auth, Home, Splash)
│   ├── auth/       # Login, Signup, Forgot Password
│   └── home/       # Home page, Donation list, New donation form
├── services/       # Firebase and business logic services
├── widgets/        # Reusable UI components
└── main.dart       # App entry point
```

## ⚙️ Getting Started

### Prerequisites

-   Flutter SDK installed on your machine.
-   A Firebase project set up for Android/iOS.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/food_donation_tracker.git
    cd food_donation_tracker
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure Firebase**:
    -   Follow the [Firebase Flutter Setup](https://firebase.google.com/docs/flutter/setup) guide.
    -   Ensure `firebase_options.dart` is correctly configured in the `lib` folder.

4.  **Run the app**:
    ```bash
    flutter run
    ```

## 📸 Screenshots

![Pic1](https://github.com/user-attachments/assets/0719dbdf-de0e-4e98-8d20-e0bbbc41745a)
![Pic2](https://github.com/user-attachments/assets/2edd3c3d-fd79-48b4-833e-3df908f0b10b)
![Pic3](https://github.com/user-attachments/assets/8c2fa535-7c0a-4833-acb3-64d37eccc0c6)
![Pic4](https://github.com/user-attachments/assets/2d0f12c7-140e-4b85-bd29-d75ff688cca8)
![Pic5](https://github.com/user-attachments/assets/ca3076c5-3043-47c7-a2ca-a8765140fb4e)
![Pic6](https://github.com/user-attachments/assets/9f05ff54-94ff-46fd-a00b-00f5c10dbf4c)







## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve the project.
