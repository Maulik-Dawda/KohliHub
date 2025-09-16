import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virat_kohli/Controller/news_list_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/Detail%20Pages/news_detail_page.dart';

class AllNewsList extends StatelessWidget {
  AllNewsList({super.key});
  final NewsListController newsListController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: screenWidth * 0.05),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Top News",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
      ),
      body: Obx(() {
        if (newsListController.isLoading.value) {
          return Center(
            child: SizedBox(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              child: const CircularProgressIndicator(),
            ),
          );
        }

        final newsList = newsListController.newsList;

        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          itemCount: newsList.length,
          separatorBuilder: (context, index) => Divider(
            color: AppColors.primaryRed,
            height: screenHeight * 0.06,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final news = newsList[index];
            return InkWell(
              onTap: () => Get.to(() => NewsDetailPage(newsId: news.id ?? "")),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      news.newsImage ?? '',
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.10,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: screenWidth * 0.28,
                        height: screenHeight * 0.12,
                        color: Colors.grey,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.025),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.newsTitle ?? '',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
