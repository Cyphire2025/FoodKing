import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../home/controllers/home_controller.dart';
import '../../menu/controllers/menu_controller.dart';
import '../../splash/controllers/splash_controller.dart';

class LanguageController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    if (box.read('selectedLanguageValue') == null) {
      box.write('languageCode', 'en');
      box.write('selectedLanguageValue', 'English');
      update();
    }
    super.onInit();
  }

  Future<void> changeLanguage(String languageCode, String languageName) async {
    box.write('languageCode', languageCode);
    box.write('selectedLanguageValue', languageName);
    Get.updateLocale(Locale(languageCode, null));
    await _refreshLocalizedData();
    update();
  }

  Future<void> _refreshLocalizedData() async {
    if (Get.isRegistered<SplashController>()) {
      final splashController = Get.find<SplashController>();
      await splashController.getConfiguration();
      await splashController.getPageData();
      await splashController.getLanguageData();
    }

    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      await homeController.getCategoryList();
      await homeController.getBranchList();
      await homeController.getPopularItemDataList();
      await homeController.getFeaturedItemDataList();
      await homeController.getItemDataList();
    }

    if (Get.isRegistered<MenuuController>()) {
      final menuController = Get.find<MenuuController>();
      await menuController.getCategoryList();
      if (menuController.categoryDataList.isNotEmpty) {
        final index = menuController.currentIndex.clamp(
          0,
          menuController.categoryDataList.length - 1,
        );
        await menuController.getCategoryWiseItemDataList(
          menuController.categoryDataList[index].slug!,
        );
      }
    }
  }
}
