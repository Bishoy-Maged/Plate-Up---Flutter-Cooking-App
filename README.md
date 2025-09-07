🍽️ Plate Up
Plate Up is a Flutter mobile application that helps users explore, view, and manage recipes in a clean and intuitive interface. The app follows the MVVM (Model–View–ViewModel) architecture and uses Provider for efficient state management. Recipes are stored in Firebase Firestore, making the app scalable and cloud-based.

✨ Features:
🎨 Clean & User-Friendly UI – Modern, responsive, and intuitive design.
📚 Recipe Management – Stores and displays recipes from Firestore including:
Recipe name
Calories
Time to cook
Rating
Ingredients (name, image, amount)
Cooking instructions
❤️ Favorites – Users can add or remove recipes from their favorites list, which is displayed in a dedicated Favorites Screen.
🔄 State Management – Built with the Provider package for efficient and reactive UI updates.

🏛️ Architecture
The project follows the MVVM Architecture:
Model – Data layer, including Firestore integration and recipe data structures.
View – UI screens and widgets (Views/ and Widget/ folders).
ViewModel – Business logic and state handled via Provider (Provider/ folder).

This separation of concerns ensures scalability, testability, and maintainability.


📂 Project Structure
lib/
 ┣ Provider/                # State management (ViewModels)
 ┣ Utils/                   # Constants & helper utilities
 ┣ Views/                   # Screens (UI pages)
 ┣ Widget/                  # Reusable widgets
 ┣ firebase_options.dart    # Firebase configuration
 ┣ main.dart                # App entry point



🛠️ Tech Stack
Framework: Flutter
State Management: Provider
Backend: Firebase Firestore
Language: Dart


📄 License
This project is licensed under the MIT License – see the LICENSE file for details.
