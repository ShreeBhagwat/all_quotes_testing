import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifer extends ChangeNotifier {
  bool _showLoader = false;
  bool get showLoader => _showLoader;

  Future login() async {
    log('loader true');
    _showLoader = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2), () {
      _showLoader = false;
      log('loader false');
      notifyListeners();
    });
  }
}

final loginNotifierProvider = ChangeNotifierProvider((ref) => LoginNotifer());
