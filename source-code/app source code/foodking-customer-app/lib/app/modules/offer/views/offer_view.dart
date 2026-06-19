// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/no_items_available.dart';
import '../../../data/model/response/config_model.dart';
import '../../../data/model/response/coupon_model.dart';
import '../../checkout/controllers/coupon_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../widget/offer_shimmer.dart';

class OfferView extends StatefulWidget {
  const OfferView({super.key});

  @override
  State<OfferView> createState() => _OfferViewState();
}

class _OfferViewState extends State<OfferView> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    final couponController = Get.isRegistered<CouponController>()
        ? Get.find<CouponController>()
        : Get.put(CouponController());
    couponController.getCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 18.h),
              child: _OffersTabToggle(
                selectedIndex: _selectedTab,
                onChanged: (index) {
                  setState(() => _selectedTab = index);
                },
              ),
            ),
            Expanded(
              child: _selectedTab == 0
                  ? GetBuilder<CouponController>(
                      builder: (couponController) => couponController.loader
                          ? const OfferShimmer()
                          : RefreshIndicator(
                              color: AppColor.primaryColor,
                              onRefresh: () async {
                                await couponController.getCouponList();
                              },
                              child: couponController.couponDataList.isEmpty
                                  ? const SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: SizedBox(
                                        height: 520,
                                        child: NoItemsAvailable(),
                                      ),
                                    )
                                  : ListView.separated(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.fromLTRB(
                                        16.w,
                                        0,
                                        16.w,
                                        24.h,
                                      ),
                                      itemCount: couponController
                                          .couponDataList
                                          .length,
                                      separatorBuilder: (_, index) =>
                                          SizedBox(height: 14.h),
                                      itemBuilder: (context, index) =>
                                          _CouponOfferCard(
                                            coupon: couponController
                                                .couponDataList[index],
                                          ),
                                    ),
                            ),
                    )
                  : const _LatestUpdatesView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _OffersTabToggle extends StatelessWidget {
  const _OffersTabToggle({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: AppColor.primaryColor.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          _OffersTabButton(
            label: 'Offers',
            selected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
          _OffersTabButton(
            label: 'Latest Updates',
            selected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _OffersTabButton extends StatelessWidget {
  const _OffersTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(999.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColor.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: fontBold.copyWith(
              color: selected ? Colors.white : AppColor.fontColor,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _LatestUpdatesView extends StatelessWidget {
  const _LatestUpdatesView();

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SplashController>()) {
      return const NoItemsAvailable();
    }

    return GetBuilder<SplashController>(
      builder: (splashController) {
        final updates = <LatestUpdateData>[
          ...splashController.configData.latestUpdates,
        ];
        if (updates.isEmpty &&
            splashController.configData.latestUpdate != null) {
          updates.add(splashController.configData.latestUpdate!);
        }
        final visibleUpdates = updates
            .where(
              (update) => [
                update.imageUrl,
                update.heading,
                update.description,
              ].any((value) => (value ?? '').trim().isNotEmpty),
            )
            .toList();

        if (visibleUpdates.isEmpty) {
          return const NoItemsAvailable();
        }

        return RefreshIndicator(
          color: AppColor.primaryColor,
          onRefresh: () async {
            await splashController.getConfiguration();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
            children: [
              for (final update in visibleUpdates) ...[
                _LatestUpdateCard(update: update),
                SizedBox(height: 14.h),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _LatestUpdateCard extends StatelessWidget {
  const _LatestUpdateCard({required this.update});

  final LatestUpdateData update;

  @override
  Widget build(BuildContext context) {
    final imageUrl = update.imageUrl?.trim() ?? '';
    final heading = update.heading?.trim() ?? '';
    final description = update.description?.trim() ?? '';
    final buttons = [
      if (update.buttonOneEnabled)
        _UpdateButtonData(
          text: update.buttonOneText,
          link: update.buttonOneLink,
        ),
      if (update.buttonTwoEnabled)
        _UpdateButtonData(
          text: update.buttonTwoText,
          link: update.buttonTwoLink,
        ),
    ].where((button) => button.text.trim().isNotEmpty).toList();

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColor.primaryColor.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: AppColor.addNewBtnColor,
            ),
            child: AspectRatio(
              aspectRatio: 2.28,
              child: imageUrl.isEmpty
                  ? _BannerFallback()
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => _BannerFallback(),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.r, 14.r, 16.r, 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (heading.isNotEmpty) ...[
                  Text(
                    heading,
                    style: fontBold.copyWith(
                      color: AppColor.fontColor,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: fontRegular.copyWith(
                      color: AppColor.gray,
                      fontSize: 13.sp,
                      height: 1.35,
                    ),
                  ),
                if (buttons.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 100.w,
                      runSpacing: 8.h,
                      children: buttons
                          .map((button) => _LatestUpdateButton(button: button))
                          .toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestUpdateButton extends StatelessWidget {
  const _LatestUpdateButton({required this.button});

  final _UpdateButtonData button;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999.r),
      onTap: button.link.trim().isEmpty
          ? null
          : () async {
              final uri = Uri.tryParse(button.link.trim());
              if (uri == null) return;
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColor.addNewBtnColor,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: AppColor.primaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          button.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: fontBold.copyWith(
            color: AppColor.primaryColor,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}

class _UpdateButtonData {
  final String text;
  final String link;

  const _UpdateButtonData({required String? text, required String? link})
    : text = text ?? '',
      link = link ?? '';
}

class _CouponOfferCard extends StatelessWidget {
  const _CouponOfferCard({required this.coupon});

  final CouponData coupon;

  @override
  Widget build(BuildContext context) {
    final code = (coupon.code ?? coupon.name ?? '').trim();
    final discount = _discountText(coupon);
    final minOrder = coupon.minimumOrderCurrencyAmount;
    final localBanner = _localCouponBanner(code);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColor.primaryColor.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: AppColor.addNewBtnColor,
            ),
            child: AspectRatio(
              aspectRatio: 2.28,
              child: localBanner == null
                  ? CachedNetworkImage(
                      imageUrl: coupon.image.toString(),
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => _BannerFallback(),
                    )
                  : Image.asset(
                      localBanner,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.r, 14.r, 16.r, 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((coupon.name ?? code).isNotEmpty) ...[
                  Text(
                    coupon.name ?? code,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: fontBold.copyWith(
                      color: AppColor.fontColor,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        discount,
                        style: fontBold.copyWith(
                          color: AppColor.primaryColor,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    _CodePill(code: code),
                  ],
                ),
                if ((coupon.description ?? '').trim().isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    coupon.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: fontRegular.copyWith(
                      color: AppColor.gray,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    if ((minOrder ?? '').isNotEmpty)
                      _InfoChip(text: 'Min order $minOrder'),
                    if ((coupon.convertEndDate ?? '').isNotEmpty)
                      _InfoChip(text: 'Valid till ${coupon.convertEndDate}'),
                    if (coupon.limitPerUser != null)
                      _InfoChip(text: '${coupon.limitPerUser} use per user'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _discountText(CouponData coupon) {
    if (coupon.discountType == 5) {
      final discount = coupon.discount?.replaceAll(RegExp(r'\.0+$'), '');
      return '${discount ?? ''}% off';
    }

    return '${coupon.currencyDiscount ?? coupon.discount ?? ''} off';
  }

  String? _localCouponBanner(String code) {
    final normalizedCode = code.trim().toUpperCase();
    if (normalizedCode == 'NEW50') {
      return 'assets/images/coupon1.png';
    }
    if (normalizedCode == 'REG10') {
      return 'assets/images/coupon2.png';
    }
    return null;
  }
}

class _BannerFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.addNewBtnColor,
      alignment: Alignment.center,
      child: Icon(
        Icons.local_offer_rounded,
        color: AppColor.primaryColor,
        size: 42.r,
      ),
    );
  }
}

class _CodePill extends StatelessWidget {
  const _CodePill({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999.r),
      onTap: code.isEmpty
          ? null
          : () {
              Clipboard.setData(ClipboardData(text: code));
              Get.snackbar(
                'Copied',
                '$code copied',
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColor.primaryColor,
                colorText: Colors.white,
                margin: EdgeInsets.all(14.r),
                duration: const Duration(milliseconds: 1200),
              );
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColor.addNewBtnColor,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: AppColor.primaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.confirmation_number_rounded,
              color: AppColor.primaryColor,
              size: 16.r,
            ),
            SizedBox(width: 6.w),
            Text(
              code,
              style: fontBold.copyWith(
                color: AppColor.primaryColor,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColor.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        text,
        style: fontRegular.copyWith(color: AppColor.gray, fontSize: 12.sp),
      ),
    );
  }
}
