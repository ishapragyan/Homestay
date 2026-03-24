# HomeStay – Hotel Reservation App

A modern and clean **Hotel Booking Flutter App** built to showcase UI/UX design, state management, and Firebase integration.

---

## Features

**Firebase Authentication**

    * Login & Signup
    * Persistent user session

**Hotel Listing**

    * Featured hotels
    * Dynamic hotel list from Firebase

**Search Functionality**

    * Search by hotel name or location

️**Favorites System**

    * Add/remove favorite hotels
    * Real-time updates using Provider

**Profile Screen**

    * Displays logged-in user email
    * Logout functionality

**Clean UI/UX**

    * Structured layout
    * Responsive design
    * Smooth navigation

---

## Tech Stack

* **Flutter (UI Development)**
* **Firebase**

    * Authentication
    * Firestore Database
* **Provider (State Management)**

---

## Project Structure

```
lib
├─ data
│   └─ hotel_data.dart
├─ models
│   └─ hotel.dart
├─ providers
│   ├─ auth_provider.dart
│   ├─ favorites_provider.dart
│   └─ hotel_provider.dart
├─ screens
│   ├─ auth
│   │   ├─ login_screen.dart
│   │   └─ signup_screen.dart
│   ├─ home_screen.dart
│   ├─ favorites_screen.dart
│   ├─ profile_screen.dart
│   ├─ edit_profile_screen.dart
│   ├─ hotel_details_screen.dart
│   └─ main_screen.dart
├─ services
│   └─ auth_service.dart
├─ widgets
│   └─ hotel_card.dart
└─ main.dart
```

---

## What I Learned

* Managing app state using **Provider**
* Integrating **Firebase Authentication & Firestore**
* Structuring a scalable Flutter project
* Building reusable UI components
* Improving UI/UX for real-world apps

---

## Screenshots

![Edit Profile](./screenshot/HomeStay_Edit_Profile_Screen.jpg)
![Favorite Screen](./screenshot/HomeStay_FavoriteScreen.jpg)
![Home Screen](./screenshot/HomeStay_HomeScreen.jpg)
![Hotel Detail](./screenshot/HomeStay_Hotel_Detail_Screen.jpg)
![Profile Screen](./screenshot/HomeStay_ProfileScreen.jpg)
![Sign In](./screenshot/HomeStay_Signin.jpg)
![Sign Up](./screenshot/HomeStay_signup.jpg)

---

##  Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/ishapragyan/Homestay.git
```

2. Navigate to the project:

```bash
cd HomeStay
```

3. Install dependencies:

```bash
flutter pub get
```

4. Add Firebase configuration:

* Create a Firebase project
* Add Android app
* Download `google-services.json`
* Place it in `/android/app`

5. Run the app:

```bash
flutter run
```

---

## Future Improvements

*  Booking system
*  Payment integration
*  Dark mode
*  Advanced filters
*  Reviews & ratings system

---

##  Author

Built with love by **Isha Pragyan Acharya**

---

## Note

This project was built as a **portfolio project** to demonstrate Flutter development skills for internship opportunities.
