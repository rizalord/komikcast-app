class DetailComic {
  final String author,
      image,
      rating,
      released,
      sinopsis,
      status,
      title,
      titleOther,
      type,
      totalChapter,
      updatedOn;
  final List<String> genres;
  final List<SingleChapterDetail> listChapters;

  DetailComic({
    this.author,
    this.image,
    this.rating,
    this.released,
    this.sinopsis,
    this.status,
    this.title,
    this.titleOther,
    this.totalChapter,
    this.type,
    this.updatedOn,
    this.genres,
    this.listChapters,
  });

  factory DetailComic.fromJson(Map<String, dynamic> json) {
    return DetailComic(
      author: json['author'],
      image: json['image'],
      rating: json['rating'],
      released: json['released'],
      sinopsis: json['sinopsis'],
      status: json['status'],
      title: json['title'],
      titleOther: json['title_other'],
      totalChapter: json['total_chapter'],
      type: json['type'],
      updatedOn: json['updated_on'],
      genres: json['genres'].map<String>((e) => e.toString()).toList(),
      listChapters: json['list_chapter']
          .map<SingleChapterDetail>((e) => SingleChapterDetail.fromJson(e))
          .toList(),
    );
  }
}

class SingleChapterDetail {
  final String chapter, link, linkId, timeRelease;

  SingleChapterDetail({
    this.chapter,
    this.link,
    this.linkId,
    this.timeRelease,
  });

  factory SingleChapterDetail.fromJson(Map<String, dynamic> json) {
    return SingleChapterDetail(
      chapter: json['chapter'],
      link: json['link'],
      linkId: json['linkId'],
      timeRelease: json['time_release'],
    );
  }
}
