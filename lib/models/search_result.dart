class SearchResult {
  final String chapter,
      image,
      link,
      linkChapter,
      linkId,
      linkIdChapter,
      rating,
      title,
      type;
  final bool isCompleted;

  SearchResult({
    this.chapter,
    this.image,
    this.isCompleted,
    this.link,
    this.linkChapter,
    this.linkId,
    this.linkIdChapter,
    this.rating,
    this.title,
    this.type,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      type: json['type'],
      title: json['title'],
      rating: json['rating'],
      link: json['link'],
      linkChapter: json['linkChapter'],
      linkId: json['linkId'],
      linkIdChapter: json['linkIdChapter'],
      isCompleted: json['isCompleted'],
      image: json['image'],
      chapter: json['chapter'],
    );
  }
}
