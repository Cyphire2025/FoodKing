import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../controllers/order_controller.dart';
import '../widget/order_status.dart';
import 'order_details.dart';

Widget previousOrders(OrderController orderController) {
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: Text(
            'PREVIOUS_ORDERS'.tr,
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColor.activeTxtColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 14.h),

        orderController.previousOrders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "NO_ORDER_FOUND".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Rubik",
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderController.previousOrders.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () async {
                      var result = await orderController.getOrderDetails(
                        orderController.previousOrders[index].id!,
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
                      padding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                        bottom: 10.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                              border: Border.all(color: AppColor.itembg),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.r),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.active_order,
                                    width: 32.w,
                                    height: 32.h,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Color(0xffA0A3BD),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                    width: 270.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 6.h,
                                            bottom: 6.h,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "ORDER_ID".tr,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily: "Rubik",
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                orderController
                                                    .previousOrders[index]
                                                    .orderSerialNo
                                                    .toString(),
                                                style: fontRegularBold,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Spacer(),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  1)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.pending,
                                                  AppColor.pendingText,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  4)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.preparing,
                                                  AppColor.preparingText,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  7)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.preparing,
                                                  AppColor.preparingText,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  8)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.blueTextColor
                                                      .withAlpha(50),
                                                  AppColor.blueTextColor,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  10)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.preparing,
                                                  AppColor.preparingText,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  13)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.delivered,
                                                  AppColor.primaryColor,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  16)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.canceled,
                                                  AppColor.error,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  19)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.canceled,
                                                  AppColor.error,
                                                ),
                                              if (orderController
                                                      .previousOrders[index]
                                                      .status ==
                                                  22)
                                                orderStatus(
                                                  orderController
                                                      .previousOrders[index]
                                                      .statusName,
                                                  AppColor.canceled,
                                                  AppColor.error,
                                                ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'ITEM_NUMBERS'.trParams({
                                            'number': orderController
                                                .previousOrders[index]
                                                .orderItems
                                                .toString(),
                                          }),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: "Rubik",
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.gray,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          orderController
                                              .previousOrders[index]
                                              .orderDatetime
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: "Rubik",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        orderController
                                                    .previousOrders[index]
                                                    .orderType ==
                                                5
                                            ? Text(
                                                "Delivery".tr,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "Rubik",
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColor.activeTxtColor,
                                                ),
                                              )
                                            : Text(
                                                "Takeaway".tr,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "Rubik",
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColor.activeTxtColor,
                                                ),
                                              ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          children: [
                                            Text(
                                              "${"TOTAL".tr}: ",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Rubik",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              orderController
                                                  .previousOrders[index]
                                                  .totalCurrencyPrice
                                                  .toString(),
                                              style: fontMediumProWithCurrency,
                                            ),
                                            const Spacer(),
                                            Text(
                                              "SEE_ORDER_STATUS".tr,
                                              style: fontRegularBoldwithColor,
                                            ),
                                            SizedBox(width: 8.w),
                                            SvgPicture.asset(
                                              Images.right_arrow,
                                              width: 10.w,
                                              height: 10.h,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(width: 6.w),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ],
    ),
  );
}
