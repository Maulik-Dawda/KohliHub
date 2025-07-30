class CategoryModel {
  String? catName;
  String? catImage;
  String? catRoute;

  CategoryModel({this.catName, this.catImage, this.catRoute});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catName = json["cat_name"];
    catImage = json["cat_image"];
    catRoute = json["route"];
  }

  Map<String, dynamic> toJson() {
    return {
      "cat_name": catName,
      "cat_image": catImage,
      "route": catRoute,
    };
  }
}
