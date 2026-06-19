// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../../../widget/loader.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/views/cart_view.dart';
import '../../offer/controllers/offer_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../search/views/search_view.dart';
import '../controllers/home_controller.dart';
import '../widget/active_order_status.dart';
import '../widget/featured_item_section.dart';
import '../widget/home_menu_section.dart';
import '../widget/home_vew_shimmer.dart';
import '../widget/popular_item_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final box = GetStorage();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().getBranchList();
      Get.find<HomeController>().getCategoryList();
      Get.find<HomeController>().getPopularItemDataList();
      Get.find<HomeController>().getFeaturedItemDataList();
      Get.find<OfferController>().getOfferList();

      if (box.read('isLogedIn') == true) {
        Get.find<HomeController>().getActiveOrderList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xffFFFDFB),
            body: GetBuilder<HomeController>(
              builder: (homeController) => Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          homeController.activeOrderData.isEmpty ||
                              box.read('isLogedIn') == false
                          ? 0
                          : 100.h,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            color: AppColor.primaryColor,
                            onRefresh: () async {
                              homeController.getBranchList();
                              homeController.getCategoryList();
                              homeController.getFeaturedItemDataList();
                              homeController.getPopularItemDataList();
                              if (box.read('isLogedIn') == true) {
                                homeController.getActiveOrderList();
                              }
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              primary: false,
                              scrollDirection: Axis.vertical,
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Current purple header kept in this file below.
                                      // _PremiumHeader(homeController: homeController),
                                      _AppColorHeroHeader(
                                        homeController: homeController,
                                      ),
                                      SizedBox(height: 12.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        child:
                                            homeController.menuLoader ||
                                                homeController
                                                    .categoryDataList
                                                    .isEmpty
                                            ? menuSectionShimmer()
                                            : homeMenuSection(),
                                      ),
                                      homeController.featuredLoader ||
                                              homeController
                                                  .featuredItemDataList
                                                  .isEmpty
                                          ? featureditemSectionShimmer()
                                          : featureditemSection(),
                                      homeController.popularLoader ||
                                              homeController
                                                  .popularItemDataList
                                                  .isEmpty
                                          ? popularItemSectionShimmer()
                                          : popularItemSection(),
                                      // Home offer banners hidden as requested.
                                      // Get.find<OfferController>()
                                      //             .offerDataList
                                      //             .isEmpty ||
                                      //         Get.find<OfferController>().lodear
                                      //     ? const SizedBox.shrink()
                                      //     : Padding(
                                      //         padding: EdgeInsets.symmetric(
                                      //           horizontal: 16.w,
                                      //         ),
                                      //         child: homeOfferSection(),
                                      //       ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (homeController.activeOrderData.isNotEmpty &&
                      box.read('isLogedIn') == true)
                    const ActiveOrderStatus(),
                ],
              ),
            ),
          ),
          Get.find<OfferController>().offerItemlodear
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: const Center(child: LoaderCircle()),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _AppColorHeroHeader extends StatelessWidget {
  final HomeController homeController;

  const _AppColorHeroHeader({required this.homeController});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    final profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    return ClipPath(
      clipper: _HeaderWaveClipper(),
      child: Container(
        height: 302.h + MediaQuery.of(context).padding.top,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primaryColor.withValues(alpha: 0.10),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/jamun bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColor.primaryColor.withValues(alpha: 0.34),
                    AppColor.primaryColor.withValues(alpha: 0.12),
                    Colors.white.withValues(alpha: 0.04),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16.w,
              right: 16.w,
              top: MediaQuery.of(context).padding.top + 12.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.logo,
                        width: 102.w,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      GetBuilder<CartController>(
                        builder: (controller) => InkWell(
                          onTap: () => Get.to(() => CartView(fromNav: false)),
                          borderRadius: BorderRadius.circular(20.r),
                          child: SizedBox(
                            width: 38.w,
                            height: 38.w,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    Images.iconCart,
                                    width: 24.w,
                                    height: 24.w,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                if (controller.cart.isNotEmpty)
                                  Positioned(
                                    top: 1.h,
                                    right: 0,
                                    child: Container(
                                      height: 17.w,
                                      constraints: BoxConstraints(
                                        minWidth: 17.w,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5.w,
                                        ),
                                      ),
                                      child: Text(
                                        controller.cart.length > 99
                                            ? '99+'
                                            : controller.cart.length.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.h),
                  GetBuilder<ProfileController>(
                    init: profileController,
                    builder: (controller) => SizedBox(
                      width: 210.w,
                      child: Text(
                        _homeGreeting(controller),
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 11.h),
                  SizedBox(
                    width: 148.w,
                    child: Text(
                      localizeText('Pure ingredients.\nReal results.'),
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.32,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () => Get.to(() => const SearchView()),
                    child: homeController.loader
                        ? Shimmer.fromColors(
                            baseColor: Colors.white.withValues(alpha: 0.55),
                            highlightColor: Colors.white.withValues(alpha: 0.8),
                            child: Container(
                              height: 43.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23.r),
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            height: 43.h,
                            padding: EdgeInsets.only(left: 14.w, right: 4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primaryColor.withValues(
                                    alpha: 0.18,
                                  ),
                                  blurRadius: 18.r,
                                  offset: Offset(0, 8.h),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Images.iconSearch,
                                  width: 19.w,
                                  height: 19.w,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xff27212B),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 9.w),
                                Expanded(
                                  child: Text(
                                    localizeText(
                                      'Search drinks, shots & more...',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: AppColor.gray,
                                      fontSize: 10.5.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 34.w,
                                  width: 34.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.tune_rounded,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
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
    );
  }
}

String _homeGreeting(ProfileController profileController) {
  final hour = DateTime.now().hour;
  final greeting = hour < 12
      ? localizeText('Good Morning')
      : hour < 17
      ? localizeText('Good Afternoon')
      : localizeText('Good Evening');

  final box = GetStorage();
  if (box.read('isLogedIn') != true) {
    return greeting;
  }

  final firstName = profileController.profileData.firstName?.trim();
  if (firstName == null || firstName.isEmpty || firstName == 'null') {
    return greeting;
  }

  return '$greeting $firstName';
}

class _PremiumHeader extends StatelessWidget {
  final HomeController homeController;

  const _PremiumHeader({required this.homeController});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
        ? 'Good Afternoon'
        : 'Good Evening';
    return ClipPath(
      clipper: _HeaderWaveClipper(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          20.w,
          MediaQuery.of(context).padding.top + 8.h,
          20.w,
          42.h,
        ),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/jamun bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Color(0xB8542145), BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(Images.logo, width: 96.w, fit: BoxFit.contain),
                const Spacer(),
              ],
            ),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizeText(greeting),
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  localizeText('What are you craving today?'),
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white.withOpacity(0.86),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            GestureDetector(
              onTap: () => Get.to(() => const SearchView()),
              child: homeController.loader
                  ? Shimmer.fromColors(
                      baseColor: Colors.white.withOpacity(0.55),
                      highlightColor: Colors.white.withOpacity(0.8),
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.82,
                        child: Container(
                          height: 42.h,
                          padding: EdgeInsets.only(left: 14.w, right: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 18.r,
                                offset: Offset(0, 8.h),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.iconSearch,
                                width: 20.w,
                                height: 20.w,
                                color: const Color(0xff27212B),
                              ),
                              SizedBox(width: 9.w),
                              Expanded(
                                child: Text(
                                  localizeText(
                                    'Search shakes, drinks and more...',
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: AppColor.gray,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                              Container(
                                height: 34.w,
                                width: 34.w,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const _RotatingGlassIcon(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RotatingGlassIcon extends StatefulWidget {
  const _RotatingGlassIcon();

  @override
  State<_RotatingGlassIcon> createState() => _RotatingGlassIconState();
}

class _RotatingGlassIconState extends State<_RotatingGlassIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _controller.isAnimating) return;
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
      child: Icon(Icons.local_bar_rounded, color: Colors.white, size: 19.sp),
    );
  }
}

class _HeaderWaveClipper extends CustomClipper<Path> {
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
