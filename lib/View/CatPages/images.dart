import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/image_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/Detail%20Pages/image_detail.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';

class Images extends StatelessWidget {
  final String catName;
  const Images({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ImageController imageController = Get.put(ImageController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.brownishBg,
                AppColors.reddishBg
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                  child: CustomBackButton(),
                ),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            catName,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
                          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 14),
                          indicatorColor: Colors.white,
                          indicatorWeight: 3,
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                          tabs: const [
                            Tab(text: "RCB Images"),
                            Tab(text: "Personal Images"),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Obx(() {
                                if (imageController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else if (imageController.imageList.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      "No images found",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                } else {
                                  return MasonryGridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    padding: const EdgeInsets.all(10),
                                    itemCount: imageController.imageList.length,
                                    itemBuilder: (context, index) {
                                      final image = imageController.imageList[index];
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: InkWell(
                                          onTap: () => Get.to(() => ImageDetail(imageUrl: image.image ?? "")),
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
                                }
                              }),
                              Center(
                                child: Text(
                                  "No Images",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
