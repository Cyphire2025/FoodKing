import 'package:get/get.dart';

import '../../../data/model/response/config_model.dart';
import '../../../data/model/response/time_slot_model.dart';
import '../../../data/repository/time_slot_repo.dart';

class CheckoutController extends GetxController {
  bool couponApplied = false;
  int selectDateSlot = 0;
  int selectTimeSlot = 0;
  String selectedPaymentMethod = '';

  List<TimeSlotData> todayDataList = <TimeSlotData>[];
  List<TimeSlotData> tomorrowDataList = <TimeSlotData>[];

  @override
  void onInit() {
    getTodayTime();
    getTomorrowTime();
    super.onInit();
  }

  Future<void> getTodayTime() async {
    var todayData = await TimeSlotRepo.getTodayTimeSlot();
    if (todayData != null && todayData.data != null) {
      final now = DateTime.now();
      todayDataList = todayData.data!.where((slot) {
        if (slot.fromTime == null) return true;
        if (slot.label == 'now' || slot.label == 'now'.tr) return true;
        try {
          final parts = slot.fromTime!.split(':');
          if (parts.length >= 2) {
            final hour = int.parse(parts[0]);
            final minute = int.parse(parts[1]);
            final slotTime = DateTime(now.year, now.month, now.day, hour, minute);
            return slotTime.isAfter(now);
          }
        } catch (e) {
          return true;
        }
        return true;
      }).toList();
      update();
    }
    update();
  }

  Future<void> getTomorrowTime() async {
    var tomorrowData = await TimeSlotRepo.getTomorrowTimeSlot();
    if (tomorrowData != null) {
      tomorrowDataList = tomorrowData.data!;
      update();
    }
    update();
  }

  void updateDateSlot(int index) {
    selectDateSlot = index;
    update();
  }

  void updateTimeSlot(int index) {
    selectTimeSlot = index;
    update();
  }

  List<PaymentGatewayData> availablePaymentGateways(
    List<PaymentGatewayData> paymentGateways,
  ) {
    return paymentGateways;
  }

  bool isPaymentMethodAllowed(String method) {
    return method.isNotEmpty;
  }

  void setDefaultPaymentMethod(List<PaymentGatewayData> paymentGateways) {
    final availableGateways = availablePaymentGateways(paymentGateways);

    if (availableGateways.isEmpty) {
      selectedPaymentMethod = '';
      update();
      return;
    }

    final hasSelected = availableGateways.any(
      (gateway) => gateway.slug == selectedPaymentMethod,
    );
    if (!hasSelected) {
      selectedPaymentMethod = availableGateways.first.slug ?? '';
      update();
    }
  }

  void selectPaymentMethod(String method) {
    if (!isPaymentMethodAllowed(method)) {
      return;
    }

    selectedPaymentMethod = method;
    update();
  }
}
