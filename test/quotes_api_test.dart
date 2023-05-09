import 'dart:convert';

import 'package:all_quotes/constant.dart';
import 'package:all_quotes/quotes.dart';
import 'package:all_quotes/quotes_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Testing Modal Class', () {
    final quote = Quotes(id: 1, quote: 'Test quote', author: 'Test author');
    expect(quote.id, 1);
    expect(quote.quote, 'Test quote');
    expect(quote.author, 'Test author');
  });

  test('Testing fromJson function', () {
    final data = jsonDecode(mockQuotes);
    final quote =
        data['quotes'].map((quote) => Quotes.fromJson(quote)).toList();

    expect(quote[0].id, 1);
    expect(quote[0].quote, 'Test quote');
    expect(quote[0].author, 'Test author');
  });

  test('Quotes Api Testing', () async {
    Future<Response> _mockHttp(Request request) async {
      if (request.url.toString() == 'https://dummyjson.com/quotes') {
        return Response(mockQuotes, 200,
            headers: {'content-type': 'application/json'});
      }

      return throw Exception('Http Testing Failed');
    }

    final client = MockClient(_mockHttp);

    final apiService = QuotesService(client);
    final quotes = await apiService.getQuotes();

    expect(quotes[0].id, 1);
    expect(quotes[0].quote, 'Test quote');
    expect(quotes[0].author, 'Test author');
  });
}
