class OtherComic {
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

  OtherComic({
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

  factory OtherComic.fromJson(Map<String, dynamic> json) {
    return OtherComic(
      chapter: json['chapter'],
      image: json['image'],
      isCompleted: json['isCompleted'],
      link: json['link'],
      linkChapter: json['linkChapter'],
      linkId: json['linkId'],
      linkIdChapter: json['linkIdChapter'],
      rating: json['rating'],
      title: json['title'],
      type: json['type'],
    );
  }
}
