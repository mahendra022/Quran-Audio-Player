import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

void main() {
  runApp(const QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Quran Audio Player',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: AppPages.home,
      getPages: AppPages.routes,
    );
  }
}