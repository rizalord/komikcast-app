class ComicV1 {
  final String chapter, image, link, linkId, title, type,rating;

  ComicV1({
    this.chapter,
    this.image,
    this.link,
    this.linkId,
    this.title,
    this.type,
    this.rating,
  });

  factory ComicV1.fromJson(Map<String, dynamic> json) {
    return ComicV1(
      chapter: json['ch'],
      image: json['image'],
      link: json['link'],
      linkId: json['linkId'],
      rating: json['rating'],
      title: json['title'],
      type: json['type'],
    );
  }
}
