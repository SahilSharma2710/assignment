# Task Management App

A Flutter application for managing tasks with Firebase integration. This app allows users to create, read, update, and delete tasks while providing user authentication and real-time data synchronization.

## Features

- **User Authentication**
  - Email and password sign-up
  - Secure login functionality
  - Logout capability

- **Task Management**
  - Create new tasks with title and description
  - Set task priority (High, Medium, Low)
  - Edit existing tasks
  - Delete tasks with confirmation
  - Real-time task list updates

- **UI/UX**
  - Clean and modern Material Design
  - Priority-based color coding for tasks
  - Responsive layout
  - Loading states and error handling
  - Form validation

## Prerequisites

Before running the application, make sure you have the following installed:

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Firebase CLI
- A code editor (VS Code, Android Studio, etc.)
- Git

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd miles_assignment
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication and Firestore in your Firebase project
   - Add your Flutter application to Firebase:
     ```bash
     flutterfire configure
     ```
   - This will automatically generate the `firebase_options.dart` file

4. **Run the Application**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
  ├── models/
  │   ├── priority.dart        # Priority enum definition
  │   └── task.dart           # Task model class
  ├── providers/
  │   └── providers.dart       # Riverpod providers
  ├── screens/
  │   ├── home_screen.dart     # Main task list screen
  │   ├── signin_screen.dart   # Login screen
  │   ├── signup_screen.dart   # Registration screen
  │   └── add_edit_task.dart   # Task creation/editing screen
  ├── services/
  │   ├── auth_service.dart    # Firebase authentication service
  │   └── task_service.dart    # Firestore task operations
  ├── widgets/
  │   ├── custom_text_field.dart # Reusable text input widget
  │   └── task_item.dart        # Task list item widget
  ├── firebase_options.dart
  └── main.dart                # Application entry point
```

## State Management

The application uses Riverpod for state management, providing:
- Reactive state updates
- Dependency injection
- Stream handling for real-time data
- Clean and testable code structure

## Firebase Integration

The app uses the following Firebase services:
- **Authentication**: For user management
- **Cloud Firestore**: For storing and syncing task data
- **Firebase Core**: For Firebase initialization

## Error Handling

The application includes comprehensive error handling for:
- Authentication errors
- Network issues
- Invalid input validation
- Database operation failures

## Additional Notes

- The app follows Material Design guidelines
- Tasks are automatically sorted by creation date
- All data is persisted in real-time
- The UI is optimized for both light and dark themes
- Form validation ensures data integrity

