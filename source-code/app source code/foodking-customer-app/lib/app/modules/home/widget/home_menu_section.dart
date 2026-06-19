import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../menu/controllers/menu_controller.dart';
import '../../menu/views/menu_view.dart';
import 'home_vew_shimmer.dart';

Widget homeMenuSection() {
  return GetBuilder<MenuuController>(
    builder: (menuController) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
          offstage: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizeText("Explore Our Menu"),
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
              InkWell(
                onTap: () {
                  Get.to(() => MenuView(fromHome: true, categoryId: 0));
                },
                child: Row(
                  children: [
                    Text(
                      "VIEW_ALL".tr,
                      style: TextStyle(
                        fontFamily: 'serif',
                        color: AppColor.primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      width: 21.w,
                      height: 21.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xfffffbf4),
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColor.primaryColor,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        menuController.categoryDataList.isNotEmpty
            ? _AutoScrollingMenuCategories(menuController: menuController)
            : menuSectionShimmer(),
      ],
    ),
  );
}

class _AutoScrollingMenuCategories extends StatefulWidget {
  final MenuuController menuController;

  const _AutoScrollingMenuCategories({required this.menuController});

  @override
  State<_AutoScrollingMenuCategories> createState() =>
      _AutoScrollingMenuCategoriesState();
}

class _AutoScrollingMenuCategoriesState
    extends State<_AutoScrollingMenuCategories> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!_controller.hasClients ||
          _isUserScrolling ||
          widget.menuController.categoryDataList.length < 2) {
        return;
      }

      final nextOffset = _controller.offset + 0.5.w;
      if (nextOffset >= _controller.position.maxScrollExtent) {
        _controller.jumpTo(_controller.position.minScrollExtent);
        return;
      }
      _controller.jumpTo(nextOffset);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.menuController.categoryDataList;

    return SizedBox(
      width: double.infinity,
      height: 104.h,
      child: Listener(
        onPointerDown: (_) => _isUserScrolling = true,
        onPointerCancel: (_) => _isUserScrolling = false,
        onPointerUp: (_) => _isUserScrolling = false,
        child: ListView.builder(
          controller: _controller,
          clipBehavior: Clip.none,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: () {
                Get.to(() => MenuView(fromHome: true, categoryId: index));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 18.w),
                child: SizedBox(
                  width: 76.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 61.w,
                        height: 61.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: index == 0
                                ? AppColor.primaryColor
                                : const Color(0xffE8DDE3),
                            width: index == 0 ? 1.5.w : 1.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.035),
                              blurRadius: 12.r,
                              offset: Offset(0, 5.h),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Transform.scale(
                          scale: 1.05,
                          child: CachedNetworkImage(
                            imageUrl: categories[index].cover ?? '',
                            fit: BoxFit.cover,
                            width: 61.w,
                            height: 61.w,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Container(color: Colors.grey),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.local_drink_rounded,
                              color: AppColor.primaryColor,
                              size: 30.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        localizeText(categories[index].name.toString()),
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: const Color(0xff2C2230),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
