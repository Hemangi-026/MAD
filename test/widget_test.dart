// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/main.dart';

void main() {
  testWidgets('student companion navigates through the main flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Campusly'), findsOneWidget);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.tap(find.text('Sign in'));
    await tester.pump();
    expect(find.text('Enter a valid university email'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);

    await tester.tap(find.text("Don't have an account? Create one"));
    await tester.pumpAndSettle();
    expect(find.text('Create your account'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full name'),
      'Alex Morgan',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'University email'),
      'alex@university.edu',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Create password'),
      'student123',
    );
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Your modules'), findsOneWidget);
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('Timetable'), findsOneWidget);
    expect(find.text('Assignments'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Faculty'), findsOneWidget);
    expect(find.text('Event Gallery'), findsOneWidget);

    await tester.tap(find.text('RP'));
    await tester.pumpAndSettle();
    expect(find.text('Student profile'), findsOneWidget);
    expect(find.text('Rahul Patel'), findsOneWidget);
    expect(find.text('24CE001'), findsOneWidget);
  });
}
