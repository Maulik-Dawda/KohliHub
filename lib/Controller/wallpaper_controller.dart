import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virat_kohli/Model/wallpaper_model.dart';

class WallpaperController extends GetxController {
  RxList<WallpaperModel> wallpaperList = <WallpaperModel>[].obs;
  RxBool isLoading = true.obs;

  void onInIt(){
    super.onInit();
    getWallpaper();
  }

  Future<void> getWallpaper() async {
    try {
      isLoading.value = true;

      var response = await http.get(Uri.parse("https://mapi.trycatchtech.com/v3/virat_kohli/wallpapers_list"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        wallpaperList.assignAll(jsonList.map((json) => WallpaperModel.fromJson(json)).toList());
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
