import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virat_kohli/Model/news_list_model.dart';

class NewsListController extends GetxController {
  RxList<NewListModel> newsList = <NewListModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getNewsList();
  }

  Future<void> getNewsList() async {
    try {
      isLoading.value = true;

      var response = await http.get(Uri.parse("https://mapi.trycatchtech.com/v3/virat_kohli/virat_kohli_news_list"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        newsList.assignAll(jsonList.map((json) => NewListModel.fromJson(json)).toList());
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
