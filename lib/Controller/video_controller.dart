import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virat_kohli/Model/video_model.dart';

class VideoController extends GetxController {
  RxList<VideoModel> videoList = <VideoModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getVideo();
  }

  Future<void> getVideo() async {
    try {
      isLoading.value = true;
      print("Fetching video data...");

      final response = await http.get(
        Uri.parse("https://mapi.trycatchtech.com/v3/virat_kohli/videos_list"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        if (jsonList.isNotEmpty) {
          videoList.assignAll(
            jsonList.map((json) => VideoModel.fromJson(json)).toList(),
          );
          print("Fetched ${videoList.length} videos.");
        } else {
          print("Video list is empty.");
        }
      } else {
        print("Server error:   ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in getVideo(): $e");
    } finally {
      isLoading.value = false;
    }
  }
}
