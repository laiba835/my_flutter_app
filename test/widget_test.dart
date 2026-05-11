import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());
    
    // Wait for splash screen to navigate
    await tester.pump(const Duration(seconds: 2));
    
    // Verify login screen appears
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Login screen has email and password fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    
    // Find email and password fields
    expect(find.byType(TextFormField), findsAtLeast(2));
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('Navigate to registration screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    
    // Tap on Register button
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    
    // Verify registration screen appears
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Register'), findsWidgets);
  });
}