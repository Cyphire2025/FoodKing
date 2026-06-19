import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';

class TimeSlotWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 38.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: isSelected ? AppColor.primaryBackgroundColor : Colors.white,
            border: isSelected
                ? Border.all(color: AppColor.primaryColor, width: 1.1.w)
                : Border.all(color: AppColor.dividerColor),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(
                  isSelected ? 0.07 : 0.03,
                ),
                blurRadius: 12.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14.w,
                height: 14.h,
                child: isSelected
                    ? SvgPicture.asset(
                        Images.IconVariationSelected,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          AppColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(Images.IconVariation, fit: BoxFit.cover),
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: isSelected
                      ? AppColor.primaryColor
                      : AppColor.fontColor,
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
