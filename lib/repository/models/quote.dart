class Quote {
  final String author;
  final String content;

  Quote({required this.author, required this.content});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      author: json['author'],
      content: json['text'],
    );
  }
}
