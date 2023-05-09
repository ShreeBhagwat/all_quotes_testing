import 'package:all_quotes/constant.dart';
import 'package:all_quotes/quotes_notifier.dart';
import 'package:all_quotes/quotes_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockQuotesService implements QuotesService {
//   @override
//   Future<List<Quotes>> getQuotes() async {
//       return [
//         Quotes(id: 1, quote: 'quote1', author: 'author1'),
//         Quotes(id: 2, quote: 'quote2', author: 'author2'),
//         Quotes(id: 3, quote: 'quote3', author: 'author3'),
//       ];
//   }

//   @override
//   // TODO: implement clinet
//   Client get clinet => throw UnimplementedError();
// }

class MockQuotesService extends Mock implements QuotesService {}

void main() {
  late QuotesNotifier sut_quotesNotifier;
  late MockQuotesService mockQuotesService;
  setUp(() {
    mockQuotesService = MockQuotesService();
    sut_quotesNotifier = QuotesNotifier(mockQuotesService);
  });

  test('Should test if initial values are correct', () {
    expect(sut_quotesNotifier.showLoader, false);
    expect(sut_quotesNotifier.quotes, []);
  });


  void getQuotesFunctionCalled() {
    when(() => mockQuotesService.getQuotes())
        .thenAnswer((_) async => mockQuotesForTesting);
  }

  test('Check getQuotes function called', () {
    getQuotesFunctionCalled();
    sut_quotesNotifier.getQuotes();
    verify(() => mockQuotesService.getQuotes()).called(1);
  });

  test(
      '''Loading indicator visible, get quotes, loading indicator not visible''',
      () async {
    getQuotesFunctionCalled();
    final future = sut_quotesNotifier.getQuotes();
    expect(sut_quotesNotifier.showLoader, true);
    await future;
    expect(sut_quotesNotifier.quotes, mockQuotesForTesting);
    expect(sut_quotesNotifier.showLoader, false);
  });
}
