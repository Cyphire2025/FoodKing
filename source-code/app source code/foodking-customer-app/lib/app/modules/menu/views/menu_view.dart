// ignore_for_file: must_be_immutable, sort_child_properties_last, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../../../widget/bottom_cart_widget.dart';
import '../../../../widget/item_card_grid.dart';
import '../../../../widget/item_card_list.dart';
import '../../../../widget/no_items_available.dart';
import '../../home/widget/home_vew_shimmer.dart';
import '../../search/controllers/search_controller.dart' as search;
import '../../search/views/search_view.dart';
import '../controllers/menu_controller.dart';
import '../widget/menu_view_shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenuView extends StatefulWidget {
  bool? fromHome;
  int? categoryId;

  MenuView({super.key, this.fromHome, this.categoryId});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final box = GetStorage();
  int? value;
  bool? isSelected;
  MenuuController menuController = Get.put(MenuuController());

  @override
  void initState() {
    Get.put(MenuuController());
    if (box.read('viewValue') == null) {
      box.write('viewValue', 0);
    }
    if (menuController.categoryDataList.isNotEmpty) {
      menuController.getCategoryWiseItemDataList(
        menuController.categoryDataList[widget.categoryId!].slug!,
      );
      menuController.fromHome = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuuController>(
      builder: (menuController) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                _MenuHeader(fromHome: widget.fromHome!),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        menuController.categoryDataList.isNotEmpty
                            ? menuSection(widget.fromHome!, widget.categoryId!)
                            : menuSectionShimmer(),
                        menuController.categoryDataList.isNotEmpty
                            ? menuVegNonVegSection(
                                context,
                                box,
                                widget.fromHome!,
                                widget.categoryId!,
                              )
                            : Column(children: [menuItemSectionGridShimmer()]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            widget.fromHome! ? const BottomCartWidget() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _MenuHeader extends StatelessWidget {
  final bool fromHome;

  const _MenuHeader({required this.fromHome});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        14.w,
        MediaQuery.of(context).padding.top + 8.h,
        14.w,
        8.h,
      ),
      color: Colors.white,
      child: SizedBox(
        height: 44.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'MENU'.tr,
              style: TextStyle(
                fontFamily: 'Rubik',
                color: AppColor.fontColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints.tight(Size(40.w, 40.w)),
                icon: Icon(
                  Icons.search_rounded,
                  color: AppColor.fontColor,
                  size: 26.sp,
                ),
                onPressed: () {
                  if (!Get.isRegistered<search.SearchController>()) {
                    Get.put(search.SearchController());
                  }
                  Get.to(() => const SearchView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuHeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 34);
    path.cubicTo(
      size.width * 0.25,
      size.height - 8,
      size.width * 0.48,
      size.height + 6,
      size.width * 0.72,
      size.height - 20,
    );
    path.cubicTo(
      size.width * 0.85,
      size.height - 34,
      size.width * 0.96,
      size.height - 18,
      size.width,
      size.height - 22,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Widget menuSection(bool fromHome, int categoryId) {
  return GetBuilder<MenuuController>(
    builder: (menuController) => Column(
      children: [
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 104.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: menuController.categoryDataList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  menuController.getCategoryWiseItemDataList(
                    menuController.categoryDataList[index].slug!,
                  );
                  menuController.setCategoryIndex(index);
                  menuController.fromHome = false;
                  menuController.currentIndex = index;
                  (context as Element).markNeedsBuild();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: SizedBox(
                    width: 90.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: menuController.fromHome
                                  ? categoryId == index
                                        ? AppColor.primaryColor
                                        : const Color(0xffE8DDE3)
                                  : menuController.currentIndex == index
                                  ? AppColor.primaryColor
                                  : const Color(0xffE8DDE3),
                              width: menuController.fromHome
                                  ? categoryId == index
                                        ? 1.5.w
                                        : 1.w
                                  : menuController.currentIndex == index
                                  ? 1.5.w
                                  : 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.035),
                                blurRadius: 12.r,
                                offset: Offset(0, 5.h),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl:
                                menuController.categoryDataList[index].cover ??
                                '',
                            fit: BoxFit.cover,
                            width: 56.w,
                            height: 56.w,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Container(color: Colors.grey),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.local_drink_rounded,
                              color: AppColor.primaryColor,
                              size: 28.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                menuController.fromHome
                                    ? Text(
                                        localizeText(
                                          menuController
                                              .categoryDataList[index]
                                              .name
                                              .toString(),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                          color: categoryId == index
                                              ? AppColor.primaryColor
                                              : Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )
                                    : Text(
                                        localizeText(
                                          menuController
                                              .categoryDataList[index]
                                              .name
                                              .toString(),
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                          color:
                                              menuController.currentIndex ==
                                                  index
                                              ? AppColor.primaryColor
                                              : Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                menuController.fromHome
                                    ? Container(
                                        height: 4.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            32.r,
                                          ),
                                          color: categoryId == index
                                              ? AppColor.primaryColor
                                              : Colors.white,
                                        ),
                                      )
                                    : Container(
                                        height: 4.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            32.r,
                                          ),
                                          color:
                                              menuController
                                                      .selectedCategoryIndex ==
                                                  index
                                              ? AppColor.primaryColor
                                              : Colors.white,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(height: 2.h, color: AppColor.bgColor),
      ],
    ),
  );
}

Widget menuVegNonVegSection(
  BuildContext context,
  GetStorage box,
  bool fromHome,
  int categoryId,
) {
  return GetBuilder<MenuuController>(
    builder: (menuController) => Expanded(
      child: RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: () async {
          menuController.getCategoryWiseItemDataList(
            menuController.categoryDataList[menuController.currentIndex].slug!,
          );
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 40.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localizeText(
                                  menuController.fromHome
                                      ? menuController
                                            .categoryDataList[categoryId]
                                            .name!
                                      : menuController
                                            .categoryDataList[menuController
                                                .selectedCategoryIndex]
                                            .name!,
                                ),
                                style: TextStyle(
                                  fontFamily: 'serif',
                                  color: const Color(0xff2B1715),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
                        SizedBox(
                          height: 24.h,
                          width: 66.w,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  box.write('viewValue', 0);
                                  (context as Element).markNeedsBuild();
                                },
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: SvgPicture.asset(
                                    Images.iconListView,
                                    fit: BoxFit.cover,
                                    color: box.read('viewValue') == 0
                                        ? AppColor.primaryColor
                                        : AppColor.fontColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 18.w),
                              InkWell(
                                onTap: () {
                                  box.write('viewValue', 1);
                                  (context as Element).markNeedsBuild();
                                },
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: SvgPicture.asset(
                                    Images.iconGridView,
                                    fit: BoxFit.cover,
                                    color: box.read('viewValue') == 1
                                        ? AppColor.primaryColor
                                        : AppColor.fontColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  !menuController.iSmenuItemEmpty
                      ? Column(
                          children: [
                            if (box.read('viewValue') == 1)
                              menuItemSectionGrid(),
                            if (box.read('viewValue') == 0)
                              menuItemSectionList(),
                          ],
                        )
                      : const NoItemsAvailable(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItemSectionGrid() {
  return GetBuilder<MenuuController>(
    builder: (menuController) => !menuController.menuItemLoader
        ? Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
            child: Column(
              children: [
                MasonryGridView.count(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemCount: menuController.categoryItemDataList.length,
                  itemBuilder: (context, index) {
                    return itemCardGrid(
                      menuController.categoryItemDataList,
                      index,
                      context,
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          )
        : menuItemSectionGridShimmer(),
  );
}

Widget menuItemSectionList() {
  return GetBuilder<MenuuController>(
    builder: (menuController) => !menuController.menuItemLoader
        ? Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
            child: Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: menuController.categoryItemDataList.length,
                  itemBuilder: (BuildContext context, index) {
                    return itemCardList(
                      menuController.categoryItemDataList,
                      index,
                      context,
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          )
        : menuItemSectionListShimmer(),
  );
}
