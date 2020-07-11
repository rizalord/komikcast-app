class ComicV2 {
  final String chapter, image, link, linkId, title;
  final bool isHot;

  ComicV2({
    this.chapter,
    this.image,
    this.link,
    this.linkId,
    this.title,
    this.isHot,
  });

  factory ComicV2.fromJson(Map<String, dynamic> json) {
    return ComicV2(
      chapter: json['chapters'][0]['title'],
      image: json['image'],
      link: json['link'],
      linkId: json['linkId'],
      title: json['title'],
      isHot: json['isHot']
    );
  }
}
