import 'package:all_quotes/all_quotes_screen.dart';
import 'package:all_quotes/constant.dart';
import 'package:all_quotes/quotes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:all_quotes/quotes_service.dart';

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  testAllQuotesScreen();
}

Future<void> testAllQuotesScreen() async {
  testWidgets('All Quotes Widget Test', (tester) async {
    MockQuotesService mockQuotesService = MockQuotesService();

    when(() => mockQuotesService.getQuotes()).thenAnswer((_) async {
      return await Future.delayed(
          const Duration(seconds: 2), () => mockQuotesForTesting);
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          quotesNotifierProvider.overrideWith(
            (ref) => QuotesNotifier(mockQuotesService),
          ),
        ],
        child: MaterialApp(
          home: AllQuotesScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));
    expect(find.byKey(circulaorIndicatorAllQuotesScreenKey), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byKey(circulaorIndicatorAllQuotesScreenKey), findsNothing);
    expect(find.text('quote1'), findsOneWidget);
  });
}
