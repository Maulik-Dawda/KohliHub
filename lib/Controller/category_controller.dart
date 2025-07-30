import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Model/category_model.dart';

class CategoryController extends GetxController {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      final String response = await rootBundle.loadString('assets/data/category.json');
      final List<dynamic> data = json.decode(response);
      categoryList.value = data.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load categories");
    } finally {
      isLoading.value = false;
    }
  }
}
