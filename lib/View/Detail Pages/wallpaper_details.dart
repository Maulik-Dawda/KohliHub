import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/wallpaper_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/Widgets/custom_images_list.dart';

class WallpaperDetails extends StatefulWidget {
  final String imageUrl;

  const WallpaperDetails({super.key, required this.imageUrl});

  @override
  State<WallpaperDetails> createState() => _WallpaperDetailsState();
}

class _WallpaperDetailsState extends State<WallpaperDetails> {
  final WallpaperController wallpaperController = Get.find<WallpaperController>();

  late String currentImageUrl;

  @override
  void initState() {
    super.initState();
    currentImageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: screenHeight * 0.55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          currentImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Text("Back", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.ios_share_outlined, color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border_outlined, color: Colors.white, size: 30),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "More Like This",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (wallpaperController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    itemCount: wallpaperController.wallpaperList.length,
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 18,
                    ),
                    itemBuilder: (context, index) {
                      final wallpaper = wallpaperController.wallpaperList[index];

                      return CustomImagesList(
                        imageUrl: wallpaper.image ?? "",
                        onTap: () {
                          setState(() {
                            currentImageUrl = wallpaper.image ?? "";
                          });
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
