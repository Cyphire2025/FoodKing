// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, deprecated_member_use

import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking/app/modules/order/views/order_details.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../../widget/custom_toast.dart';
import '../../../../widget/loader.dart';
import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/order_details_model.dart';
import '../../address/widget/addAddress/add_pick_location_view.dart';
import '../../address/widget/editAddress/edit_pick_location_view.dart';
import '../../profile/widget/profile_address_view.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/widgets/cart_instruction_widget.dart';
import '../../cart/widgets/cart_variation_widget.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../address/controllers/address_controller.dart';
import '../../order/controllers/order_controller.dart';
import '../../payment/views/payment_view.dart';
import '../../profile/widget/location_permission_dialouge.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/checkout_controller.dart';
import '../controllers/coupon_controller.dart';
import '../controllers/order_controller.dart';
import 'package:lottie/lottie.dart' as lottie;
import '../widget/apply_offer_card_widget.dart';
import '../widget/order_confirm_dialog_button.dart';
import '../widget/time_slot_widget.dart';

class CheckoutView extends StatefulWidget {
  final int? orderId;
  CheckoutView({super.key, this.orderId});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  GoogleMapController? _mapController;

  SplashController connect = Get.put(SplashController());

  Set<Marker> _markers = HashSet<Marker>();

  bool maploading = true;

  double branchLat = 0.0;
  double branchLong = 0.0;
  double addressLat = 0.0;
  double addressLon = 0.0;

  bool isActive = true;
  String selectedDate = '';
  int isAdvanceOrder = 10;

  @override
  void initState() {
    super.initState();
    HomeController homeController = Get.put(HomeController());
    AddressController addressController = Get.put(AddressController());
    CartController cartController = Get.put(CartController());
    CheckoutController checkoutController = Get.put(CheckoutController());
    SplashController splashController = Get.put(SplashController());
    addressController.getAddressList();
    connect.getConfiguration().then((_) {
      checkoutController.setDefaultPaymentMethod(
        connect.configData.paymentGateways,
      );
    });

    if (addressController.addressDataList.isNotEmpty) {
      addressLat = double.parse(
        addressController.addressDataList[0].latitude.toString(),
      );
      addressLon = double.parse(
        addressController.addressDataList[0].longitude.toString(),
      );
    }

    if (homeController.branchDataList.isNotEmpty) {
      branchLat = double.parse(
        homeController
            .branchDataList[homeController.selectedBranchIndex]
            .latitude
            .toString(),
      );
      branchLong = double.parse(
        homeController
            .branchDataList[homeController.selectedBranchIndex]
            .longitude
            .toString(),
      );
    }

    cartController.calculateDistance(
      addressLat,
      addressLon,
      branchLat,
      branchLong,
    );
    if (checkoutController.todayDataList.isNotEmpty) {
      selectedDate = checkoutController.todayDataList[0].time!;
      isAdvanceOrder = 10;
    }

    if (splashController.configData.orderSetupDelivery == 10 &&
        splashController.configData.orderSetupTakeaway == 5) {
      cartController.orderTypeIndex = 1;
    }
    if (splashController.configData.orderSetupDelivery == 10 &&
        splashController.configData.orderSetupTakeaway == 10) {
      cartController.orderTypeIndex = 10;
    }
    addressController.selectedAddress = null;

    initialDeliveryCharge(cartController);
  }

  void initialDeliveryCharge(CartController cartController) {
    cartController.deliveryCharge = 0.0;
    cartController.calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    AddressController addressController = Get.put(AddressController());
    HomeController homeController = Get.put(HomeController());
    SplashController splashController = Get.put(SplashController());
    CheckoutController checkoutController = Get.put(CheckoutController());

    return GetBuilder<PlaceOrderController>(
      builder: (placeOrderController) => Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColor.primaryBackgroundColor,
            appBar: AppBar(
              titleSpacing: -4,
              title: Text(
                'CHECKOUT'.tr,
                style: fontBoldWithColorBlack.copyWith(fontSize: 20.sp),
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: AppColor.primaryBackgroundColor,
              leading: IconButton(
                icon: SvgPicture.asset(
                  Images.back,
                  colorFilter: ColorFilter.mode(
                    AppColor.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: Get.height,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        homeController.branchDataList.length != 1 &&
                                cartController.orderTypeIndex == 1
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "SELECT_BRUNCH".tr,
                                          style: fontMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                      right: 16.w,
                                    ),
                                    child: SizedBox(
                                      height: 50.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ListView.builder(
                                                  primary: false,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount: homeController
                                                      .branchDataList
                                                      .length,
                                                  itemBuilder: (BuildContext context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        homeController
                                                                .selectedBranch =
                                                            homeController
                                                                .branchDataList[index]
                                                                .name;
                                                        homeController
                                                                .selectedbranchId =
                                                            homeController
                                                                .branchDataList[index]
                                                                .id!;
                                                        homeController
                                                                .selectedBranchIndex =
                                                            index;

                                                        branchLat = double.parse(
                                                          homeController
                                                              .branchDataList[index]
                                                              .latitude
                                                              .toString(),
                                                        );

                                                        branchLong = double.parse(
                                                          homeController
                                                              .branchDataList[index]
                                                              .longitude
                                                              .toString(),
                                                        );

                                                        Get.find<
                                                              CartController
                                                            >()
                                                            .calculateDistance(
                                                              addressLat,
                                                              addressLon,
                                                              branchLat,
                                                              branchLong,
                                                            );
                                                        _setMarkers();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left: 16.w,
                                                            ),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8.r,
                                                                ),
                                                            color:
                                                                index ==
                                                                    homeController
                                                                        .selectedBranchIndex
                                                                ? AppColor
                                                                      .primaryColor
                                                                : Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: AppColor
                                                                    .itembg,
                                                                offset:
                                                                    const Offset(
                                                                      0.0,
                                                                      4.0,
                                                                    ),
                                                                blurRadius:
                                                                    5.0.r,
                                                                spreadRadius:
                                                                    0.5.r,
                                                              ),
                                                              const BoxShadow(
                                                                color: AppColor
                                                                    .itembg,
                                                                offset: Offset(
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    0.1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  8.0.r,
                                                                ),
                                                            child: SizedBox(
                                                              height: 32.h,
                                                              child: Center(
                                                                child: Text(
                                                                  homeController
                                                                      .branchDataList[index]
                                                                      .name!,
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        index ==
                                                                            homeController.selectedBranchIndex
                                                                        ? FontWeight
                                                                              .w500
                                                                        : FontWeight
                                                                              .w400,
                                                                    color:
                                                                        index ==
                                                                            homeController.selectedBranchIndex
                                                                        ? Colors
                                                                              .white
                                                                        : Colors
                                                                              .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        homeController.branchDataList.length != 1 &&
                                cartController.orderTypeIndex == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 16.w,
                                      top: 16.h,
                                      bottom: 16.h,
                                    ),
                                    child: SizedBox(
                                      height: 140.h,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            GoogleMap(
                                              initialCameraPosition: CameraPosition(
                                                target: LatLng(
                                                  double.parse(
                                                    homeController
                                                        .branchDataList[homeController
                                                            .selectedBranchIndex]
                                                        .latitude!,
                                                  ),
                                                  double.parse(
                                                    homeController
                                                        .branchDataList[homeController
                                                            .selectedBranchIndex]
                                                        .longitude!,
                                                  ),
                                                ),
                                                zoom: 17,
                                              ),
                                              minMaxZoomPreference:
                                                  const MinMaxZoomPreference(
                                                    0,
                                                    16,
                                                  ),
                                              compassEnabled: false,
                                              indoorViewEnabled: true,
                                              mapToolbarEnabled: false,
                                              zoomControlsEnabled: true,
                                              onMapCreated:
                                                  (
                                                    GoogleMapController
                                                    controller,
                                                  ) async {
                                                    await Geolocator.requestPermission();
                                                    _mapController = controller;
                                                    maploading = false;
                                                    _setMarkers();
                                                  },
                                            ),
                                            Center(
                                              child: Image.asset(
                                                Images.markerBranch,
                                                height: 50.h,
                                                width: 50.w,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (cartController.orderTypeIndex == 1)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                        bottom: 30.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            Images.locationIcon,
                                            fit: BoxFit.cover,
                                            height: 18.h,
                                            width: 18.h,
                                            color: AppColor.primaryColor,
                                          ),
                                          SizedBox(width: 4.w),
                                          SizedBox(
                                            width: Get.width - 55.w,
                                            child: Text(
                                              homeController
                                                  .branchDataList[homeController
                                                      .selectedBranchIndex]
                                                  .address!,
                                              style: fontProfileLite,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        if (cartController.orderTypeIndex == 0)
                          GetBuilder<AddressController>(
                            builder: (addressController) => Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom: 18.h,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 32.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "DELIVERY_ADDRESS".tr,
                                          style: fontMedium.copyWith(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            addressController
                                                    .addressDataList
                                                    .isNotEmpty
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                      left: 12.r,
                                                      right: 12.r,
                                                      top: 8.r,
                                                      bottom: 8.r,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16.r,
                                                          ),
                                                      color: AppColor
                                                          .primaryColor
                                                          .withOpacity(0.08),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (addressController.selectedAddress == null) {
                                                          Get.to(() => const ProfileAddressView());
                                                        } else {
                                                          Get.to(
                                                            () => EditPickLocationView(
                                                              addressData:
                                                                  addressController
                                                                      .addressDataList[addressController
                                                                      .selectedAddress!],
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            Images.iconEdit,
                                                            fit: BoxFit.cover,
                                                            height: 13.h,
                                                            width: 13.h,
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                  AppColor
                                                                      .primaryColor,
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                          ),
                                                          SizedBox(width: 3.w),
                                                          Text(
                                                            "EDIT".tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall
                                                                  .sp,
                                                              color: AppColor
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            SizedBox(width: 12.w),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                left: 12.r,
                                                right: 12.r,
                                                top: 8.r,
                                                bottom: 8.r,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18.r),
                                                color: AppColor.primaryColor
                                                    .withAlpha(24),
                                              ),
                                              child: InkWell(
                                                onTap: () => _checkPermission(
                                                  () async {
                                                    Get.to(
                                                      () =>
                                                          AddPickLocationView(),
                                                    );
                                                  },
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      Images.iconAdd,
                                                      fit: BoxFit.cover,
                                                      height: 13.h,
                                                      width: 13.h,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                            AppColor
                                                                .primaryColor,
                                                            BlendMode.srcIn,
                                                          ),
                                                    ),
                                                    SizedBox(width: 3.w),
                                                    Text(
                                                      "ADD".tr,
                                                      style:
                                                          fontRegularBoldwithColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  addressController.addressDataList.isNotEmpty
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          height: 100.h,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: addressController
                                                .addressDataList
                                                .length,
                                            itemBuilder: (BuildContext context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: InkWell(
                                                  onTap: () async {
                                                    addressLat = double.parse(
                                                      addressController
                                                          .addressDataList[index]
                                                          .latitude
                                                          .toString(),
                                                    );
                                                    addressLon = double.parse(
                                                      addressController
                                                          .addressDataList[index]
                                                          .longitude
                                                          .toString(),
                                                    );

                                                    bool branchStatus =
                                                        await addressController
                                                            .checkBranchByLatLong(
                                                              addressLat:
                                                                  addressLat,
                                                              addressLong:
                                                                  addressLon,
                                                            );

                                                    if (branchStatus == true) {
                                                      addressController
                                                          .setAddress(index);

                                                      Get.find<CartController>()
                                                          .calculateDistance(
                                                            addressLat,
                                                            addressLon,
                                                            branchLat,
                                                            branchLong,
                                                          );

                                                      cartController
                                                          .calculateTotal();

                                                      setState(() {});
                                                    } else {
                                                      addressController
                                                          .removeAddress(null);

                                                      cartController
                                                              .deliveryCharge =
                                                          0.0;

                                                      cartController
                                                          .calculateTotal();

                                                      setState(() {});
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 80.h,
                                                    width: 158.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8.r,
                                                          ),
                                                      color:
                                                          addressController
                                                                  .selectedAddress ==
                                                              index
                                                          ? AppColor
                                                                .primaryColor
                                                                .withOpacity(
                                                                  0.08,
                                                                )
                                                          : AppColor.itembg,
                                                      border:
                                                          addressController
                                                                  .selectedAddress ==
                                                              index
                                                          ? Border.all(
                                                              color: AppColor
                                                                  .primaryColor,
                                                            )
                                                          : Border.all(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 130.w,
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                      top: 8.w,
                                                                      left: 8.w,
                                                                      right:
                                                                          8.h,
                                                                    ),
                                                                    child:
                                                                        addressController.addressDataList[index].label.toString() ==
                                                                            "Home"
                                                                        ? SvgPicture.asset(
                                                                            Images.homeIcon,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                15.h,
                                                                            width:
                                                                                15.w,
                                                                          )
                                                                        : addressController.addressDataList[index].label.toString() ==
                                                                              "Office"
                                                                        ? SvgPicture.asset(
                                                                            Images.work,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : SvgPicture.asset(
                                                                            Images.other,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.only(
                                                                          top: 8
                                                                              .h,
                                                                        ),
                                                                    child: ConstrainedBox(
                                                                      constraints: BoxConstraints(
                                                                        maxWidth:
                                                                            94.w,
                                                                      ),
                                                                      child: Text(
                                                                        addressController
                                                                            .addressDataList[index]
                                                                            .label
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              Dimensions.fontSizeDefault,
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    top: 2,
                                                                    right: 2,
                                                                  ),
                                                              child: SizedBox(
                                                                width: 20.w,
                                                                height: 20.h,
                                                                child:
                                                                    addressController
                                                                            .selectedAddress ==
                                                                        index
                                                                    ? SvgPicture.asset(
                                                                        Images
                                                                            .IconVariationSelected,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        colorFilter: ColorFilter.mode(
                                                                          AppColor
                                                                              .primaryColor,
                                                                          BlendMode
                                                                              .srcIn,
                                                                        ),
                                                                      )
                                                                    : SvgPicture.asset(
                                                                        Images
                                                                            .IconVariation,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                      top: 8.h,
                                                                      left: 8.w,
                                                                      right:
                                                                          8.w,
                                                                    ),
                                                                    child: SvgPicture.asset(
                                                                      Images
                                                                          .locationIcon,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Padding(
                                                                      padding:
                                                                          EdgeInsets.only(
                                                                            top:
                                                                                8.h,
                                                                          ),
                                                                      child: Text(
                                                                        addressController
                                                                            .addressDataList[index]
                                                                            .address
                                                                            .toString(),
                                                                        style:
                                                                            fontRegular,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        addressController
                                                                    .addressDataList[index]
                                                                    .apartment !=
                                                                null
                                                            ? Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsets.only(
                                                                            left:
                                                                                28,
                                                                          ),
                                                                      child: Row(
                                                                        children: [
                                                                          Flexible(
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(
                                                                                top: 8.h,
                                                                              ),
                                                                              child: Text(
                                                                                addressController.addressDataList[index].apartment.toString(),
                                                                                style: fontRegular,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Get.to(() => AddPickLocationView());
                                          },
                                          child: Container(
                                            height: 70.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              color: Colors.white,
                                              border: Border.all(
                                                color: AppColor.primaryColor
                                                    .withOpacity(0.75),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColor.primaryColor
                                                      .withOpacity(0.06),
                                                  blurRadius: 18.r,
                                                  offset: Offset(0, 8.h),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                "PLEASE_ADD_DELIVERY_ADDRESS"
                                                    .tr,
                                                style: fontRegularBold.copyWith(
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        if (cartController.orderTypeIndex == 0)
                          GetBuilder<CheckoutController>(
                            builder: (checkoutController) => Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                bottom: 20.h,
                                right: 16.w,
                              ),
                              child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: Text(
                                        "PREFERENCE_TIME_TO_DELIVERY".tr,
                                        style: fontMedium.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 44.h,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          return TimeSlotWidget(
                                            title: index == 0
                                                ? 'TODAY'.tr
                                                : 'TOMORROW'.tr,
                                            isSelected:
                                                checkoutController
                                                    .selectDateSlot ==
                                                index,
                                            onTap: () {
                                              checkoutController.updateDateSlot(
                                                index,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                if (checkoutController.selectDateSlot == 0)
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 44.h,
                                    child:
                                        checkoutController
                                            .todayDataList
                                            .isNotEmpty
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: checkoutController
                                                .todayDataList
                                                .length,
                                            itemBuilder: (context, index) {
                                              return TimeSlotWidget(
                                                title:
                                                    (index == 0 &&
                                                        checkoutController
                                                                .selectDateSlot ==
                                                            0
                                                    ? 'NOW'.tr
                                                    : checkoutController
                                                          .todayDataList[index]
                                                          .label!),
                                                isSelected:
                                                    checkoutController
                                                        .selectTimeSlot ==
                                                    index,
                                                onTap: () {
                                                  selectedDate =
                                                      checkoutController
                                                          .todayDataList[index]
                                                          .time!;
                                                  isAdvanceOrder = 10;
                                                  checkoutController
                                                      .updateTimeSlot(index);
                                                },
                                              );
                                            },
                                          )
                                        : Container(
                                            height: 60.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: AppColor.primaryColor
                                                  .withOpacity(0.08),
                                              border: Border.all(
                                                color: AppColor.primaryColor,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "CURRENTLY_NOT_ACCEPTING_ANY_ORDER"
                                                    .tr,
                                                style: fontRegularBold,
                                              ),
                                            ),
                                          ),
                                  ),
                                if (checkoutController.selectDateSlot == 1)
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 44.h,
                                    child:
                                        checkoutController
                                            .tomorrowDataList
                                            .isNotEmpty
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: checkoutController
                                                .tomorrowDataList
                                                .length,
                                            itemBuilder: (context, index) {
                                              return TimeSlotWidget(
                                                title: checkoutController
                                                    .tomorrowDataList[index]
                                                    .label!,
                                                isSelected:
                                                    checkoutController
                                                        .selectTimeSlot ==
                                                    index,
                                                onTap: () {
                                                  selectedDate =
                                                      checkoutController
                                                          .tomorrowDataList[index]
                                                          .time!;
                                                  isAdvanceOrder = 5;
                                                  checkoutController
                                                      .updateTimeSlot(index);
                                                },
                                              );
                                            },
                                          )
                                        : Container(
                                            height: 60.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: AppColor.primaryColor
                                                  .withOpacity(0.08),
                                              border: Border.all(
                                                color: AppColor.primaryColor,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "NOT_ACCEPTING_ANY_ORDER".tr,
                                                style: fontRegularBold,
                                              ),
                                            ),
                                          ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 6.h,
                            bottom: 12.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "CART_SUMMARY".tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: 14.h,
                          ),
                          child: _orderTypeSelector(
                            splashController: splashController,
                            cartController: cartController,
                            addressController: addressController,
                          ),
                        ),
                        cartSummarySection(context),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.r),
                        topRight: Radius.circular(22.r),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primaryColor.withOpacity(0.08),
                          offset: Offset(0, -8.h),
                          blurRadius: 22.r,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16,
                      ),
                      child: GetBuilder<PlaceOrderController>(
                        builder: (placeOrderController) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  if (splashController
                                              .configData
                                              .orderSetupDelivery ==
                                          10 &&
                                      splashController
                                              .configData
                                              .orderSetupTakeaway ==
                                          10) {
                                    customTast(
                                      "CURRENTLY_NOT_ACCEPTING_ANY_ORDER".tr,
                                      AppColor.error,
                                    );
                                  } else if (addressController
                                          .addressDataList
                                          .isEmpty &&
                                      cartController.orderTypeIndex == 0) {
                                    customTast(
                                      "PLEASE_ADD_DELIVERY_ADDRESS".tr,
                                      AppColor.error,
                                    );
                                  } else if (addressController
                                              .selectedAddress ==
                                          null &&
                                      cartController.orderTypeIndex == 0) {
                                    customTast(
                                      "PLEASE_CHOOSE_AN_ADDRESS".tr,
                                      AppColor.error,
                                    );
                                  } else if (checkoutController
                                      .selectedPaymentMethod
                                      .isEmpty) {
                                    customTast(
                                      "Please select a payment method.",
                                      AppColor.error,
                                    );
                                  } else {
                                    placeOrderController.placeOrderPost(
                                      PlaceOrderBody(
                                        branchId:
                                            cartController.orderTypeIndex == 0
                                            ? addressController.branchData.id
                                            : homeController.selectedbranchId,
                                        orderType:
                                            cartController.orderTypeIndex == 0
                                            ? 5
                                            : 10,
                                        isAdvanceOrder: isAdvanceOrder,
                                        deliveryCharge:
                                            cartController.deliveryCharge,
                                        distance: cartController.kilometer,
                                        addressId:
                                            cartController.orderTypeIndex == 0
                                            ? addressController
                                                  .addressDataList[addressController
                                                      .selectedAddress!]
                                                  .id
                                            : null,
                                        deliveryTime: selectedDate,
                                        subtotal: cartController.totalCartValue,
                                        total: cartController.total,
                                        couponId: cartController.couponId,
                                        discount: cartController.couponDiscount,
                                        checkoutPaymentMethod:
                                            checkoutController
                                                .selectedPaymentMethod,
                                        source: 10,
                                        items: cartController.cart,
                                      ),
                                      callback,
                                    );
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColor.primaryColor,
                                minimumSize: Size(Get.width - 32.w, 56.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                              ),
                              child: Text(
                                "PLACE_ORDER".tr,
                                style: fontMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
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
          placeOrderController.loader
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: const Center(child: LoaderCircle()),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> _setMarkers() async {
    // ignore: unused_local_variable
    BitmapDescriptor _bitmapDescriptor;
    // ignore: unused_local_variable
    BitmapDescriptor _bitmapDescriptorUnSelect;
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 50)),
      Images.marker,
    ).then((_marker) {
      _bitmapDescriptor = _marker;
    });
    await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      Images.marker,
    ).then((_marker) {
      _bitmapDescriptorUnSelect = _marker;
    });
    _markers = HashSet<Marker>();
    for (
      int index = 0;
      index < Get.find<HomeController>().branchDataList.length;
      index++
    ) {
      _markers.add(
        Marker(
          markerId: MarkerId('branch_$index'),
          position: LatLng(
            double.parse(
              Get.find<HomeController>().branchDataList[index].latitude!,
            ),
            double.parse(
              Get.find<HomeController>().branchDataList[index].longitude!,
            ),
          ),
        ),
      );
    }
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            double.parse(
              Get.find<HomeController>()
                  .branchDataList[Get.find<HomeController>()
                      .selectedBranchIndex]
                  .latitude!,
            ),
            double.parse(
              Get.find<HomeController>()
                  .branchDataList[Get.find<HomeController>()
                      .selectedBranchIndex]
                  .longitude!,
            ),
          ),
          zoom: 16,
        ),
      ),
    );
    setState(() {});
  }

  void callback(bool isSuccess, OrderDetailsData orderDetailsData) {
    if (isSuccess) {
      final selectedPaymentMethod =
          Get.find<CheckoutController>().selectedPaymentMethod;
      if (selectedPaymentMethod == 'cash-on-delivery') {
        Get.find<CartController>().cart.clear();
        Get.find<CartController>().removeCoupon();
        Get.offAll(() => const DashboardView());
        confirmAlert(context, orderDetailsData).show();
      } else if (Get.find<CheckoutController>().isPaymentMethodAllowed(
        selectedPaymentMethod,
      )) {
        Get.offAll(
          () => PaymentView(
            orderId: orderDetailsData.id,
            order: orderDetailsData,
            fromHome: true,
          ),
        );
      }
    }
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      customSnackbar("ERROR".tr, "LOCATION_SERVICE_DENIED".tr, AppColor.error);
    } else if (permission == LocationPermission.deniedForever) {
      permissionAlert(context).show();
    } else {
      onTap();
    }
  }

  Widget _orderTypeSelector({
    required SplashController splashController,
    required CartController cartController,
    required AddressController addressController,
  }) {
    final deliveryEnabled = splashController.configData.orderSetupDelivery == 5;
    final takeawayEnabled = splashController.configData.orderSetupTakeaway == 5;

    if (!deliveryEnabled && !takeawayEnabled) {
      return const SizedBox.shrink();
    }

    final options = <Map<String, dynamic>>[];
    if (deliveryEnabled) {
      options.add({'label': 'DELIVERY'.tr, 'index': 0});
    }
    if (takeawayEnabled) {
      options.add({'label': 'TAKEAWAY'.tr, 'index': 1});
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.12)),
      ),
      child: Row(
        children: options.map((option) {
          final index = option['index'] as int;
          final selected = cartController.orderTypeIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  cartController.orderTypeIndex = index;
                  cartController.distanceWiseDeliveryCharge();
                  cartController.calculateTotal();
                  if (index == 0 && addressController.selectedAddress == null) {
                    cartController.deliveryCharge = 0.0;
                    cartController.calculateTotal();
                  }
                  if (index == 1) {
                    addressController.removeAddress(null);
                  }
                });
              },
              borderRadius: BorderRadius.circular(15.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppColor.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.18),
                            blurRadius: 12.r,
                            offset: Offset(0, 6.h),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  option['label'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Alert confirmAlert(BuildContext context, OrderDetailsData orderDetaislData) {
    return Alert(
      buttons: [],
      closeIcon: InkWell(
        onTap: () {
          Get.back();
        },
        child: Image.asset(
          Images.closeCircle,
          fit: BoxFit.cover,
          height: 20.h,
          width: 20.w,
        ),
      ),
      style: AlertStyle(
        animationType: AnimationType.grow,
        descStyle: fontMedium,
        descTextAlign: TextAlign.center,
        animationDuration: const Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        alertAlignment: Alignment.center,
      ),
      context: context,
      content: Column(
        children: [
          Text("THANK_YOU_FOR_YOUR_ORDER".tr, style: fontMedium),
          lottie.Lottie.asset(
            Images.animationConfirmed,
            height: 120.h,
            width: 120.w,
          ),
          const SizedBox(height: 12),
          Text("ORDER_CONFIRMED".tr, style: fontBoldWithColor),
          const SizedBox(height: 12),
          if (orderDetaislData.orderType.toString() == "5")
            connect.configData.siteOnlinePaymentGateway.toString() == '5'
                ? Text("CONFIRMED_COD_1".tr, style: fontRegular)
                : Text("CONFIRMED_COD".tr, style: fontRegular),
          if (orderDetaislData.orderType.toString() == "10")
            Text("CONFIRMED_PNP".tr, style: fontRegular),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderDetaislData.branch!.name!, style: fontMediumPro),
                  SizedBox(height: 6.h),
                  SizedBox(height: 6.h),
                  orderDetaislData.orderType.toString() == "5"
                      ? Text("DELIVERY".tr, style: fontRegular)
                      : Text("TAKEAWAY".tr, style: fontRegular),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final call = Uri.parse(
                        'tel:${Get.find<SplashController>().countryInfoData.callingCode! + orderDetaislData.branch!.phone.toString()}',
                      );
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: SvgPicture.asset(
                          Images.call,
                          colorFilter: ColorFilter.mode(
                            AppColor.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          connect.configData.siteOnlinePaymentGateway.toString() == '5'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderConfirmDialogButton(
                      height: 48.h,
                      width: 110.w,
                      text: "GO_TO_ORDER_DETAILS".tr,
                      textSize: 14.sp,
                      textColor: AppColor.primaryColor,
                      borderColor: AppColor.primaryColor,
                      buttonColor: Colors.white,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      onTap: () async {
                        Get.back();
                        final result = await Get.find<OrderController>()
                            .getOrderDetails(orderDetaislData.id!);

                        if (result != null) {
                          Get.to(
                            () => OrderDetailsView(
                              orderId: Get.find<OrderController>().orderId,
                            ),
                          );
                        }
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.find<OrderController>().getOrderDetails(
                          orderDetaislData.id!,
                        );
                        Get.to(
                          () => PaymentView(
                            orderId: orderDetaislData.id,
                            fromHome: true,
                          ),
                        );
                      },
                      child: Container(
                        height: 48.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: AppColor.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "PAY_NOW".tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : DialogButton(
                  child: FittedBox(
                    child: Text(
                      "GO_TO_ORDER_DETAILS".tr,
                      style: fontMediumProWhite,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  color: AppColor.primaryColor,
                  onPressed: () {
                    Get.back();
                    Get.find<OrderController>().getOrderDetails(
                      orderDetaislData.id!,
                    );
                  },
                  radius: BorderRadius.circular(24.0.r),
                ),
        ],
      ),
    );
  }
}

class _PaymentFallbackIcon extends StatelessWidget {
  final String slug;

  const _PaymentFallbackIcon({required this.slug});

  @override
  Widget build(BuildContext context) {
    final isCod = slug == 'cash-on-delivery';
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        isCod ? Icons.payments_outlined : Icons.credit_card,
        color: Colors.white,
        size: 17.sp,
      ),
    );
  }
}

Widget cartSummarySection(BuildContext context) {
  SplashController splashController = Get.put(SplashController());
  return GetBuilder<CartController>(
    builder: (cartController) => Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 110.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.06),
              offset: Offset(0, 12.h),
              blurRadius: 24.r,
              spreadRadius: 0.5.r,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 18.h, 12.w, 6.h),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: cartController.cart.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 76.w,
                                  height: 76.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(14.r),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          cartController.cart[index].itemImage!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            child: Container(
                                              height: 76.h,
                                              width: 76.w,
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
                                Positioned(
                                  left: 0,
                                  top: 24.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      20.r,
                                    ), //or 15.0
                                    child: Container(
                                      height: 24.h,
                                      width: 24.w,
                                      color: AppColor.fontColor,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          cartController.cart[index].quantity!
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartController.cart[index].itemName!,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.fontColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  cartController.cart[index].itemVariations !=
                                          null
                                      ? SizedBox(
                                          height: 18.h,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: cartController
                                                .cart[index]
                                                .itemVariations!
                                                .length,
                                            itemBuilder: (BuildContext context, i) {
                                              return Text(
                                                index ==
                                                        cartController
                                                                .cart[index]
                                                                .itemVariations!
                                                                .length -
                                                            1
                                                    ? "${cartController.cart[index].itemVariations![i].variationName} : ${cartController.cart[index].itemVariations![i].name}."
                                                    : "${cartController.cart[index].itemVariations![i].variationName} : ${cartController.cart[index].itemVariations![i].name}, ",
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.gray,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(height: 4.h),
                                  Get.find<SplashController>()
                                              .configData
                                              .siteCurrencyPosition ==
                                          5
                                      ? Row(
                                          children: [
                                            Text(
                                              Get.find<SplashController>()
                                                  .configData
                                                  .siteDefaultCurrencySymbol!,
                                              style: fontMediumProWithCurrency,
                                            ),
                                            Text(
                                              cartController
                                                  .cart[index]
                                                  .totalPrice!
                                                  .toStringAsFixed(2),
                                              style: fontMediumPro.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              cartController
                                                  .cart[index]
                                                  .totalPrice!
                                                  .toString(),
                                              style: fontMediumPro.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              Get.find<SplashController>()
                                                  .configData
                                                  .siteDefaultCurrencySymbol!,
                                              style: fontMediumProWithCurrency,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: cartVariationSection(index),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: cartInstructionSection(index),
                      ),
                      Divider(color: AppColor.dividerColor, height: 20.h),
                    ],
                  );
                },
              ),
            ),
            ApplyOfferCard(splashController: splashController),
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 12.w,
                top: 16.h,
                bottom: 12.h,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColor.primaryBackgroundColor.withOpacity(0.35),
                  border: Border.all(color: AppColor.dividerColor),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        children: [
                          Text('SUBTOTAL'.tr, style: fontRegularLite),
                          const Spacer(),
                          Row(
                            children: [
                              if (splashController
                                      .configData
                                      .siteCurrencyPosition ==
                                  5)
                                Text(
                                  splashController
                                      .configData
                                      .siteDefaultCurrencySymbol!,
                                  style: fontRegularLiteWithCurrency,
                                ),
                              Text(
                                cartController.totalCartValue.toStringAsFixed(
                                  int.parse(
                                    splashController
                                        .configData
                                        .siteDigitAfterDecimalPoint!,
                                  ),
                                ),
                                style: fontRegularLite,
                              ),
                              if (splashController
                                      .configData
                                      .siteCurrencyPosition ==
                                  10)
                                Text(
                                  splashController
                                      .configData
                                      .siteDefaultCurrencySymbol!,
                                  style: fontRegularLiteWithCurrency,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<CouponController>(
                      builder: (couponController) => Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DISCOUNT'.tr, style: fontRegularLite),
                            Row(
                              children: [
                                if (splashController
                                        .configData
                                        .siteCurrencyPosition ==
                                    5)
                                  Text(
                                    splashController
                                        .configData
                                        .siteDefaultCurrencySymbol!,
                                    style: fontRegularLiteWithCurrency,
                                  ),
                                Text(
                                  cartController.couponDiscount.toStringAsFixed(
                                    int.parse(
                                      splashController
                                          .configData
                                          .siteDigitAfterDecimalPoint!,
                                    ),
                                  ),
                                  style: fontRegularLite,
                                ),
                                if (splashController
                                        .configData
                                        .siteCurrencyPosition ==
                                    10)
                                  Text(
                                    splashController
                                        .configData
                                        .siteDefaultCurrencySymbol!,
                                    style: fontRegularLiteWithCurrency,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (cartController.orderTypeIndex == 0 &&
                        cartController.orderTypeIndex != 10 &&
                        cartController.orderTypeIndex != 1 &&
                        Get.find<AddressController>()
                            .addressDataList
                            .isNotEmpty)
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DELIVERY_CHARGE'.tr, style: fontRegularLite),
                            Row(
                              children: [
                                if (splashController
                                        .configData
                                        .siteCurrencyPosition ==
                                    5)
                                  Text(
                                    splashController
                                        .configData
                                        .siteDefaultCurrencySymbol!,
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                Text(
                                  cartController.deliveryCharge.toStringAsFixed(
                                    int.parse(
                                      splashController
                                          .configData
                                          .siteDigitAfterDecimalPoint!,
                                    ),
                                  ),
                                  style: fontRegularBoldGreen.copyWith(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                if (splashController
                                        .configData
                                        .siteCurrencyPosition ==
                                    10)
                                  Text(
                                    splashController
                                        .configData
                                        .siteDefaultCurrencySymbol!,
                                    style: fontRegularLiteWithCurrency,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    Text(
                      '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                      style: TextStyle(color: AppColor.gray.withOpacity(0.2)),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL'.tr, style: fontMediumPro),
                          Row(
                            children: [
                              if (splashController
                                      .configData
                                      .siteCurrencyPosition ==
                                  5)
                                Text(
                                  splashController
                                      .configData
                                      .siteDefaultCurrencySymbol!,
                                  style: fontMediumProWithCurrency,
                                ),
                              Text(
                                cartController.total.toStringAsFixed(
                                  int.parse(
                                    splashController
                                        .configData
                                        .siteDigitAfterDecimalPoint!,
                                  ),
                                ),
                                style: fontMediumPro,
                              ),
                              if (splashController
                                      .configData
                                      .siteCurrencyPosition ==
                                  10)
                                Text(
                                  splashController
                                      .configData
                                      .siteDefaultCurrencySymbol!,
                                  style: fontMediumProWithCurrency,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<CheckoutController>(
                      builder: (checkoutController) {
                        final paymentGateways = checkoutController
                            .availablePaymentGateways(
                              splashController.configData.paymentGateways,
                            );
                        if (paymentGateways.isNotEmpty &&
                            checkoutController.selectedPaymentMethod.isEmpty) {
                          Future.microtask(
                            () => checkoutController.setDefaultPaymentMethod(
                              paymentGateways,
                            ),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(
                            left: 8.w,
                            right: 8.w,
                            top: 10.h,
                            bottom: 12.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'PAYMENT_METHOD'.tr,
                                  style: fontRegularBold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              if (paymentGateways.isEmpty)
                                Text(
                                  'No payment method is enabled.',
                                  style: TextStyle(
                                    color: AppColor.error,
                                    fontSize: 13.sp,
                                    fontFamily: 'Rubik',
                                  ),
                                )
                              else
                                GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: paymentGateways.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10.h,
                                        crossAxisSpacing: 10.w,
                                        childAspectRatio: 2.45,
                                      ),
                                  itemBuilder: (context, index) {
                                    final method = paymentGateways[index];
                                    final slug = method.slug ?? '';
                                    final selected =
                                        checkoutController
                                            .selectedPaymentMethod ==
                                        slug;
                                    return InkWell(
                                      onTap: () {
                                        checkoutController.selectPaymentMethod(
                                          slug,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: selected
                                              ? AppColor.primaryBackgroundColor
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          ),
                                          border: Border.all(
                                            color: selected
                                                ? AppColor.primaryColor
                                                : AppColor.dividerColor,
                                            width: selected ? 1.4.w : 1.w,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.primaryColor
                                                  .withOpacity(
                                                    selected ? 0.08 : 0.03,
                                                  ),
                                              blurRadius: 12.r,
                                              offset: Offset(0, 6.h),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 8.h,
                                        ),
                                        child: Row(
                                          children: [
                                            _PaymentFallbackIcon(slug: slug),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    method.name ?? slug,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColor.fontColor,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Text(
                                                    slug == 'cash-on-delivery'
                                                        ? 'Pay on delivery'
                                                        : 'Pay online',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 11.sp,
                                                      color: AppColor.gray,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        );
                      },
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
