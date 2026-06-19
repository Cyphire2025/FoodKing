import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/data/model/response/item_model.dart';
import '../util/localized_text.dart';

String itemMetaText(ItemData item) {
  final parts = <String>[];
  final size = item.size?.trim();
  if (size != null && size.isNotEmpty) {
    parts.add(localizeText(size));
  }
  final calories = item.calories;
  if (calories != null && calories > 0) {
    parts.add('$calories kcal');
  }
  return parts.join(' - ');
}

class ItemMetaText extends StatelessWidget {
  final ItemData item;
  final TextStyle? style;
  final int maxLines;
  final TextAlign textAlign;

  const ItemMetaText({
    super.key,
    required this.item,
    this.style,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final text = itemMetaText(item);
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style:
          style ??
          TextStyle(
            fontFamily: 'Rubik',
            color: const Color(0xff8A6A6A),
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            height: 1.15,
          ),
    );
  }
}
