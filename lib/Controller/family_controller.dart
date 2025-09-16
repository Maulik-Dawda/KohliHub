import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Model/family_model.dart';

class FamilyController extends GetxController {
  RxList<FamilyModel> family = <FamilyModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFamily();
  }

  void fetchFamily() async {
    try {
      final String response = await rootBundle.loadString('assets/data/family.json');
      final List<dynamic> data = json.decode(response);
      family.value = data.map((e) => FamilyModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load categories");
    } finally {
      isLoading.value = false;
    }
  }
}
