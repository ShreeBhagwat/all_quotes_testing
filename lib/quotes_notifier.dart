import 'dart:developer';

import 'package:all_quotes/quotes.dart';
import 'package:all_quotes/quotes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class QuotesNotifier extends ChangeNotifier {
  final QuotesService _quotesService;

  QuotesNotifier(this._quotesService);

  bool _showLoader = false;
  bool get showLoader => _showLoader;

  List<Quotes> _quotes = [];
  List<Quotes> get quotes => _quotes;

  Future getQuotes() async {
    _showLoader = true;
    notifyListeners();
    _quotes = await _quotesService.getQuotes();
    _showLoader = false;
    notifyListeners();
  }
}

final _client = Client();

final quotesNotifierProvider =
    ChangeNotifierProvider((ref) => QuotesNotifier(QuotesService(_client)));
