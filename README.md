# Penny Wise

A personal finance management application built with Flutter and Firebase.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Installation](#installation)

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

### Login Screen
![Login Screen](screenshots/login_screen.png)

### Dashboard
![Home Dashboard](screenshots/home_dashboard.png)

### Add Expense
![Add Expense](screenshots/add_expense.png)

### Expense List
![Expense List](screenshots/expense_list.png)

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