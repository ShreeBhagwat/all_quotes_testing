import 'package:all_quotes/constant.dart';
import 'package:all_quotes/quotes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllQuotesScreen extends ConsumerStatefulWidget {
  const AllQuotesScreen({super.key});

  @override
  ConsumerState<AllQuotesScreen> createState() => _AllQuotesScreenState();
}

class _AllQuotesScreenState extends ConsumerState<AllQuotesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () => ref.read(quotesNotifierProvider).getQuotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Quotes',
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final quotesNotifier = ref.watch(quotesNotifierProvider);
            return quotesNotifier.showLoader
                ? const Center(child: CircularProgressIndicator(
                  key: circulaorIndicatorAllQuotesScreenKey,
                ))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: quotesNotifier.quotes.length,
                    itemBuilder: (context, index) {
                      final quote = quotesNotifier.quotes[index];
                      return ListTile(
                        title: Text(quote.quote!),
                        subtitle: Text(quote.author!),
                      );
                    },
                  );
          },
        ));
  }
}
