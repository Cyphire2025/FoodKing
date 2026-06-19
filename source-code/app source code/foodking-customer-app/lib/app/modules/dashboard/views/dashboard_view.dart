// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../helper/device_token.dart';
import '../../../../helper/notification_helper.dart';
import '../../../../util/constant.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/views/cart_view.dart';
import '../../home/views/home_view.dart';
import '../../menu/views/menu_view.dart';
import '../../offer/views/offer_view.dart';
import '../../order/views/order_view.dart';
import '../../profile/views/profile_view.dart';
import '../widget/nav_bar_item.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardView> {
  final box = GetStorage();
  PageController? pageController;
  int pageIndex = 0;
  List<Widget>? screens;
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
  bool canExit = false;
  NotificationHelper notificationHelper = NotificationHelper();
  DeviceToken deviceToken = DeviceToken();
  @override
  void initState() {
    pageIndex = 0;
    pageController = PageController(initialPage: 0);
    screens = [
      HomeView(),
      MenuView(fromHome: false, categoryId: 0),
      CartView(fromNav: true),
      const OrderView(showBackButton: false),
      ProfileView(),
      OfferView(),
    ];
    notificationHelper.notificationPermission();
    if (box.read('isLogedIn')) {
      deviceToken.getDeviceToken();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canExit,
      onPopInvokedWithResult: (_, dynamic) async {
        if (pageIndex != 0) {
          _setPage(0);
        } else {
          if (canExit) {
            SystemNavigator.pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'PRESS_BACK_AGAIN_TO_EXIT'.tr,
                  style: TextStyle(color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primaryColor,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(10),
              ),
            );
            canExit = true;
            Timer(Duration(seconds: 2), () {
              canExit = false;
            });
          }
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withValues(alpha: 0.3),
                offset: const Offset(0.0, 8.0),
                blurRadius: 18.r,
                spreadRadius: 1.r,
              ),
            ],
          ),
          child: SizedBox(
            height: 64.w,
            width: 64.w,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColor.primaryColor,
              onPressed: () {
                _setPage(5);
              },
              child: SizedBox(
                height: 68.w,
                width: 68.w,
                child: CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  child: const _RotatingCartDrinkIcon(),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          notchMargin: 8,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 74.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 18.r,
                  offset: Offset(0, -4.h),
                ),
              ],
            ),
            child: Row(
              children: [
                BottomNavItem(
                  tittle: "HOME".tr,
                  svgPath: Images.iconHome,
                  isSelected: pageIndex == 0,
                  onTap: () => _setPage(0),
                ),
                BottomNavItem(
                  tittle: "MENU".tr,
                  svgPath: Images.iconMenu,
                  isSelected: pageIndex == 1,
                  onTap: () => _setPage(1),
                ),
                Expanded(child: SizedBox()),
                BottomNavItem(
                  tittle: "ORDER".tr,
                  svgPath: Images.order,
                  isSelected: pageIndex == 3,
                  onTap: () => _setPage(3),
                ),
                BottomNavItem(
                  tittle: "PROFILE".tr,
                  imageData: AssetImage(Images.profile_circle),
                  isSelected: pageIndex == 4,
                  onTap: () {
                    _setPage(4);
                  },
                ),
              ],
            ),
          ),
        ),
        body: GetBuilder<CartController>(
          builder: (cartController) {
            final showCartPreview =
                cartController.cart.isNotEmpty &&
                (pageIndex == 0 || pageIndex == 1 || pageIndex == 5);

            return Stack(
              children: [
                AnimatedPadding(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.only(bottom: showCartPreview ? 118.h : 0),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: screens!.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return screens![index];
                    },
                  ),
                ),
                if (showCartPreview)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _CartPreviewBar(
                      cartController: cartController,
                      onViewCart: () => _setPage(2),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _setPage(int index) {
    setState(() {
      pageController?.jumpToPage(index);
      pageIndex = index;
    });
  }
}

class _CartPreviewBar extends StatelessWidget {
  final CartController cartController;
  final VoidCallback onViewCart;

  const _CartPreviewBar({
    required this.cartController,
    required this.onViewCart,
  });

  @override
  Widget build(BuildContext context) {
    final firstItem = cartController.cart.first.itemName ?? '';
    final firstItemImage = cartController.cart.first.itemImage ?? '';
    final extraItemCount = cartController.cart.length - 1;
    final currencySymbol =
        GetStorage().read('currencySymbol')?.toString() ?? '';
    final cartTotal =
        '$currencySymbol${cartController.totalCartValue.toStringAsFixed(2)}';

    return Material(
      color: Colors.transparent,
      child: Container(
        height: 100.h,
        padding: EdgeInsets.fromLTRB(22.w, 14.h, 22.w, 24.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.primaryColor,
              AppColor.primaryColor.withValues(alpha: 0.78),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withValues(alpha: 0.22),
              blurRadius: 20.r,
              offset: Offset(0, -6.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.45),
                  width: 1.2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: firstItemImage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: firstItemImage,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.local_drink_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstItem,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.white.withValues(alpha: 0.82),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (extraItemCount > 0) ...[
                    SizedBox(height: 2.h),
                    Text(
                      '+ $extraItemCount more',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.white.withValues(alpha: 0.72),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                  SizedBox(height: 4.h),
                  Text(
                    cartTotal,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            ElevatedButton(
              onPressed: onViewCart,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: AppColor.primaryColor,
                minimumSize: Size(126.w, 46.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              child: Text(
                'View Cart',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RotatingCartDrinkIcon extends StatefulWidget {
  const _RotatingCartDrinkIcon();

  @override
  State<_RotatingCartDrinkIcon> createState() => _RotatingCartDrinkIconState();
}

class _RotatingCartDrinkIconState extends State<_RotatingCartDrinkIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Timer _timer;
  bool _showJuice = true;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 850),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() => _showJuice = !_showJuice);
            _controller.reset();
          }
        });

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final value = Curves.easeInOutCubic.transform(_controller.value);
        final useNextIcon = value >= 0.5;
        final icon = _showJuice == useNextIcon
            ? Icons.emoji_food_beverage_rounded
            : Icons.local_drink_rounded;
        final midpointFade = (value - 0.5).abs() * 2;
        final opacity = 0.45 + (midpointFade * 0.55);
        final scale = 0.88 + (midpointFade * 0.12);

        return Transform.rotate(
          angle: value * 6.283185307179586,
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: Icon(icon, color: Colors.white, size: 34.sp),
            ),
          ),
        );
      },
    );
  }
}
