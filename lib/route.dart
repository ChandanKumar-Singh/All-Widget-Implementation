import 'package:demoo/CustomScrollView.dart';
import 'package:demoo/ImagePickAndRefractController.dart';
import 'package:demoo/pic%20image%20and%20refract.dart';
import 'package:get/get.dart';

class Route {
  static String initial = '/home';
  static String customSP = '/csp';

}

class AppPages {
  AppPages._();

  static const INITIAL = '/home';


  static final routes = [
    GetPage(
      name: Route.initial,
      page: () => ImagePickAndRefract(),
      binding: HomeBinding(),
    ),    GetPage(
      name: Route.customSP,
      page: () => CustomScrollViewPage(),
      binding: HomeBinding(),
    ),

  ];
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ImagePickAndRefractController>(
        () => ImagePickAndRefractController());
  }
}
