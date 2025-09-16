
class FamilyModel {
  String? id;
  String? title;
  String? name;
  String? mainImage;
  List<String>? galleryImages;
  String? description;

  FamilyModel({this.id, this.title, this.name, this.mainImage, this.galleryImages, this.description});

  FamilyModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    name = json["name"];
    mainImage = json["main_image"];
    galleryImages = json["gallery_images"] == null ? null : List<String>.from(json["gallery_images"]);
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["name"] = name;
    data["main_image"] = mainImage;
    if(galleryImages != null) {
      data["gallery_images"] = galleryImages;
    }
    data["description"] = description;
    return data;
  }
}
