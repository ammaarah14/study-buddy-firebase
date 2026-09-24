import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:study_buddy_firebase/screens/auth/login_screen.dart';
import 'package:study_buddy_firebase/screens/auth/signup_screen.dart';

void main() {
  group('LoginScreen widget tests', () {
    testWidgets('displays the login screen correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Study Buddy'), findsOneWidget);

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
      expect(find.text('Create an account'), findsOneWidget);
    });

    testWidgets('opens the create account screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.tap(find.text('Create an account'));
      await tester.pumpAndSettle();

      expect(find.byType(SignupScreen), findsOneWidget);
    });

    testWidgets('shows login validation messages for empty fields',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.tap(find.text('Log in'));
      await tester.pump();

      expect(find.text('Enter a valid email.'), findsOneWidget);
      expect(find.text('Use at least 6 characters.'), findsOneWidget);
    });
  });

  group('SignupScreen widget tests', () {
    testWidgets('displays the signup form correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      expect(find.byType(SignupScreen), findsOneWidget);
      expect(find.text('Create account'), findsNWidgets(2));
      expect(find.text('Start your study journey'), findsOneWidget);

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('shows validation messages for invalid signup details',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.text('Enter a valid email.'), findsOneWidget);
      expect(find.text('Use at least 6 characters.'), findsOneWidget);
    });

    testWidgets('accepts valid email and password input', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignupScreen(),
        ),
      );

      final fields = find.byType(TextFormField);

      await tester.enterText(fields.at(0), 'test@example.com');
      await tester.enterText(fields.at(1), 'password123');

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });
  });
}