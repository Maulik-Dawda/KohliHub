import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/wallpaper_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/Detail%20Pages/wallpaper_details.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';

class Wallpapers extends StatelessWidget {
  final String catName;
  final WallpaperController wallpaperController = Get.put(WallpaperController());

  Wallpapers({super.key, required this.catName}) {
    wallpaperController.getWallpaper();
  }

  List getRandomWallpapers(List all) {
    final random = Random();
    final shuffled = List.from(all)..shuffle(random);
    return shuffled.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: LinearGradient(
                colors: [AppColors.reddishBg, AppColors.brownishBg],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                  child: CustomBackButton(),
                ) ,
                SizedBox(height: screenHeight * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          catName,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Top Wallpapers",
                          style: TextStyle(color: Colors.white60, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Obx(() {
                  if (wallpaperController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final randomWallpapers = getRandomWallpapers(wallpaperController.wallpaperList);

                  return SizedBox(
                    height: screenHeight * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: randomWallpapers.length,
                      itemBuilder: (context, index) {
                        final wallpaper = randomWallpapers[index];
                        return InkWell(
                          onTap: () => Get.to(() => WallpaperDetails(imageUrl: wallpaper.image ?? "")),
                          child: Container(
                            width: screenWidth * 0.8,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                wallpaper.image ?? '',
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: Obx(() {
                    if (wallpaperController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.all(10),
                      itemCount: wallpaperController.wallpaperList.length,
                      itemBuilder: (context, index) {
                        final image = wallpaperController.wallpaperList[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () => Get.to(() => WallpaperDetails(imageUrl: image.image ?? "")),
                            child: Image.network(
                              image.image ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, color: Colors.white);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
