import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../controllers/order_controller.dart';
import '../widget/order_status.dart';
import 'order_details.dart';

Widget previousOrders(OrderController orderController) {
  return Obx(() {
    final orders = orderController.previousOrders;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xfff3e8f6), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.05),
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
                      Images.previousLogo,
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
                        'Previous Orders',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: const Color(0xff2f0f4a),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Your order history',
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
          Container(height: 1.h, color: const Color(0xfff4edf7)),
          if (orders.isEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 26.h),
              child: Center(
                child: Image.asset(
                  Images.previousEmpty,
                  width: 230.w,
                  fit: BoxFit.contain,
                ),
              ),
            )
          else
            ListView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(12.w, 14.h, 12.w, 12.h),
              itemCount: orders.length,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () async {
                    final result = await orderController.getOrderDetails(
                      orders[index].id!,
                    );
                    if (result != null) {
                      Get.to(
                        () => OrderDetailsView(
                          orderId: orderController.orderDetailsData.value.id!,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xfffffcfa),
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: const Color(0xffefe4f0),
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
                                    _previousOrderStatus(
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  orders[index].orderType == 5
                                      ? 'Delivery'.tr
                                      : 'Takeaway'.tr,
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
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: AppColor.primaryColor,
                                      size: 18.sp,
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

Widget _previousOrderStatus(int? status, String? statusName) {
  if (status == 1) {
    return orderStatus(statusName, AppColor.pending, AppColor.pendingText);
  }
  if (status == 4 || status == 7 || status == 10) {
    return orderStatus(statusName, AppColor.preparing, AppColor.preparingText);
  }
  if (status == 8) {
    return orderStatus(
      statusName,
      AppColor.blueTextColor.withAlpha(50),
      AppColor.blueTextColor,
    );
  }
  if (status == 13) {
    return orderStatus(statusName, AppColor.delivered, AppColor.primaryColor);
  }
  if (status == 16 || status == 19 || status == 22) {
    return orderStatus(statusName, AppColor.canceled, AppColor.error);
  }
  return const SizedBox.shrink();
}
