
class ImageModel {
  String? id;
  String? image;
  String? thumbImage;

  ImageModel({this.id, this.image, this.thumbImage});

  ImageModel.fromJson(Map<String, dynamic> json) {
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
