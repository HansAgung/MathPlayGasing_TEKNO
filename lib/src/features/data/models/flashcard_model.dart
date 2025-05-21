class FlashcardModel {
  final int lessonId;
  final int patternCount;
  final int matchCount;
  final List<CardItem> cards;

  FlashcardModel({
    required this.lessonId,
    required this.patternCount,
    required this.matchCount,
    required this.cards,
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      lessonId: json['lessonId'],
      patternCount: json['patternCount'],
      matchCount: json['matchCount'],
      cards: (json['cards'] as List<dynamic>)
          .map((cardJson) => CardItem.fromJson(cardJson))
          .toList(),
    );
  }
}

class CardItem {
  final int id;
  final String imageUrl;

  CardItem({required this.id, required this.imageUrl});

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }
}
