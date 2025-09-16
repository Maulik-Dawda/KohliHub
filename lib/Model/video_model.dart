
class VideoModel {
  String? id;
  String? image;
  String? thumbImage;
  String? title;
  String? url;

  VideoModel({this.id, this.image, this.thumbImage, this.title, this.url});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    thumbImage = json["thumb_image"];
    title = json["title"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["image"] = image;
    data["thumb_image"] = thumbImage;
    data["title"] = title;
    data["url"] = url;
    return data;
  }
}
