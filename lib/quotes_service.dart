import 'dart:convert';

import 'package:all_quotes/quotes.dart';
import 'package:http/http.dart' as http;

class QuotesService {
  final http.Client clinet;

  QuotesService(this.clinet);

  Future<List<Quotes>> getQuotes() async {
    final quotesUri = Uri.parse('https://dummyjson.com/quotes');
    final response = await clinet.get(quotesUri);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final quotes = decodedData['quotes']
          .map<Quotes>((quote) => Quotes.fromJson(quote))
          .toList();

      return quotes;
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
 