// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/modules/order/views/active_order.dart';
import 'package:foodking/app/modules/order/views/previous_order.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../../../widget/loader.dart';
import '../controllers/order_controller.dart';
import '../widget/active_order_shimmer.dart';
import '../widget/previous_order_shimmer.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final box = GetStorage();
  final orderController = Get.put(OrderController());
  @override
  void initState() {
    final box = GetStorage();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      orderController.getMyOrderList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: -5,
              title: Text(
                'MY_ORDERS'.tr,
                style: TextStyle(
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: SvgPicture.asset(Images.back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: RefreshIndicator(
              color: AppColor.primaryColor,

              onRefresh: () async {
                await orderController.getMyOrderList();
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    orderController.orderLoader.value
                        ? activeOrderSectionShimmer()
                        : activeOrderSection(orderController),
                    SizedBox(height: 24.h),
                    orderController.orderLoader.value
                        ? previousOrdersShimmer()
                        : previousOrders(orderController),
                  ],
                ),
              ),
            ),
          ),
          orderController.orderDetailsLoader.value
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: const Center(child: LoaderCircle()),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
