import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/modules/item/views/premium_item_view.dart';
import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../../../widget/item_meta_text.dart';
import '../controllers/home_controller.dart';

Widget featureditemSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizeText("Today's Special"),
                style: TextStyle(
                  fontFamily: 'serif',
                  color: const Color(0xff2B1715),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                width: 72.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        if (homeController.featuredItemDataList.isNotEmpty)
          _TodaysSpecialCard(homeController: homeController),
      ],
    ),
  );
}

class _TodaysSpecialCard extends StatelessWidget {
  final HomeController homeController;

  const _TodaysSpecialCard({required this.homeController});

  @override
  Widget build(BuildContext context) {
    final item = homeController.featuredItemDataList.first;
    final price = item.offer != null && item.offer!.isNotEmpty
        ? item.offer!.first.currencyPrice ?? item.currencyPrice ?? ''
        : item.currencyPrice ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: () async {
          await Get.find<HomeController>().getItemDetails(itemID: item.id!);
          if (!context.mounted) return;
          Get.to(
            () => PremiumItemView(
              itemDetails: Get.find<HomeController>().itemDetailsData.value,
              indexNumber: 0,
            ),
            transition: Transition.upToDown,
          );
        },
        child: Container(
          height: 178.h,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: const Color(0xff241F25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 20.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: item.cover ?? '',
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[700]!,
                  child: Container(color: Colors.grey),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.local_drink_rounded,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 62.sp,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.78),
                      Colors.black.withValues(alpha: 0.40),
                      Colors.black.withValues(alpha: 0.04),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: Text(
                        localizeText(item.name),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.17,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ItemMetaText(
                      item: item,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      width: 160.w,
                      child: Text(
                        localizeText(item.description),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white.withValues(alpha: 0.86),
                          fontSize: 12.sp,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          height: 36.h,
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF1D9),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Text(
                            localizeText('Try Now'),
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: AppColor.primaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 18.w),
                        Text(
                          price,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
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
  }
}
