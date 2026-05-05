// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_toast.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/order_details_model.dart';
import '../../../data/model/response/order_mode.dart';
import '../../../data/repository/my_order_repo.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../home/controllers/home_controller.dart';

class OrderController extends GetxController {
  final box = GetStorage();
  static Server server = Server();
  final activeOrders = <OrdersData>[].obs;
  final previousOrders = <OrdersData>[].obs;
  final orderDetailsData = OrderDetailsData().obs;
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  final orderLoader = false.obs;
  bool activeLoader = false;
  final orderDetailsLoader = false.obs;
  int? orderId;

  final activeStep = 0.obs;

  final orderNotificationId = "".obs;
  final orderNotfyLoader = false.obs;

  Future<void> getMyOrderList() async {
    activeOrders.clear();
    previousOrders.clear();
    orderLoader.value = true;
    try {
      final myOrderData = await MyOrderRepo.getMyOrder();
      orderLoader.value = false;
      const activeOrderStatus = {1, 4, 7, 8, 10};
      const previousOrderStatus = {13, 16, 19, 22};
      activeOrders.value = myOrderData!.data!
          .where((order) => activeOrderStatus.contains(order.status))
          .toList();

      previousOrders.value = myOrderData.data!
          .where((order) => previousOrderStatus.contains(order.status))
          .toList();
      orderLoader.value = false;
    } finally {
      orderLoader.value = false;
    }
  }

  Future<OrderDetailsModel?> getOrderDetails(int id) async {
    orderId = id;
    orderDetailsLoader.value = true;

    try {
      await server
          .getRequest(endPoint: APIList.orderDetails! + id.toString())
          .then((response) {
            if (response != null && response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              orderDetailsModel = OrderDetailsModel.fromJson(jsonResponse);
              orderDetailsData.value = orderDetailsModel.data!;

              orderDetailsLoader.value = false;

              if (orderDetailsData.value.status! == 1) {
                activeStep.value = 0;
              } else if (orderDetailsData.value.status! == 4) {
                activeStep.value = 1;
              } else if (orderDetailsData.value.status! == 7) {
                activeStep.value = 2;
              } else if (orderDetailsData.value.status! == 8) {
                activeStep.value = 3;
              } else if (orderDetailsData.value.status! == 10) {
                activeStep.value = 4;
              } else if (orderDetailsData.value.status! == 13) {
                activeStep.value = 5;
              }

              return orderDetailsModel;
            } else {
              orderDetailsLoader.value = false;
            }
          });
      return orderDetailsModel;
    } catch (e) {
      orderDetailsLoader.value = false;
    }
  }

  Future<OrderDetailsModel?> orderCancel(id) async {
    orderDetailsLoader.value = true;
    update();
    try {
      Map body = {'status': 16};
      String jsonBody = json.encode(body);

      await server
          .postRequestWithToken(
            endPoint: APIList.cancelOrder! + id.toString(),
            body: jsonBody,
          )
          .then((response) {
            if (response != null && response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              orderDetailsModel = OrderDetailsModel.fromJson(jsonResponse);
              orderDetailsData.value = orderDetailsModel.data!;
              update();
              orderDetailsLoader.value = false;
              update();
              getMyOrderList();
              Get.find<HomeController>().getActiveOrderList();
              update();
              Future.delayed(const Duration(milliseconds: 200), () {
                Get.offAll(() => const DashboardView());
                update();
              });

              customTast("ORDER_HAS_BEEN_CANCELLED".tr, AppColor.success);

              return orderDetailsModel;
            } else {
              orderDetailsLoader.value = false;
              update();
            }
          });
      return orderDetailsModel;
    } catch (e) {
      orderDetailsLoader.value = false;
      update();
    }
  }
}
