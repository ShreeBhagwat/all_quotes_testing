import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'all_quotes_screen.dart';
import 'constant.dart';
import 'login_notifier.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  // create a golbal form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Login Screen',
                  key: loginTextLoginScreenKey,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: emailTextFieldLoginScreenKey,
                  validator: (value) {
                    const pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                    final regex = RegExp(pattern);

                    return (value != null && !regex.hasMatch(value))
                        ? 'Enter a valid email address'
                        : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: passwrodTextFieldLoginScreenKey,
                  validator: (value) {
                    if (value != null && value.length <= 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    key: loginButtonLoginScreenKey,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        loginProvider.login().then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AllQuotesScreen(),
                            ),
                          );
                        });
                      }
                    },
                    child: loginProvider.showLoader
                        ? const Center(
                            child: CircularProgressIndicator(
                              key: loginLoaderIndicatorLoginScreenKey,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Login',
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
