import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/data/model/response/item_model.dart';
import '../app/modules/cart/controllers/cart_controller.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../util/constant.dart';
import 'custom_toast.dart';

Future<void> addItemToCart(ItemData item) async {
  final homeController = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  final cartController = Get.isRegistered<CartController>()
      ? Get.find<CartController>()
      : Get.put(CartController());

  await homeController.getItemDetails(itemID: item.id!);
  final itemDetails = homeController.itemDetailsData.value;
  final unitPrice = itemDetails.offer != null && itemDetails.offer!.isNotEmpty
      ? itemDetails.offer!.first.convertPrice ?? itemDetails.convertPrice ?? 0
      : itemDetails.convertPrice ?? 0;

  try {
    cartController.itemQuantity = 1;
    cartController.addItem(itemDetails, [], [], unitPrice, 0.0, 0.0, '');
    cartController.addItemAddons([]);
    customTast("ADDED_TO_CART".tr, AppColor.success);
  } catch (error, stackTrace) {
    debugPrint('Quick add to cart failed: $error\n$stackTrace');
    customTast("SOMETHING_WRONG".tr, AppColor.error);
  }
}
