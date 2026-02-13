# Penny Wise

A personal finance management application 

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Installation](#installation)
- [Configuration](#configuration)

---

## Overview

Penny Wise is a cross-platform mobile application designed to help individuals track and manage their personal expenses. The application provides seamless synchronization across devices while supporting offline functionality through local storage.

**Key Features:**
- Cross-platform support 
- Offline-first architecture
- Real-time data synchronization
- Secure user authentication
- Visual expense analytics

---

## Features

### User Authentication
- Email/password registration and login
- Password recovery functionality
- Persistent authentication state
- Secure user session management

### Expense Management
- Create, read, update, and delete expenses
- Categorize expenses (Food, Transport, Shopping, Entertainment, Bills, Health, Other)
- Add descriptions and dates to transactions
- Currency support in Shekels (₪)

### Data Synchronization
- Automatic background synchronization with Firebase
- Offline-first architecture for uninterrupted access
- Conflict resolution mechanisms
- Sync status indicators
- Manual sync option

### Financial Analytics
- Monthly expense summaries
- Category-wise spending breakdown
- Interactive pie charts
- Recent transactions view
- Expense filtering by category

---

## Screenshots

### Register Screen
<img width="590" height="1280" alt="Register Screen" src="https://github.com/user-attachments/assets/22c3e1ea-7ba7-4a11-ae88-0876603b3f19" />

### Home Dashboard
<img width="664" height="1280" alt="Home Dashboard" src="https://github.com/user-attachments/assets/faedfa23-2de3-4cad-b490-272d3abaa5c6" />

### Add Expense
<img width="623" height="1280" alt="Add Expense" src="https://github.com/user-attachments/assets/99fa52bb-f391-43d7-9d7f-33e2be8a5bef" />

### Expense List
<img width="666" height="1280" alt="Expense List" src="https://github.com/user-attachments/assets/74df5585-81ba-4a92-87e2-1550b20e8c44" />

---

## Technology Stack

### Frontend
- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Material Design 3** - UI design system

### Backend
- **Firebase Authentication** - User authentication service
- **Firebase Realtime Database** - Cloud database
- **SQLite** - Local data persistence

### State Management
- **BLoC Pattern** - Business Logic Component architecture
- **flutter_bloc** - State management library

---

## Architecture

The application follows Clean Architecture principles with three distinct layers:

### Presentation Layer
- UI components and screens
- BLoC state management
- User interaction handling
- Navigation logic

### Domain Layer
- Business entities
- Use cases
- Repository interfaces
- Business rules

### Data Layer
- Repository implementations
- Local data source (SQLite)
- Remote data source (Firebase)
- Data models and transformations

---

## Installation

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Android Studio or Xcode
- Firebase account

### Steps

1. Clone the repository
```bash
git clone https://github.com/yourusername/penny-wise.git
cd penny-wise
```

2. Install dependencies
```bash
flutter pub get
```

3. Set up Firebase
   - Create a Firebase project at Firebase Console
   - Add Android/iOS apps to your project
   - Download configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS
   - Place files in their respective directories

4. Enable Firebase services
   - Enable Authentication with Email/Password
   - Enable Realtime Database
   - Configure database security rules

5. Run the application
```bash
flutter run
```

---

## Configuration

### Firebase Realtime Database Rules

```json
{
  "rules": {
    "users": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid"
      }
    }
  }
}
```
