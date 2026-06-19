import 'package:get/get.dart';

import '../../../data/model/response/coupon_model.dart';
import '../../../data/repository/coupon_repo.dart';

class CouponController extends GetxController {
  CouponRepo couponRepo = CouponRepo();
  List<CouponData> couponDataList = <CouponData>[];
  bool loader = false;

  @override
  void onInit() {
    getCouponList();
    super.onInit();
  }

  getCouponList() async {
    loader = true;
    update();
    var couponData = await CouponRepo.getCoupon();
    if (couponData != null) {
      couponDataList = couponData.data ?? [];
    }
    loader = false;
    update();
  }
}
