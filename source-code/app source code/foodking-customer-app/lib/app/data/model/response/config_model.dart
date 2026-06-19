// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigData? data;

  ConfigModel({this.data});

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    data: json["data"] == null ? null : ConfigData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class ConfigData {
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final String? companyAddress;
  final String? companyCountryCode;
  final int? siteDefaultBranch;
  final int? siteDefaultLanguage;
  final String? siteAndroidAppLink;
  final String? siteIosAppLink;
  final String? siteCopyright;
  final int? siteCurrencyPosition;
  final String? siteDigitAfterDecimalPoint;
  final String? siteDefaultCurrencySymbol;
  final int? sitePhoneVerification;
  final int? siteLanguageSwitch;
  final int? siteOnlinePaymentGateway;
  final List<PaymentGatewayData> paymentGateways;
  final int? siteGuestLogin;
  final String? themeLogo;
  final String? themeFooterLogo;
  final String? themeFaviconLogo;
  final String? appIntroMediaUrl;
  final String? appIntroMediaType;
  final LatestUpdateData? latestUpdate;
  final List<LatestUpdateData> latestUpdates;
  final String? appPrimaryColor;
  final String? appBannerOneUrl;
  final String? appBannerTwoUrl;
  final String? otpType;
  final String? otpDigitLimit;
  final String? otpExpireTime;
  final String? socialMediaFacebook;
  final String? socialMediaInstagram;
  final String? socialMediaTwitter;
  final String? socialMediaYoutube;
  final String? orderSetupFoodPreparationTime;
  final int? orderSetupTakeaway;
  final int? orderSetupDelivery;
  final String? orderSetupFreeDeliveryKilometer;
  final String? orderSetupBasicDeliveryCharge;
  final String? orderSetupChargePerKilo;
  final int? cookiesDetailsPageId;
  final String? cookiesSummary;
  final String? notificationFcmApiKey;
  final String? notificationFcmAuthDomain;
  final String? notificationFcmProjectId;
  final String? notificationFcmStorageBucket;
  final String? notificationFcmMessagingSenderId;
  final String? notificationFcmAppId;
  final String? notificationFcmPublicVapidKey;
  final String? notificationFcmMeasurementId;
  final String? notificationAudio;
  final String? imageCart;
  final String? imageConfirm;
  final String? imageVag;
  final String? imageNonVag;
  final String? imageAppStore;
  final String? imagePlayStore;
  final String? imageOrderTrack;
  final String? imageOrderPlaced;
  final String? imageOrderComplete;
  final String? imageOrderDelivered;
  final String? imageOrderPreparing;
  final String? imageOrderOutForDelivery;
  final String? imageOrderRejected;
  final String? imageOrderCanceled;
  final String? imageOrderReturned;
  final String? imageFourZeroFourPage;
  final String? imageFourZeroThreePage;
  final bool? demo;

  ConfigData({
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.companyAddress,
    this.companyCountryCode,
    this.siteDefaultBranch,
    this.siteDefaultLanguage,
    this.siteAndroidAppLink,
    this.siteIosAppLink,
    this.siteCopyright,
    this.siteCurrencyPosition,
    this.siteDigitAfterDecimalPoint,
    this.siteDefaultCurrencySymbol,
    this.sitePhoneVerification,
    this.siteLanguageSwitch,
    this.siteOnlinePaymentGateway,
    this.paymentGateways = const [],
    this.siteGuestLogin,
    this.themeLogo,
    this.themeFooterLogo,
    this.themeFaviconLogo,
    this.appIntroMediaUrl,
    this.appIntroMediaType,
    this.latestUpdate,
    this.latestUpdates = const [],
    this.appPrimaryColor,
    this.appBannerOneUrl,
    this.appBannerTwoUrl,
    this.otpType,
    this.otpDigitLimit,
    this.otpExpireTime,
    this.socialMediaFacebook,
    this.socialMediaInstagram,
    this.socialMediaTwitter,
    this.socialMediaYoutube,
    this.orderSetupFoodPreparationTime,
    this.orderSetupTakeaway,
    this.orderSetupDelivery,
    this.orderSetupFreeDeliveryKilometer,
    this.orderSetupBasicDeliveryCharge,
    this.orderSetupChargePerKilo,
    this.cookiesDetailsPageId,
    this.cookiesSummary,
    this.notificationFcmApiKey,
    this.notificationFcmAuthDomain,
    this.notificationFcmProjectId,
    this.notificationFcmStorageBucket,
    this.notificationFcmMessagingSenderId,
    this.notificationFcmAppId,
    this.notificationFcmPublicVapidKey,
    this.notificationFcmMeasurementId,
    this.notificationAudio,
    this.imageCart,
    this.imageConfirm,
    this.imageVag,
    this.imageNonVag,
    this.imageAppStore,
    this.imagePlayStore,
    this.imageOrderTrack,
    this.imageOrderPlaced,
    this.imageOrderComplete,
    this.imageOrderDelivered,
    this.imageOrderPreparing,
    this.imageOrderOutForDelivery,
    this.imageOrderRejected,
    this.imageOrderCanceled,
    this.imageOrderReturned,
    this.imageFourZeroFourPage,
    this.imageFourZeroThreePage,
    this.demo,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
    companyName: json["company_name"],
    companyEmail: json["company_email"],
    companyPhone: json["company_phone"],
    companyAddress: json["company_address"],
    companyCountryCode: json["company_country_code"],
    siteDefaultBranch: json["site_default_branch"],
    siteDefaultLanguage: json["site_default_language"],
    siteAndroidAppLink: json["site_android_app_link"],
    siteIosAppLink: json["site_ios_app_link"],
    siteCopyright: json["site_copyright"],
    siteCurrencyPosition: json["site_currency_position"],
    siteDigitAfterDecimalPoint: json["site_digit_after_decimal_point"],
    siteDefaultCurrencySymbol: json["site_default_currency_symbol"],
    sitePhoneVerification: json["site_phone_verification"],
    siteLanguageSwitch: json["site_language_switch"],
    siteOnlinePaymentGateway: json["site_online_payment_gateway"],
    paymentGateways: json["payment_gateways"] == null
        ? []
        : List<PaymentGatewayData>.from(
            json["payment_gateways"].map((x) => PaymentGatewayData.fromJson(x)),
          ),
    siteGuestLogin: json["site_guest_login"],
    themeLogo: json["theme_logo"],
    themeFooterLogo: json["theme_footer_logo"],
    themeFaviconLogo: json["theme_favicon_logo"],
    appIntroMediaUrl: json["app_intro_media_url"],
    appIntroMediaType: json["app_intro_media_type"],
    latestUpdate: _latestUpdateFromJson(json["latest_update"]),
    latestUpdates: _latestUpdatesFromJson(
      json["latest_updates"],
      json["latest_update"],
    ),
    appPrimaryColor: json["app_primary_color"]?.toString(),
    appBannerOneUrl: json["app_banner_1_url"]?.toString(),
    appBannerTwoUrl: json["app_banner_2_url"]?.toString(),
    otpType: json["otp_type"],
    otpDigitLimit: json["otp_digit_limit"],
    otpExpireTime: json["otp_expire_time"],
    socialMediaFacebook: json["social_media_facebook"],
    socialMediaInstagram: json["social_media_instagram"],
    socialMediaTwitter: json["social_media_twitter"],
    socialMediaYoutube: json["social_media_youtube"],
    orderSetupFoodPreparationTime: json["order_setup_food_preparation_time"],
    orderSetupTakeaway: json["order_setup_takeaway"],
    orderSetupDelivery: json["order_setup_delivery"],
    orderSetupFreeDeliveryKilometer:
        json["order_setup_free_delivery_kilometer"],
    orderSetupBasicDeliveryCharge: json["order_setup_basic_delivery_charge"],
    orderSetupChargePerKilo: json["order_setup_charge_per_kilo"],
    cookiesDetailsPageId: json["cookies_details_page_id"],
    cookiesSummary: json["cookies_summary"],
    notificationFcmApiKey: json["notification_fcm_api_key"],
    notificationFcmAuthDomain: json["notification_fcm_auth_domain"],
    notificationFcmProjectId: json["notification_fcm_project_id"],
    notificationFcmStorageBucket: json["notification_fcm_storage_bucket"],
    notificationFcmMessagingSenderId:
        json["notification_fcm_messaging_sender_id"],
    notificationFcmAppId: json["notification_fcm_app_id"],
    notificationFcmPublicVapidKey: json["notification_fcm_public_vapid_key"],
    notificationFcmMeasurementId: json["notification_fcm_measurement_id"],
    notificationAudio: json["notification_audio"],
    imageCart: json["image_cart"],
    imageConfirm: json["image_confirm"],
    imageVag: json["image_vag"],
    imageNonVag: json["image_non_vag"],
    imageAppStore: json["image_app_store"],
    imagePlayStore: json["image_play_store"],
    imageOrderTrack: json["image_order_track"],
    imageOrderPlaced: json["image_order_placed"],
    imageOrderComplete: json["image_order_complete"],
    imageOrderDelivered: json["image_order_delivered"],
    imageOrderPreparing: json["image_order_preparing"],
    imageOrderOutForDelivery: json["image_order_out_for_delivery"],
    imageOrderRejected: json["image_order_rejected"],
    imageOrderCanceled: json["image_order_canceled"],
    imageOrderReturned: json["image_order_returned"],
    imageFourZeroFourPage: json["image_four_zero_four_page"],
    imageFourZeroThreePage: json["image_four_zero_three_page"],
    demo: json["demo"],
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "company_email": companyEmail,
    "company_phone": companyPhone,
    "company_country_code": companyCountryCode,
    "site_default_branch": siteDefaultBranch,
    "site_default_language": siteDefaultLanguage,
    "site_currency_position": siteCurrencyPosition,
    "site_digit_after_decimal_point": siteDigitAfterDecimalPoint,
    "site_default_currency_symbol": siteDefaultCurrencySymbol,
    "site_phone_verification": sitePhoneVerification,
    "otp_type": otpType,
    "otp_digit_limit": otpDigitLimit,
    "otp_expire_time": otpExpireTime,
    "order_setup_food_preparation_time": orderSetupFoodPreparationTime,
    "order_setup_takeaway": orderSetupTakeaway,
    "order_setup_delivery": orderSetupDelivery,
    "order_setup_free_delivery_kilometer": orderSetupFreeDeliveryKilometer,
    "order_setup_basic_delivery_charge": orderSetupBasicDeliveryCharge,
    "order_setup_charge_per_kilo": orderSetupChargePerKilo,
    "site_online_payment_gateway": siteOnlinePaymentGateway,
    "payment_gateways": paymentGateways.map((x) => x.toJson()).toList(),
    "app_intro_media_url": appIntroMediaUrl,
    "app_intro_media_type": appIntroMediaType,
    "latest_update": latestUpdate?.toJson(),
    "latest_updates": latestUpdates.map((x) => x.toJson()).toList(),
    "app_primary_color": appPrimaryColor,
    "app_banner_1_url": appBannerOneUrl,
    "app_banner_2_url": appBannerTwoUrl,
    "demo": demo,
  };

  static LatestUpdateData? _latestUpdateFromJson(dynamic value) {
    if (value is Map<String, dynamic>) {
      return LatestUpdateData.fromJson(value);
    }
    if (value is Map) {
      return LatestUpdateData.fromJson(Map<String, dynamic>.from(value));
    }
    return null;
  }

  static List<LatestUpdateData> _latestUpdatesFromJson(
    dynamic updatesValue,
    dynamic fallbackValue,
  ) {
    final updates = <LatestUpdateData>[];

    if (updatesValue is List) {
      for (final item in updatesValue) {
        final update = _latestUpdateFromJson(item);
        if (update != null) {
          updates.add(update);
        }
      }
      return updates;
    }

    final fallbackUpdate = _latestUpdateFromJson(fallbackValue);
    if (fallbackUpdate != null) {
      updates.add(fallbackUpdate);
    }

    return updates;
  }
}

class LatestUpdateData {
  final int? id;
  final String? imageUrl;
  final String? heading;
  final String? description;
  final bool buttonOneEnabled;
  final String? buttonOneText;
  final String? buttonOneLink;
  final bool buttonTwoEnabled;
  final String? buttonTwoText;
  final String? buttonTwoLink;

  const LatestUpdateData({
    this.id,
    this.imageUrl,
    this.heading,
    this.description,
    this.buttonOneEnabled = false,
    this.buttonOneText,
    this.buttonOneLink,
    this.buttonTwoEnabled = false,
    this.buttonTwoText,
    this.buttonTwoLink,
  });

  factory LatestUpdateData.fromJson(Map<String, dynamic> json) =>
      LatestUpdateData(
        id: json["id"],
        imageUrl: json["image_url"]?.toString(),
        heading: json["heading"]?.toString(),
        description: json["description"]?.toString(),
        buttonOneEnabled: _boolFromJson(json["button_one_enabled"]),
        buttonOneText: json["button_one_text"]?.toString(),
        buttonOneLink: json["button_one_link"]?.toString(),
        buttonTwoEnabled: _boolFromJson(json["button_two_enabled"]),
        buttonTwoText: json["button_two_text"]?.toString(),
        buttonTwoLink: json["button_two_link"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "heading": heading,
    "description": description,
    "button_one_enabled": buttonOneEnabled,
    "button_one_text": buttonOneText,
    "button_one_link": buttonOneLink,
    "button_two_enabled": buttonTwoEnabled,
    "button_two_text": buttonTwoText,
    "button_two_link": buttonTwoLink,
  };

  static bool _boolFromJson(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      return value == '1' || value.toLowerCase() == 'true';
    }
    return false;
  }
}

class PaymentGatewayData {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;

  const PaymentGatewayData({this.id, this.name, this.slug, this.image});

  factory PaymentGatewayData.fromJson(Map<String, dynamic> json) =>
      PaymentGatewayData(
        id: json["id"],
        name: json["name"]?.toString(),
        slug: json["slug"]?.toString(),
        image: json["image"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
  };
}
