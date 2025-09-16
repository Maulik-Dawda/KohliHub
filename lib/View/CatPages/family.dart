import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/family_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/Detail%20Pages/family_detail_page.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';

class FamilyPage extends StatelessWidget {
  final String catName;
  final FamilyController controller = Get.put(FamilyController());

  FamilyPage({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.brownishBg, AppColors.reddishBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                    child: CustomBackButton(),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
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
                        SizedBox(height: screenHeight * 0.02),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "About Virat Kohli",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        SizedBox(
                          height: screenHeight * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  "Virat Kohli is an Indian international cricketer who plays Test and ODI cricket for the Indian national team. A former captain in all formats of the game, Kohli retired from the T20I format following India's win at the 2024 T20 World Cup.",
                                  style: TextStyle(color: Colors.white,fontSize: 12),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Virat Kohli Family",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/images/vk-family.jpg',
                                    width: double.infinity,
                                    height: screenHeight * 0.25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                const Text(
                                  "Virat Kohli is unarguably one of the greatest modern-day cricketers to serve Indian cricket. He initially rose through the ranks after leading India to victory in the 2008 ICC U19 Cricket World Cup. After his international debut in the same year, the star cricketer accumulated over 27,000 runs and 81 centuries across three formats i.e Test, ODI and T20I.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Container(
                      height: screenHeight * 0.06,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.family.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = controller.family[index];
                          return InkWell(
                            onTap: () => Get.to(FamilyDetailPage(title: item.title ?? "", name: item.name ?? "", mainImage: item.mainImage ?? "", description: item.description ?? "", galleryImages: item.galleryImages ?? [],)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item.title ?? '',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
