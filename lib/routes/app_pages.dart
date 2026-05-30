import 'package:get/get.dart';

import '../modules/home/views/home_page.dart';

class AppPages {
  static const home = '/';

  static final routes = [
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
  ];
}