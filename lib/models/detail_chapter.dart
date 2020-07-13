class DetailChapter {
  final String chapter,
      comicLink,
      comicLinkId,
      comicTitle,
      nextLink,
      nextLinkId,
      prevLink,
      prevLinkId,
      title;
  final List<ImageChapter> images;
  final List<SelectChapter> selectChapter;

  DetailChapter({
    this.chapter,
    this.comicLink,
    this.comicLinkId,
    this.comicTitle,
    this.images,
    this.title,
    this.nextLink,
    this.nextLinkId,
    this.prevLink,
    this.prevLinkId,
    this.selectChapter,
  });

  factory DetailChapter.fromJson(Map<String, dynamic> json) {
    return DetailChapter(
      comicLink: json['comic_link'],
      comicLinkId: json['comic_link_id'],
      comicTitle: json['comic_title'],
      chapter: json['chapter'],
      images: json['images']
          .map<ImageChapter>((e) => ImageChapter.fromJson(e))
          .toList(),
      nextLink: json['next_link'],
      nextLinkId: json['next_link_id'],
      prevLink: json['prev_link'],
      prevLinkId: json['prev_link_id'],
      selectChapter: json['select_chapter']
          .map<SelectChapter>((e) => SelectChapter.fromJson(e))
          .toList(),
    );
  }
}

class ImageChapter {
  final String height, link, width;

  ImageChapter({this.height, this.link, this.width});

  factory ImageChapter.fromJson(Map<String, dynamic> json) {
    return ImageChapter(
      width: json['width'],
      height: json['height'],
      link: json['link'],
    );
  }
}

class SelectChapter {
  final String link, linkId, text;

  SelectChapter({this.link, this.linkId, this.text});

  factory SelectChapter.fromJson(Map<String, dynamic> json) {
    return SelectChapter(
      link: json['link'],
      linkId: json['linkId'],
      text: json['text'],
    );
  }
}
