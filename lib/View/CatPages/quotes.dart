import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/quotes_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Quotes extends StatelessWidget {
  final String catName;
  const Quotes({super.key, required this.catName});

  Future<void> _shareImage(String imageUrl, RenderBox? box) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.jpg');
      await file.writeAsBytes(bytes);

      final params = ShareParams(
        text: "Check out this image!",
        files: [XFile(file.path)],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );

      await SharePlus.instance.share(params);
    } catch (e) {
      debugPrint("Error sharing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final QuotesController controller = Get.put(QuotesController());

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
        child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05,
                child: const CustomBackButton(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    catName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (controller.quotesList.isEmpty) {
                    return const Center(
                      child: Text("No Quotes Found", style: TextStyle(color: Colors.white)),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: controller.quotesList.length,
                    itemBuilder: (context, index) {
                      final quote = controller.quotesList[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              quote.image ?? "",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, _, __) =>
                              const Icon(Icons.broken_image, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Builder(
                              builder: (ctx) {
                                return InkWell(
                                  onTap: () {
                                    if (quote.image != null) {
                                      final box = ctx.findRenderObject() as RenderBox?;
                                      _shareImage(quote.image!, box);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.share, color: Colors.white, size: 20),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
