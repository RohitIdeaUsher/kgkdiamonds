import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.title = "Filter", this.onTapDown});
  final String title;
  final Function(TapDownDetails)? onTapDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.filter_list_rounded, color: Colors.black),
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
