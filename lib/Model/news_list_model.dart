
class NewListModel {
  String? id;
  String? newsTitle;
  String? newsImage;
  String? thumbImage;

  NewListModel({this.id, this.newsTitle, this.newsImage, this.thumbImage});

  NewListModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    newsTitle = json["news_title"];
    newsImage = json["news_image"];
    thumbImage = json["thumb_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["news_title"] = newsTitle;
    data["news_image"] = newsImage;
    data["thumb_image"] = thumbImage;
    return data;
  }
}
