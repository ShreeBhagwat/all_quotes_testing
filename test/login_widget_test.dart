import 'package:all_quotes/constant.dart';
import 'package:all_quotes/login_screen.dart';
import 'package:all_quotes/quotes_notifier.dart';
import 'package:all_quotes/quotes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'widget_tester_extension.dart';

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  testWidgetsMultipleScreenSize('Login-Page', loginWidgetTest);
}

Future<void> loginWidgetTest(
    WidgetTester tester, TestCaseScreenInfo? testCaseScreenInfo) async {
  MockQuotesService mockQuotesService = MockQuotesService();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        quotesNotifierProvider
            .overrideWith((ref) => QuotesNotifier(mockQuotesService))
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    ),
  );

  when(() => mockQuotesService.getQuotes())
      .thenAnswer((_) async => mockQuotesForTesting);

  await tester.pumpAndSettle();

  final loginTextWidget = find.byKey(loginTextLoginScreenKey);
  final emailTextFieldWidget = find.byKey(emailTextFieldLoginScreenKey);
  final passwordTextFieldWidget = find.byKey(passwrodTextFieldLoginScreenKey);
  final loginButtonWidget = find.byKey(loginButtonLoginScreenKey);

  expect(loginTextWidget, findsOneWidget);
  expect(emailTextFieldWidget, findsOneWidget);
  expect(passwordTextFieldWidget, findsOneWidget);
  expect(loginButtonWidget, findsOneWidget);
  await doGoldens(
      'Login-Page', 'Check All Widgets on screen', testCaseScreenInfo);

  // User enters Invalid cerdentials

  await tester.enterText(emailTextFieldWidget, 'abcd');
  await tester.enterText(passwordTextFieldWidget, '1234');

  await tester.tap(loginButtonWidget);
  await tester.pumpAndSettle();
  final emailErrorText = find.text('Enter a valid email address');
  final passwordErrorText =
      find.text('Password must be at least 6 characters long.');

  expect(emailErrorText, findsOneWidget);
  expect(passwordErrorText, findsOneWidget);
  await doGoldens('Login-Page', 'Invalid Credentials', testCaseScreenInfo);

  // User enters valid credentials
  await tester.enterText(emailTextFieldWidget, 'abcd@s.com');
  await tester.enterText(passwordTextFieldWidget, '1234567');
  await tester.tap(loginButtonWidget);
  await tester.pump(const Duration(seconds: 1));
  final loaginIndicatorWidget = find.byKey(loginLoaderIndicatorLoginScreenKey);
    await doGoldens('Login-Page', 'Check loader', testCaseScreenInfo);
  expect(emailErrorText, findsNothing);
  expect(passwordErrorText, findsNothing);
  expect(loaginIndicatorWidget, findsOneWidget);
  await tester.pumpAndSettle();
    await doGoldens('Login-Page', 'Final', testCaseScreenInfo);
}
