import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container orderStatus(status, bgColor, textColor) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(9.r)),
      color: bgColor,
    ),
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Text(
        status.toString(),
        style: TextStyle(
          fontFamily: "Rubik",
          fontSize: 9.sp,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
