// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodking/app/modules/order/views/active_order.dart';
import 'package:foodking/app/modules/order/views/previous_order.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../util/constant.dart';
import '../../../../widget/loader.dart';
import '../controllers/order_controller.dart';
import '../widget/active_order_shimmer.dart';
import '../widget/previous_order_shimmer.dart';

class OrderView extends StatefulWidget {
  final bool showBackButton;

  const OrderView({super.key, this.showBackButton = true});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  static const Color _ink = Color(0xff2f0f4a);
  static const Color _muted = Color(0xff6f687f);
  static const Color _cream = Color(0xfffffbf7);
  static const Color _blush = Color(0xfffde9ee);

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
            backgroundColor: _cream,
            body: SafeArea(
              child: RefreshIndicator(
                color: AppColor.primaryColor,
                onRefresh: () async {
                  await orderController.getMyOrderList();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 26.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _OrdersHeader(showBackButton: widget.showBackButton),
                      SizedBox(height: 26.h),
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
          ),
          if (orderController.orderDetailsLoader.value)
            Positioned.fill(
              child: Container(
                color: Colors.white60,
                child: const Center(child: LoaderCircle()),
              ),
            ),
        ],
      ),
    );
  }
}

class _OrdersHeader extends StatelessWidget {
  const _OrdersHeader({required this.showBackButton});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 54.w,
              height: 54.w,
              decoration: const BoxDecoration(
                color: _OrderViewState._blush,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xffd85974),
                size: 28.sp,
              ),
            ),
          ),
        if (showBackButton) SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Orders',
                style: GoogleFonts.poppins(
                  color: _OrderViewState._ink,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Track your current and past orders',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: _OrderViewState._muted,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
