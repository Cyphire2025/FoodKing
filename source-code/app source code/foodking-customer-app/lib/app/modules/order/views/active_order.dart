import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../controllers/order_controller.dart';
import '../widget/order_status.dart';
import 'order_details.dart';

Widget activeOrderSection(OrderController orderController) {
  final box = GetStorage();

  return Obx(() {
    final orders = orderController.activeOrders;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xfff7e4e6), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.06),
            blurRadius: 24.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
            child: Row(
              children: [
                Container(
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: Image.asset(
                      Images.activeLogo,
                      width: 54.w,
                      height: 54.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Orders',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: const Color(0xff2f0f4a),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Orders in progress',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: const Color(0xff6f687f),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 40.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    '${orders.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: AppColor.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1.h, color: const Color(0xfff8ecec)),
          if (orders.isEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 26.h),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      Images.activeEmpty,
                      width: 210.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(12.w, 14.h, 12.w, 12.h),
              itemCount: orders.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: GestureDetector(
                    onTap: () async {
                      final result = await orderController.getOrderDetails(
                        orders[index].id!,
                      );
                      if (result != null) {
                        Get.to(
                          () => OrderDetailsView(
                            orderId: orderController.orderId,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xfffffcfa),
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: const Color(0xfff1e3de),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${"ORDER_ID".tr} ${orders[index].orderSerialNo}',
                                        style: fontRegularBold,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    _activeOrderStatus(
                                      orders[index].status,
                                      orders[index].statusName,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'ITEM_NUMBERS'.trParams({
                                    'number': orders[index].orderItems
                                        .toString(),
                                  }),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.gray,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  orders[index].orderDatetime.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _orderTypeLabel(orders[index].orderType),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Text(
                                      '${"TOTAL".tr}: ',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      orders[index].totalCurrencyPrice
                                          .toString(),
                                      style: fontMediumProWithCurrency,
                                    ),
                                    const Spacer(),
                                    Text(
                                      'SEE_ORDER_STATUS'.tr,
                                      style: fontRegularBoldwithColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    box.read('languageCode') == 'ar'
                                        ? Transform.rotate(
                                            angle: pi,
                                            child: SvgPicture.asset(
                                              Images.right_arrow,
                                              width: 10.w,
                                              height: 10.h,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            Images.right_arrow,
                                            width: 10.w,
                                            height: 10.h,
                                            fit: BoxFit.cover,
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  });
}

Widget _activeOrderStatus(int? status, String? statusName) {
  if (status == 1) {
    return orderStatus(statusName, AppColor.pending, AppColor.pendingText);
  }
  if (status == 4 || status == 7) {
    return orderStatus(statusName, AppColor.preparing, AppColor.preparingText);
  }
  if (status == 8) {
    return orderStatus(
      statusName,
      AppColor.blueTextColor.withAlpha(50),
      AppColor.blueTextColor,
    );
  }
  if (status == 10) {
    return orderStatus(statusName, AppColor.deleveryColor, AppColor.fontColor);
  }
  if (status == 13) {
    return orderStatus(statusName, AppColor.delivered, AppColor.primaryColor);
  }
  if (status == 16 || status == 19 || status == 22) {
    return orderStatus(statusName, AppColor.canceled, AppColor.canceledText);
  }
  return const SizedBox.shrink();
}

String _orderTypeLabel(int? orderType) {
  if (orderType == 5) return 'DELIVERY'.tr;
  if (orderType == 10) return 'TAKEAWAY'.tr;
  if (orderType == 15) return 'POS'.tr;
  return 'DINEIN'.tr;
}
