import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virat_kohli/Model/news_description_model.dart';

class NewsDetailController extends GetxController {
  final String id;
  NewsDetailController(this.id);
  RxList<NewsDescriptionModel> newsDetail = <NewsDescriptionModel>[].obs;
  RxBool isLoading = true.obs;

  void onInIt(){
    super.onInit();
    getNewsDetail();
  }

  Future<void> getNewsDetail() async {
    try {
      isLoading.value = true;

      var response = await http.get(Uri.parse("https://mapi.trycatchtech.com/v3/virat_kohli/virat_kohli_single_news?news_id=$id"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        newsDetail.assignAll(jsonList.map((json) => NewsDescriptionModel.fromJson(json)).toList());
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
