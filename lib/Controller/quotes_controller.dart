import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virat_kohli/Model/quotes_model.dart';

class QuotesController extends GetxController {
  RxList<QuotesModel> quotesList = <QuotesModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    getImage();
  }

  Future<void> getImage() async {
    try {
      isLoading.value = true;

      var response = await http.get(Uri.parse("https://mapi.trycatchtech.com/v3/virat_kohli/quotes_list"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        quotesList.assignAll(jsonList.map((json) => QuotesModel.fromJson(json)).toList());
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
