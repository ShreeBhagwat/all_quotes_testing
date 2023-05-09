import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_screen.dart';

void main() {
  runApp(ProviderScope(child: AllQuotes()));
}

class AllQuotes extends StatelessWidget {
  const AllQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
