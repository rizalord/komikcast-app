class ComicV3 {
  final String image, link, linkId, title;
  final bool isHot;
  final List<SingleChapter> chapters;

  ComicV3({
    this.image,
    this.link,
    this.linkId,
    this.title,
    this.isHot,
    this.chapters,
  });

  factory ComicV3.fromJson(Map<String, dynamic> json) {
    return ComicV3(
      chapters: json['chapters'].map<SingleChapter>((e) => SingleChapter.fromJson(e)).toList(),
      image: json['image'],
      link: json['link'],
      linkId: json['linkId'],
      title: json['title'],
      isHot: json['isHot'],
    );
  }
}

class SingleChapter {
  final String link, linkId, timeUploaded, title;

  SingleChapter({
    this.link,
    this.linkId,
    this.timeUploaded,
    this.title,
  });

  factory SingleChapter.fromJson(Map<String, dynamic> json) {
    return SingleChapter(
      link: json['link'],
      title: json['title'] ,
      linkId: json['linkId'],
      timeUploaded: json['time_uploaded'],
    );
  }
}
