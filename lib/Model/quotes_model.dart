
class QuotesModel {
  String? id;
  String? image;
  String? thumbImage;

  QuotesModel({this.id, this.image, this.thumbImage});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    thumbImage = json["thumb_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["image"] = image;
    data["thumb_image"] = thumbImage;
    return data;
  }
}
