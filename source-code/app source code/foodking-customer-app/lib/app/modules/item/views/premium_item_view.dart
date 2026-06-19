import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../../../widget/custom_toast.dart';
import '../../../data/model/response/item_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../menu/controllers/menu_controller.dart';

class PremiumItemView extends StatefulWidget {
  final ItemData itemDetails;
  final int indexNumber;

  const PremiumItemView({
    super.key,
    required this.itemDetails,
    required this.indexNumber,
  });

  @override
  State<PremiumItemView> createState() => _PremiumItemViewState();
}

class _PremiumItemViewState extends State<PremiumItemView> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<CartController>().itemQuantity = 1;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  bool get _isHotDrink {
    final itemType = widget.itemDetails.itemType;
    if (itemType == 10) return true;
    if (itemType == 5) return false;

    final value =
        '${widget.itemDetails.name ?? ''} ${widget.itemDetails.slug ?? ''}'
            .toLowerCase();
    if (RegExp(r'(^|[\s-])hot([\s-]|$)').hasMatch(value)) return true;
    if (!Get.isRegistered<MenuuController>()) return false;

    final menuController = Get.find<MenuuController>();
    final categoryIndex = menuController.fromHome
        ? menuController.currentIndex
        : menuController.selectedCategoryIndex;
    if (categoryIndex < 0 ||
        categoryIndex >= menuController.categoryDataList.length) {
      return false;
    }
    final category = menuController.categoryDataList[categoryIndex];
    final categoryValue = '${category.name ?? ''} ${category.slug ?? ''}'
        .toLowerCase()
        .replaceAll('-', ' ');
    return categoryValue.contains('hot') && categoryValue.contains('drink');
  }

  String get _price =>
      widget.itemDetails.offer != null && widget.itemDetails.offer!.isNotEmpty
      ? widget.itemDetails.offer!.first.currencyPrice ??
            widget.itemDetails.currencyPrice ??
            ''
      : widget.itemDetails.currencyPrice ?? '';

  double get _unitPrice =>
      widget.itemDetails.offer != null && widget.itemDetails.offer!.isNotEmpty
      ? widget.itemDetails.offer!.first.convertPrice ??
            widget.itemDetails.convertPrice ??
            0
      : widget.itemDetails.convertPrice ?? 0;

  String _totalPrice(CartController cartController) {
    final symbol = _price.replaceAll(RegExp(r'[0-9.,\s]'), '');
    final total = _unitPrice * cartController.itemQuantity;
    return symbol.isEmpty
        ? total.toStringAsFixed(2)
        : '$symbol${total.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        return Scaffold(
          backgroundColor: const Color(0xfffffbf4),
          body: Column(
            children: [
              _HeroImage(item: widget.itemDetails),
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -42.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xfffffbf4),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                          MediaQuery.of(context).size.width,
                          34.h,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _TagPill(),
                                SizedBox(height: 10.h),
                                _AutoScrollingProductTitle(
                                  text: localizeText(widget.itemDetails.name),
                                  style: GoogleFonts.playfairDisplay(
                                    color: const Color(0xff401E21),
                                    fontSize: 27.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                _HeaderMetaLine(item: widget.itemDetails),
                                SizedBox(height: 6.h),
                                Container(
                                  width: 34.w,
                                  height: 1.5.h,
                                  color: const Color(0xffE9D6CF),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        localizeText(widget.itemDetails.description),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          color: const Color(0xff555060),
                                          fontSize: 12.sp,
                                          height: 1.25,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 14.w),
                                    _QuantityStepper(cartController: cartController),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  _price,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: AppColor.primaryColor,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                _GoodInEverySip(isHotDrink: _isHotDrink),
                                if ((widget.itemDetails.caution ?? '')
                                    .toString()
                                    .trim()
                                    .isNotEmpty) ...[
                                  SizedBox(height: 10.h),
                                  _CautionCard(item: widget.itemDetails),
                                ],
                                SizedBox(height: 8.h),
                                _NoteCard(controller: _noteController),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: _AddToCartButton(
                            total: _totalPrice(cartController),
                            onTap: () {
                              if (cartController.itemQuantity == 0) {
                                customTast(
                                  "PLEASE_INCREASE_QUANTITY".tr,
                                  AppColor.error,
                                );
                                return;
                              }
                              try {
                                cartController.addItem(
                                  widget.itemDetails,
                                  [],
                                  [],
                                  _unitPrice * cartController.itemQuantity,
                                  0.0,
                                  0.0,
                                  _noteController.text,
                                );
                                cartController.addItemAddons([]);
                                customTast(
                                  "ADDED_TO_CART".tr,
                                  AppColor.success,
                                );
                                Get.back();
                              } catch (error, stackTrace) {
                                debugPrint(
                                  'Add to cart failed: $error\n$stackTrace',
                                );
                                customTast(
                                  "SOMETHING_WRONG".tr,
                                  AppColor.error,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AutoScrollingProductTitle extends StatefulWidget {
  final String text;
  final TextStyle style;

  const _AutoScrollingProductTitle({required this.text, required this.style});

  @override
  State<_AutoScrollingProductTitle> createState() =>
      _AutoScrollingProductTitleState();
}

class _AutoScrollingProductTitleState
    extends State<_AutoScrollingProductTitle> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startIfOverflow());
  }

  @override
  void didUpdateWidget(covariant _AutoScrollingProductTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _timer?.cancel();
      WidgetsBinding.instance.addPostFrameCallback((_) => _startIfOverflow());
    }
  }

  void _startIfOverflow() {
    if (!mounted || !_controller.hasClients) return;
    final max = _controller.position.maxScrollExtent;
    if (max <= 0) return;

    _timer = Timer.periodic(const Duration(milliseconds: 2600), (_) async {
      if (!mounted || !_controller.hasClients) return;
      await _controller.animateTo(
        max,
        duration: const Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      if (!mounted || !_controller.hasClients) return;
      await Future.delayed(const Duration(milliseconds: 550));
      if (!mounted || !_controller.hasClients) return;
      await _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
      );
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
    return SizedBox(
      height: 33.h,
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Text(widget.text, maxLines: 1, style: widget.style),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final ItemData item;

  const _HeroImage({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 292.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipPath(
            clipper: _HeroBottomWaveClipper(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: item.preview ?? item.cover ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: Container(color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.local_drink_rounded,
                    color: AppColor.primaryColor,
                    size: 54.sp,
                  ),
                ),
                Container(color: Colors.black.withValues(alpha: 0.06)),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 14.h,
            left: 22.w,
            child: _CircleIconButton(
              icon: Icons.arrow_back_rounded,
              onTap: Get.back,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBottomWaveClipper extends CustomClipper<Path> {
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

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22.r),
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Icon(icon, color: AppColor.primaryColor, size: 23.sp),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xffF5DDE3),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_drink_rounded,
            color: AppColor.primaryColor,
            size: 12.sp,
          ),
          SizedBox(width: 5.w),
          Text(
            localizeText('DRINK'),
            style: TextStyle(
              fontFamily: 'Rubik',
              color: AppColor.primaryColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final CartController cartController;

  const _QuantityStepper({required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 112.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xffE8DAD6), width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StepButton(
            icon: Icons.remove_rounded,
            onTap: cartController.removeQuantity,
          ),
          Text(
            cartController.itemQuantity.toString(),
            style: TextStyle(
              fontFamily: 'Rubik',
              color: AppColor.primaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            onTap: cartController.addQuantity,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        width: 23.w,
        height: 23.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.primaryColor, width: 2.w),
        ),
        child: Icon(icon, color: AppColor.primaryColor, size: 15.sp),
      ),
    );
  }
}

class _GoodInEverySip extends StatelessWidget {
  final bool isHotDrink;

  const _GoodInEverySip({required this.isHotDrink});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: const Color(0xffE8DAD6), thickness: 1.w),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                localizeText('GOOD IN EVERY SIP'),
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: AppColor.primaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: const Color(0xffE8DAD6), thickness: 1.w),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _SipBenefit(
              icon: Icons.eco_outlined,
              label: localizeText('Natural\nIngredients'),
            ),
            _VerticalDivider(),
            _SipBenefit(
              icon: isHotDrink
                  ? Icons.local_fire_department_outlined
                  : Icons.ac_unit_rounded,
              label: localizeText(
                isHotDrink ? 'Served\nHot' : 'Served\nChilled',
              ),
            ),
            _VerticalDivider(),
            _SipBenefit(
              icon: Icons.verified_user_outlined,
              label: localizeText('Hygienically\nPrepared'),
            ),
          ],
        ),
      ],
    );
  }
}

class _SipBenefit extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SipBenefit({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColor.primaryColor, size: 24.sp),
          SizedBox(height: 7.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rubik',
              color: const Color(0xff34313D),
              fontSize: 10.5.sp,
              height: 1.15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1.w, height: 54.h, color: const Color(0xffE8DAD6));
  }
}

class _HeaderMetaLine extends StatelessWidget {
  final ItemData item;

  const _HeaderMetaLine({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = (item.size ?? '').trim();
    final calories = item.calories;
    final caloriesText = calories == null || calories <= 0
        ? '--'
        : '$calories kcal';

    return Text(
      '${localizeText('Size')}: ${size.isEmpty ? '--' : size}    ${localizeText('Calories')}: $caloriesText',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Rubik',
        color: AppColor.primaryColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }
}

class _CautionCard extends StatelessWidget {
  final ItemData item;

  const _CautionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final caution = (item.caution ?? '').toString().trim();
    if (caution.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xffEFE6E2), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: Color(0xffF5E9EA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: AppColor.primaryColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizeText('Caution'),
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: const Color(0xff2B1715),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  localizeText(caution),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: AppColor.primaryColor,
                    fontSize: 10.5.sp,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final TextEditingController controller;

  const _NoteCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xffEFE6E2), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: const BoxDecoration(
              color: Color(0xffF5E9EA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.edit_note_rounded,
              color: AppColor.primaryColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                labelText: localizeText('Add a note (optional)'),
                labelStyle: TextStyle(
                  fontFamily: 'Rubik',
                  color: const Color(0xff2B1715),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
                hintText: localizeText('Add note (extra mayo, cheese, etc.)'),
                hintStyle: TextStyle(
                  fontFamily: 'Rubik',
                  color: const Color(0xff6F6872),
                  fontSize: 10.5.sp,
                ),
              ),
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColor.primaryColor,
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final String total;
  final VoidCallback onTap;

  const _AddToCartButton({required this.total, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.iconCart,
            width: 17.w,
            height: 17.w,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          SizedBox(width: 12.w),
          Text(
            'ADD_TO_CARTS'.tr,
            style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            total,
            style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
