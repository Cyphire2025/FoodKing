// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_bottom_widget.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/empty_cart_view.dart';

class CartView extends StatefulWidget {
  bool? fromNav;
  CartView({super.key, this.fromNav});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    Get.find<CartController>().orderTypeIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final splashController = Get.put(SplashController());

    return GetBuilder<CartController>(
      builder: (cartController) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _CartTopSection(
                fromNav: widget.fromNav ?? false,
                splashController: splashController,
                cartController: cartController,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    cartController.cart.isNotEmpty
                        ? Expanded(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 160),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [cartItemSection()],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: (widget.fromNav ?? false) ? 40 : 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.itembg.withOpacity(0.5),
                                          offset: const Offset(0.0, -10.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    child: cartBottomSection(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Expanded(child: EmptyCartView()),
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

class _CartTopSection extends StatelessWidget {
  final bool fromNav;
  final SplashController splashController;
  final CartController cartController;

  const _CartTopSection({
    required this.fromNav,
    required this.splashController,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!fromNav)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        Images.back,
                        colorFilter: ColorFilter.mode(
                          AppColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: Get.back,
                    ),
                  ),
                Center(
                  child: Text(
                    'MY_CART'.tr,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: AppColor.primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _CartOrderTypeSelector(
            splashController: splashController,
            cartController: cartController,
          ),
        ],
      ),
    );
  }
}

class _CartOrderTypeSelector extends StatelessWidget {
  final SplashController splashController;
  final CartController cartController;

  const _CartOrderTypeSelector({
    required this.splashController,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryEnabled = splashController.configData.orderSetupDelivery == 5;
    final takeawayEnabled = splashController.configData.orderSetupTakeaway == 5;

    final options = <_OrderTypeOption>[];
    if (deliveryEnabled) {
      options.add(
        _OrderTypeOption(
          label: 'DELIVERY'.tr,
          controllerIndex: 0,
        ),
      );
    }
    if (takeawayEnabled) {
      options.add(
        _OrderTypeOption(
          label: 'TAKEAWAY'.tr,
          controllerIndex: deliveryEnabled ? 1 : 0,
        ),
      );
    }

    if (options.isEmpty) return const SizedBox.shrink();

    return Row(
      children: options
          .map(
            (option) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: option == options.first && options.length > 1 ? 8.w : 0,
                  left: option != options.first ? 8.w : 0,
                ),
                child: _OrderTypeBox(
                  label: option.label,
                  selected:
                      cartController.orderTypeIndex == option.controllerIndex,
                  onTap: () {
                    cartController.setDeliveryOrTakey(option.controllerIndex);
                  },
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _OrderTypeBox extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OrderTypeBox({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 44.h,
        decoration: BoxDecoration(
          color: selected ? AppColor.primaryColor : const Color(0xffF5E8F2),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: selected ? AppColor.primaryColor : const Color(0xffE6D5E3),
            width: 1.w,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Rubik',
            color: selected ? Colors.white : AppColor.primaryColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _OrderTypeOption {
  final String label;
  final int controllerIndex;

  const _OrderTypeOption({
    required this.label,
    required this.controllerIndex,
  });
}
