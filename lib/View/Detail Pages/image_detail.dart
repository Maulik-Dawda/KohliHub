import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Controller/image_controller.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';
import 'package:virat_kohli/Widgets/custom_images_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class ImageDetail extends StatefulWidget {
  final String imageUrl;

  const ImageDetail({super.key, required this.imageUrl});

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  final ImageController imageController = Get.find<ImageController>();
  late String currentImageUrl;

  @override
  void initState() {
    super.initState();
    currentImageUrl = widget.imageUrl;
  }

  Future<File> _downloadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    final tempDir = await getTemporaryDirectory();
    final file = File("${tempDir.path}/temp_image.jpg");
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }


  Future<void> _shareImage(String imageUrl) async {
    try {
      final file = await _downloadImage(imageUrl);
      await Share.shareXFiles([
        XFile(file.path),
      ], text: "Check out this image!");
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to share image",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
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
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: const CustomBackButton(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => _shareImage(currentImageUrl),
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "More Like This",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (imageController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GridView.builder(
                    itemCount: imageController.imageList.length,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 18,
                        ),
                    itemBuilder: (context, index) {
                      final image = imageController.imageList[index];

                      return CustomImagesList(
                        imageUrl: image.image ?? "",
                        onTap: () {
                          setState(() {
                            currentImageUrl = image.image ?? "";
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
