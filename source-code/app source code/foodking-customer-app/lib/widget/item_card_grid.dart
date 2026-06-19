import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'item_cart_actions.dart';
import 'item_meta_text.dart';
import '../app/modules/item/views/premium_item_view.dart';
import '../util/constant.dart';
import '../util/localized_text.dart';
import '../util/style.dart';

Widget itemCardGrid(List<dynamic> item, int index, BuildContext context) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => _openPremiumItem(item, index),
    child: Container(
      height: 232.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        border: Border.all(color: AppColor.itembg),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: CachedNetworkImage(
                imageUrl: item[index].cover!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  // ignore: sort_child_properties_last
                  child: Container(
                    height: 86.h,
                    width: 154.w,
                    color: Colors.grey,
                  ),
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    top: 6.h,
                    bottom: 6.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              localizeText(item[index].name),
                              style: fontRegularBold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      ItemMetaText(
                        item: item[index],
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600,
                          fontSize: 9.5.sp,
                          color: const Color(0xff8A6A6A),
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        localizeText(item[index].description),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          height: 1.4.h,
                          color: AppColor.gray,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      item[index].offer.isNotEmpty
                          ? Row(
                              children: [
                                Text(
                                  item[index].currencyPrice!,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColor.gray,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  item[index].offer[0].currencyPrice!,
                                  style: fontMediumProWithCurrency,
                                ),
                              ],
                            )
                          : Text(
                              item[index].currencyPrice!,
                              style: fontMediumProWithCurrency,
                            ),
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: () => addItemToCart(item[index]),
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.itembg,
                                offset: const Offset(0.0, 4.0),
                                blurRadius: 5.r,
                                spreadRadius: 1.r,
                              ),
                              BoxShadow(
                                color: AppColor.itembg,
                                offset: const Offset(1.0, 0.0),
                                blurRadius: 1.r,
                                spreadRadius: 0.r,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 12.w,
                                height: 12.h,
                                child: SvgPicture.asset(
                                  Images.iconCart,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    AppColor.primaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text("ADD".tr, style: fontRegularBoldwithColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> _openPremiumItem(List<dynamic> item, int index) async {
  final homeController = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  await homeController.getItemDetails(itemID: item[index].id!);
  Get.to(
    () => PremiumItemView(
      itemDetails: homeController.itemDetailsData.value,
      indexNumber: index,
    ),
    transition: Transition.upToDown,
  );
}
