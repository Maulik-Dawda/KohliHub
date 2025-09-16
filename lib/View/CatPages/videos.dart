import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virat_kohli/Controller/video_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';

class Videos extends StatelessWidget {
  final String catName;
  const Videos({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final videoController = Get.put(VideoController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.brownishBg, AppColors.reddishBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05, child: const CustomBackButton()),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  catName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  if (videoController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  } else if (videoController.videoList.isEmpty) {
                    return const Center(
                      child: Text("No videos found", style: TextStyle(color: Colors.white)),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: videoController.videoList.length,
                      itemBuilder: (context, index) {
                        final video = videoController.videoList[index];
                        final imageUrl = video.image ?? "";
                        final title = video.title ?? "";

                        return InkWell(
                            onTap: () async {
                              final url = videoController.videoList[index].url!;
                              final uri = Uri.parse(url);

                              try {
                                if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                                  throw 'Could not launch $url';
                                }
                              } catch (e) {
                                print("Launch error: $e");
                              }
                            } ,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: Image.network(
                                          imageUrl,
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            height: 180,
                                            color: Colors.black12,
                                            child: const Center(child: Icon(Icons.broken_image, color: Colors.white70)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            "1:14", // You can replace this with actual duration if available
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 10,
                                        bottom: 10,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.black87,
                                          child: Icon(Icons.play_arrow, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          "Jan 03, 2025", // Replace with dynamic date if available
                                          style: TextStyle(color: Colors.white70, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
