import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../util/constant.dart';

class BottomNavItem extends StatelessWidget {
  final AssetImage? imageData;
  final String? svgPath;
  final String? tittle;
  final VoidCallback? onTap;
  final bool isSelected;
  const BottomNavItem({
    super.key,
    this.imageData,
    this.svgPath,
    this.tittle,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath!,
                  width: 25.sp,
                  height: 25.sp,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? AppColor.primaryColor
                        : const Color(0xff25232A),
                    BlendMode.srcIn,
                  ),
                )
              else
                ImageIcon(
                  imageData,
                  size: 25.sp,
                  color: isSelected
                      ? AppColor.primaryColor
                      : const Color(0xff25232A),
                ),
              Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                child: Text(
                  tittle!,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColor.primaryColor
                        : const Color(0xff25232A),
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
