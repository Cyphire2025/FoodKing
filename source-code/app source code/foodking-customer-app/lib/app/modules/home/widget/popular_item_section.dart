import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/modules/item/views/premium_item_view.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../util/localized_text.dart';
import '../../../../widget/item_cart_actions.dart';
import '../../../../widget/item_meta_text.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/category_wise_item_model.dart';
import '../../../data/model/response/item_model.dart';
import '../../menu/views/menu_view.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/home_controller.dart';

Widget popularItemSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizeText("Popular Right Now"),
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
                borderRadius: BorderRadius.circular(18.r),
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
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 256.h,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.popularItemDataList.length > 6
                  ? 6
                  : homeController.popularItemDataList.length,
              itemBuilder: (BuildContext context, index) {
                return _PopularProductCard(
                  item: homeController.popularItemDataList[index],
                  index: index,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const _CouponCarousel(),
        ),
        SizedBox(height: 16.h),
        _NewArrivalsSection(homeController: homeController),
        SizedBox(height: 12.h),
        const _HomeDynamicBanner(
          fallbackAsset: 'assets/images/special.png',
          bannerNumber: 1,
        ),
        SizedBox(height: 12.h),
        _FruitLoversSection(homeController: homeController),
        SizedBox(height: 12.h),
        const _HomeDynamicBanner(
          fallbackAsset: 'assets/images/pairing.png',
          bannerNumber: 2,
        ),
        // Most Popular Items section hidden as requested.
        // Padding(
        //   padding: EdgeInsets.only(top: 24.h, bottom: 13.h),
        //   child: Text("MOST_POPULAR_ITEMS".tr, style: fontBold),
        // ),
        // ListView.builder(
        //   primary: false,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: homeController.popularItemDataList.length > 4
        //       ? 4
        //       : homeController.popularItemDataList.length,
        //   itemBuilder: (BuildContext context, index) {
        //     return itemCardList(
        //       homeController.popularItemDataList,
        //       index,
        //       context,
        //     );
        //   },
        // ),
      ],
    ),
  );
}

class _HomeDynamicBanner extends StatelessWidget {
  final String fallbackAsset;
  final int bannerNumber;

  const _HomeDynamicBanner({
    required this.fallbackAsset,
    required this.bannerNumber,
  });

  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    if (Get.isRegistered<SplashController>()) {
      final config = Get.find<SplashController>().configData;
      imageUrl = bannerNumber == 1
          ? config.appBannerOneUrl?.trim()
          : config.appBannerTwoUrl?.trim();
    }

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          fallbackAsset,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          fallbackAsset,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      fallbackAsset,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class _CouponCarousel extends StatefulWidget {
  const _CouponCarousel();

  @override
  State<_CouponCarousel> createState() => _CouponCarouselState();
}

class _CouponCarouselState extends State<_CouponCarousel> {
  final ScrollController _controller = ScrollController();
  final List<String> _coupons = const [
    'assets/images/coupon1.png',
    'assets/images/coupon2.png',
  ];
  Timer? _timer;
  double _slideWidth = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 2200), (_) {
      if (!_controller.hasClients || _coupons.length < 2) return;
      _controller.animateTo(
        _controller.offset + _slideWidth,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
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
      height: 116.h,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          _slideWidth = constraints.maxWidth;
          return ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemExtent: _slideWidth,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final imagePath = _coupons[index % _coupons.length];
              return SizedBox(
                width: _slideWidth,
                child: Center(
                  child: SizedBox(
                    width: _slideWidth * 0.88,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 116.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NewArrivalsSection extends StatefulWidget {
  final HomeController homeController;

  const _NewArrivalsSection({required this.homeController});

  @override
  State<_NewArrivalsSection> createState() => _NewArrivalsSectionState();
}

class _NewArrivalsSectionState extends State<_NewArrivalsSection> {
  final Server _server = Server();
  List<ItemData> _items = [];
  String? _loadedSlug;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadIcedTeaItems();
  }

  @override
  void didUpdateWidget(covariant _NewArrivalsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadIcedTeaItems();
  }

  Future<void> _loadIcedTeaItems() async {
    if (_loading || widget.homeController.categoryDataList.isEmpty) return;

    final index = widget.homeController.categoryDataList.indexWhere((category) {
      final value = '${category.name ?? ''} ${category.slug ?? ''}'
          .toLowerCase()
          .replaceAll('-', ' ');
      return value.contains('iced') && value.contains('tea');
    });

    if (index == -1) return;
    final slug = widget.homeController.categoryDataList[index].slug;
    if (slug == null || slug == _loadedSlug) return;

    _loading = true;
    final response = await _server.getRequestWithoutToken(
      endPoint: APIList.categoryWiseItem! + slug,
    );
    if (!mounted) return;

    if (response != null && response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final model = CategoryWiseItemModel.fromJson(jsonResponse);
      setState(() {
        _loadedSlug = slug;
        _items = model.data?.items ?? [];
        _loading = false;
      });
    } else {
      setState(() {
        _loadedSlug = slug;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return const SizedBox.shrink();

    return Container(
      color: const Color(0xfffffbf4),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 0, 8.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: const Color(0xff7B3A2B),
                  size: 17.sp,
                ),
                SizedBox(width: 7.w),
                Text(
                  localizeText('New Arrivals'),
                  style: TextStyle(
                    fontFamily: 'serif',
                    color: const Color(0xff2B1715),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 44.w,
                  height: 1.5.h,
                  color: AppColor.primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 116.h,
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _NewArrivalItem(item: _items[index], index: index);
              },
            ),
          ),
          SizedBox(height: 10.h),
          // Padding(
          //   padding: EdgeInsets.only(right: 16.w),
          //   child: const _NewArrivalFeatureStrip(),
          // ),
        ],
      ),
    );
  }
}

class _NewArrivalItem extends StatelessWidget {
  final ItemData item;
  final int index;

  const _NewArrivalItem({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final price = item.offer != null && item.offer!.isNotEmpty
        ? item.offer!.first.currencyPrice ?? item.currencyPrice ?? ''
        : item.currencyPrice ?? '';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.find<HomeController>().getItemDetails(itemID: item.id!);
        if (!context.mounted) return;
        Get.to(
          () => PremiumItemView(
            itemDetails: Get.find<HomeController>().itemDetailsData.value,
            indexNumber: index,
          ),
          transition: Transition.upToDown,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: SizedBox(
          width: 78.w,
          child: Column(
            children: [
              Container(
                width: 68.w,
                height: 68.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff6D342F).withValues(alpha: 0.07),
                      blurRadius: 12.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: item.cover ?? '',
                    fit: BoxFit.cover,
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
              ),
              SizedBox(height: 8.h),
              Text(
                localizeText(item.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'serif',
                  color: const Color(0xff2B1715),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                price,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'serif',
                  color: const Color(0xff7B173F),
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _NewArrivalFeatureStrip extends StatelessWidget {
  const _NewArrivalFeatureStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.h,
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xffF7EBDD),
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff6D342F).withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        children: [
          _FeatureStripItem(
            icon: Icons.eco_outlined,
            title: localizeText('Made with\nReal Fruits'),
            subtitle: localizeText('No artificial flavors'),
          ),
          SizedBox(width: 5.w),
          _FeatureStripItem(
            icon: Icons.workspace_premium_outlined,
            title: localizeText('Premium\nIngredients'),
            subtitle: localizeText('Fresh & high quality'),
          ),
          SizedBox(width: 5.w),
          _FeatureStripItem(
            icon: Icons.favorite_border_rounded,
            title: localizeText('Crafted with\nLove'),
            subtitle: localizeText('For your cravings'),
          ),
        ],
      ),
    );
  }
}

class _FeatureStripItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureStripItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: const Color(0xff9D503B), size: 18.sp),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xff2B1715),
                    fontSize: 8.7.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.04,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xff6F5A52),
                    fontSize: 6.8.sp,
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

class _FruitLoversSection extends StatefulWidget {
  final HomeController homeController;

  const _FruitLoversSection({required this.homeController});

  @override
  State<_FruitLoversSection> createState() => _FruitLoversSectionState();
}

class _FruitLoversSectionState extends State<_FruitLoversSection> {
  final Server _server = Server();
  List<ItemData> _items = [];
  String? _loadedSlug;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadFreshJuices();
  }

  @override
  void didUpdateWidget(covariant _FruitLoversSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadFreshJuices();
  }

  Future<void> _loadFreshJuices() async {
    if (_loading || widget.homeController.categoryDataList.isEmpty) return;

    final index = widget.homeController.categoryDataList.indexWhere((category) {
      final value = '${category.name ?? ''} ${category.slug ?? ''}'
          .toLowerCase()
          .replaceAll('-', ' ');
      return value.contains('fresh') && value.contains('juice');
    });

    if (index == -1) return;
    final slug = widget.homeController.categoryDataList[index].slug;
    if (slug == null || slug == _loadedSlug) return;

    _loading = true;
    final response = await _server.getRequestWithoutToken(
      endPoint: APIList.categoryWiseItem! + slug,
    );
    if (!mounted) return;

    if (response != null && response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final model = CategoryWiseItemModel.fromJson(jsonResponse);
      setState(() {
        _loadedSlug = slug;
        _items = model.data?.items ?? [];
        _loading = false;
      });
    } else {
      setState(() {
        _loadedSlug = slug;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 340.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 0, 18.h),
      decoration: const BoxDecoration(
        color: Color(0xfffffbf4),
        // image: DecorationImage(
        //   image: AssetImage('assets/images/fruitsbg.png'),
        //   fit: BoxFit.cover,
        //   colorFilter: ColorFilter.mode(Color(0x8A2A1024), BlendMode.darken),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizeText('Fresh Juices'),
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
                      width: 60.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _FruitShotCard(item: _items[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FruitShotCard extends StatelessWidget {
  final ItemData item;
  final int index;

  const _FruitShotCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final price = item.offer != null && item.offer!.isNotEmpty
        ? item.offer!.first.currencyPrice ?? item.currencyPrice ?? ''
        : item.currencyPrice ?? '';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.find<HomeController>().getItemDetails(itemID: item.id!);
        if (!context.mounted) return;
        Get.to(
          () => PremiumItemView(
            itemDetails: Get.find<HomeController>().itemDetailsData.value,
            indexNumber: index,
          ),
          transition: Transition.upToDown,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 6.h),
        child: Container(
          width: 136.w,
          decoration: BoxDecoration(
            color: const Color(0xfffffdf9),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xffF5E8DD), width: 1.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff6D342F).withValues(alpha: 0.08),
                blurRadius: 18.r,
                offset: Offset(0, 9.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36.r),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(34.r),
                      ),
                      child: SizedBox(
                        height: 112.h,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: item.cover ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: Container(color: Colors.grey),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.local_drink_rounded,
                            color: AppColor.primaryColor,
                            size: 26.sp,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -2.w,
                      bottom: -13.h,
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryColor,
                          border: Border.all(
                            color: const Color(0xfffffdf9),
                            width: 2.w,
                          ),
                        ),
                        child: Icon(
                          Icons.local_bar_rounded,
                          color: Colors.white,
                          size: 17.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 18.h, 10.w, 9.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizeText(item.name),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: const Color(0xff2B1715),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ItemMetaText(
                        item: item,
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: const Color(0xff8A6A6A),
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        localizeText(item.description),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: const Color(0xff62544F),
                          fontSize: 11.5.sp,
                          height: 1.22,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'serif',
                                color: const Color(0xff7B173F),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => addItemToCart(item),
                            borderRadius: BorderRadius.circular(18.r),
                            child: Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor.withValues(
                                  alpha: 0.12,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                color: AppColor.primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
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
  }
}

class _PopularProductCard extends StatelessWidget {
  final dynamic item;
  final int index;

  const _PopularProductCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final price = item.offer != null && item.offer!.isNotEmpty
        ? item.offer!.first.currencyPrice ?? item.currencyPrice ?? ''
        : item.currencyPrice ?? '';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await Get.find<HomeController>().getItemDetails(itemID: item.id!);
        if (!context.mounted) return;
        Get.to(
          () => PremiumItemView(
            itemDetails: Get.find<HomeController>().itemDetailsData.value,
            indexNumber: index,
          ),
          transition: Transition.upToDown,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 6.h),
        child: Container(
          width: 136.w,
          decoration: BoxDecoration(
            color: const Color(0xfffffdf9),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xffF5E8DD), width: 1.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff6D342F).withValues(alpha: 0.08),
                blurRadius: 18.r,
                offset: Offset(0, 9.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36.r),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(34.r),
                      ),
                      child: SizedBox(
                        height: 112.h,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: item.cover ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: Container(color: Colors.grey),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.local_drink_rounded,
                            color: AppColor.primaryColor,
                            size: 26.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizeText(item.name),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: const Color(0xff2B1715),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ItemMetaText(
                        item: item,
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: const Color(0xff8A6A6A),
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        localizeText(item.description),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: const Color(0xff62544F),
                          fontSize: 11.5.sp,
                          height: 1.22,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'serif',
                                color: const Color(0xff7B173F),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => addItemToCart(item),
                            borderRadius: BorderRadius.circular(18.r),
                            child: Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor.withValues(
                                  alpha: 0.12,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                color: AppColor.primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
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
  }
}
