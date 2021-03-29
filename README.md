# About
Ma’arefah Application is inspired by a real initiative in Collge of Computer Science & Information Technology  at Imam Abdulrahman  bin Faisal University in Saudi Arabia. The application will help to digitize the initiative and keep the initiative going during these times of COVID-19 spread. The application will enable peer-to-peer teaching where volunteering students from a higher academic level will be able to conduct online sessions through zoom meetings teaching the hard concepts in college courses and enable learning students to register and attend those sessions then rate the tutor.

## This repo contains a flutter Firebase app thats implements single code for 3 platforms:
1. Web Chrome for Admin Pages
2. IOS mobile app for the end-users: Learners & Tutors
3. Android mobile app for the end-users: Learners & Tutors.

## Requirements 
- Any Operating System (ie. MacOS X, Linux, Windows)
- Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)

## Installation
Open the ide and run  ```flutter pub get```

## Usage
1. Make sure your device/emulator is running.
2. Run ```flutter run```



## Running the project with Firebase

To use this project with Firebase, some configuration steps are required.
- Create a new project with the Firebase console.
- Add iOS and Android apps in the Firebase project settings.
- On Android, use com.example.flutter_app_1 as the package name.
- then, [download & copy](https://firebase.google.com/docs/flutter/setup#configure_an_android_app) google-services.json into android/app.
- On iOS, use com.example.flutterApp1 as the bundle ID.
- then, [download & copy](https://firebase.google.com/docs/flutter/setup#configure_an_ios_app) GoogleService-Info.plist into iOS/Runner, and add it to the Runner target in Xcode.
- finally, enable the Email/Password Authentication Sign-in provider in the Firebase Console (Authentication > Sign-in method > Email/Password > Edit > Enable > Save)

See this page for full instructions:

(https://firebase.flutter.dev/docs/overview/)

## Running Admin Pages on Flutter Web
- To test this, add a web app in the Firebase project settings, and export the generated ```firebaseConfig``` variable in your project
```export var firebaseConfig = {
    apiKey: "<your-api-key>",
    authDomain: "<your-auth-domain>",
    databaseURL: "<your-database-url>",
    projectId: "<your-project-id>",
    storageBucket: "<your-storage-bucket>",
    messagingSenderId: "<your-messaging-sender-id>",
    appId: "<your-app-id>",
    measurementId: "<your-measurement-id>"
};
```
This is then imported in the index.html file:
```<script src="https://www.gstatic.com/firebasejs/8.3.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-storage.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-analytics.js"></script>
```

- to run on flutter web you can see the folders inside Lib/Admin/
- run on admin_homepage.dart

