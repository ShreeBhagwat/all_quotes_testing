import 'dart:convert';

import 'package:all_quotes/quotes.dart';
import 'package:flutter/material.dart';

final mockJson = {
  'quotes': [
    {'id': 1, 'quote': 'Test quote', 'author': 'Test author'}
  ],
};

final mockQuotes = jsonEncode(mockJson);

final mockQuotesForTesting = [
  Quotes(id: 1, quote: 'quote1', author: 'author1'),
  Quotes(id: 2, quote: 'quote2', author: 'author2'),
  Quotes(id: 3, quote: 'quote3', author: 'author3'),
];

const loginTextLoginScreenKey = ValueKey('loginTextLoginScreenKey');
const emailTextFieldLoginScreenKey = ValueKey('emailTextFieldLoginScreenKey');
const passwrodTextFieldLoginScreenKey =
    ValueKey('passwrodTextFieldLoginScreenKey');
const loginButtonLoginScreenKey = ValueKey('loginButtonLoginScreenKey');
const loginLoaderIndicatorLoginScreenKey =
    ValueKey('loginLoaderIndicatorLoginScreenKey');
const circulaorIndicatorAllQuotesScreenKey =
    ValueKey('circulaorIndicatorAllQuotesScreenKey');
