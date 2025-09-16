import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virat_kohli/View/CatPages/family.dart';
import 'package:virat_kohli/View/CatPages/images.dart';
import 'package:virat_kohli/View/CatPages/quotes.dart';
import 'package:virat_kohli/View/CatPages/statistics.dart';
import 'package:virat_kohli/View/CatPages/videos.dart';
import 'package:virat_kohli/View/CatPages/wallpapers.dart';
import 'package:virat_kohli/View/Main%20Pages/homepage.dart';
import 'package:virat_kohli/View/OnBoarding/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Homepage()),
        GetPage(name: '/wallpaper', page: () => Wallpapers(catName: "WallPapers",)),
        GetPage(name: '/family', page: () => FamilyPage(catName: "Family")),
        GetPage(name: '/images', page: () => Images(catName: "Images",)),
        GetPage(name: '/videos', page: () => Videos(catName: "Match Videos",)),
        GetPage(name: '/statistics', page: () => Statistics(catName: "Statistics",)),
        GetPage(name: '/quotes', page: () => Quotes(catName: "Quotes",)),
      ],
      home: SplashScreen(),
    );
  }
}
