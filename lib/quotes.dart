class Quotes {
  final int? id;
  final String? quote;
  final String? author;

  Quotes({this.id, this.quote, this.author});

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return Quotes(
      id: json['id'] as int?,
      quote: json['quote'] as String?,
      author: json['author'] as String?,
    );
  }
}
