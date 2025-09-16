import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virat_kohli/Model/news_description_model.dart';

class NewsDetailController extends GetxController {
  final String id;
  NewsDetailController(this.id);

  Rx<NewsDescriptionModel?> newsDetail = Rx<NewsDescriptionModel?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getNewsDetail();
  }

  Future<void> getNewsDetail() async {
    try {
      isLoading.value = true;

      var response = await http.get(Uri.parse(
          "https://mapi.trycatchtech.com/v3/virat_kohli/virat_kohli_single_news?news_id=$id"));

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        newsDetail.value = NewsDescriptionModel.fromJson(jsonMap);
      } else {
        print("Failed to load news detail. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
