import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/news_detail_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsId;

  const NewsDetailPage({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final NewsDetailController controller = Get.put(NewsDetailController(newsId));

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: screenWidth * 0.05),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SizedBox(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              child: const CircularProgressIndicator(),
            ),
          );
        }

        if (controller.newsDetail.value == null) {
          return Center(
            child: Text(
              "No data found.",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final news = controller.newsDetail.value!;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // News Image
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                child: Image.network(
                  news.newsImage ?? '',
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: screenHeight * 0.3,
                    color: Colors.grey,
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // News Title
              Text(
                news.newsTitle ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // News Description
              Text(
                news.newsDesc ?? '',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: screenWidth * 0.04,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
