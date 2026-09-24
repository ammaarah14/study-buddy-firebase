
## Included
- Firebase initialization using the supplied `firebase_options.dart`.
- Firebase Authentication: email/password sign up, login and logout.
- Cloud Firestore: user profiles, subjects and tasks.
- Dashboard progress tracking.
- Task creation, completion, deletion, priority and due date.
- Subject creation and deletion.
- Material 3 UI.

## Install
1. Back up your existing project.
2. Replace the existing `lib/` folder with this package's `lib/` folder.
3. Replace your root `pubspec.yaml`, or add `cloud_firestore` to your existing dependencies.
4. Keep your existing `android/`, `ios/`, `web/`, `windows/`, `macos/` and `linux/` folders.
5. Keep `lib/firebase_options.dart` from this package; it is configured for the existing Firebase project.
6. Run `flutter clean`, `flutter pub get`, then `flutter run`.

## Firebase console
Enable Authentication > Sign-in method > Email/Password.
Enable/create Cloud Firestore for the same Firebase project.

The included `firestore.rules` restricts each signed-in user to their own `/users/{uid}` document and subcollections. Deploy it from the project root if needed with Firebase CLI, or paste equivalent rules into Firestore Rules in the Firebase console.

## Intentionally excluded
Generated/build/cache/IDE files such as `.dart_tool/`, `build/`, `.idea/`, `.vscode/`, `.flutter-plugins-dependencies`, and `*.iml` are not included.
