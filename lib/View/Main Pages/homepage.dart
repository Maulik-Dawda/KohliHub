import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virat_kohli/Controller/category_controller.dart';
import 'package:virat_kohli/Controller/news_list_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/Detail%20Pages/all_news_list.dart';
import 'package:virat_kohli/View/Detail%20Pages/news_detail_page.dart';
import 'package:virat_kohli/Widgets/custom_category_list.dart';
import 'package:virat_kohli/Widgets/custom_news_list.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final CategoryController categoryController = Get.put(CategoryController());
  final NewsListController newsListController = Get.put(NewsListController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.black, AppColors.lightBlack],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: screenWidth * 0.35,
              height: screenHeight * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.reddishBg, AppColors.brownishBg],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "Virat Kohli",
                    style: GoogleFonts.sansitaSwashed(
                      color: Colors.white30,
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 7,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.2,
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage("assets/images/logo.png"),
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.3,
                            ),
                            Text(
                              "The",
                              style: GoogleFonts.poppins(
                                color: AppColors.primaryRed,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Virat",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  "Kohli",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text("Category", style: TextStyle(color: Colors.white, fontSize: 16)),
                  Obx(() {
                    if (categoryController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      itemCount: categoryController.categoryList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 50,
                        crossAxisSpacing: 10,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final category = categoryController.categoryList[index];
                        return CustomCategoryList(
                          catImage: category.catImage ?? "",
                          catName: category.catName ?? "",
                          catRoute: category.catRoute ?? "",
                        );
                      },
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Top News", style: TextStyle(color: Colors.white, fontSize: 16)),
                      TextButton(
                        onPressed: () => Get.to(() => AllNewsList()),
                        child: const Text(
                          "View All",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (newsListController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      height: screenHeight * 0.20,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: newsListController.newsList.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final news = newsListController.newsList[index];
                          return InkWell(
                            onTap: () => Get.to(() => NewsDetailPage(newsId: news.id ?? "")),
                            child: CustomNewsList(imageUrl: news.newsImage ?? ''),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
