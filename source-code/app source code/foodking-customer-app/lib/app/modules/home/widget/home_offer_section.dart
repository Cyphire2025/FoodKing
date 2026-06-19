// ignore_for_file: sort_child_properties_last

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../offer/controllers/offer_controller.dart';

Widget homeOfferSection() {
  return const _HomeOfferCarousel();
}

class _HomeOfferCarousel extends StatefulWidget {
  const _HomeOfferCarousel();

  @override
  State<_HomeOfferCarousel> createState() => _HomeOfferCarouselState();
}

class _HomeOfferCarouselState extends State<_HomeOfferCarousel> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  double _slideWidth = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 2200), (_) {
      if (!_controller.hasClients) return;
      final offerCount = Get.find<OfferController>().offerDataList.length;
      if (offerCount < 2) return;
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
    return GetBuilder<OfferController>(
      builder: (offerController) => Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: SizedBox(
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
                itemCount: offerController.offerDataList.length < 2
                    ? offerController.offerDataList.length
                    : null,
                itemBuilder: (BuildContext context, index) {
                  final offerIndex =
                      index % offerController.offerDataList.length;
                  return SizedBox(
                    width: _slideWidth,
                    child: Center(
                      child: SizedBox(
                        width: _slideWidth * 0.88,
                        child: InkWell(
                          onTap: () {
                            offerController.getOfferItemList(
                              offerController.offerDataList[offerIndex].slug
                                  .toString(),
                            );
                          },
                          child: Container(
                            height: 116.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Hero(
                                tag: "home-offer-banner-$index",
                                child: CachedNetworkImage(
                                  imageUrl: offerController
                                      .offerDataList[offerIndex]
                                      .image
                                      .toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        child: Container(
                                          height: 116.h,
                                          width: double.infinity,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[400]!,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
