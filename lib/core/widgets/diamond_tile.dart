import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kgkdiamonds/core/constant/app_images.dart';
import 'package:kgkdiamonds/core/widgets/blink_animation.dart';
import '../models/data.dart';

class DiamondTile extends StatelessWidget {
  final DataModel diamond;
  final Function()? onTap;
  final bool selected;

  const DiamondTile(
      {super.key, required this.diamond, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    // return oldBody(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.h),
                child: Image.asset(
                  AppImages.APPLGOG,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
              SizedBox(width: 8.h),
              Text(
                "Lot ID: ",
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
              ),
              Text(
                diamond.lotID?.toString() ?? '0',
                style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade700),
              ),
              if (selected)
                Text(
                  " (In Cart)",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.primary),
                ),
              const Spacer(),
              SizedBox(
                height: 24.h,
                width: 24.h,
                child: Checkbox(
                    value: selected, onChanged: (value) => onTap?.call()),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFd8e6ee),
                    Color(0xFFd1dce6),
                    Color(0xFFd4dce8),
                    Color(0xFFe6ebf9),
                    Color(0xFFeaedfc),
                    Color(0xFFedecfa),
                    Color(0xFFf2f0f7),
                    Color(0xFFdde0dd),
                    Color(0xFFbccaba),
                    Color(0xFFe9eae0)
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    priceColumn(
                      "Final Amount",
                      "\$${diamond.finalAmount?.toStringAsFixed(2)}",
                    ),
                    priceColumn(
                      "Per Carat Price",
                      "\$${diamond.perCaratRate?.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ),
              BlinkAnimation(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                color: Colors.green,
                child: Text(
                  "${diamond.discount?.toStringAsFixed(2)} %",
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey.shade300, Colors.white, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsColumn("Lab", diamond.lab ?? "N/A"),
                detailsColumn("Color", diamond.color ?? "N/A"),
                detailsColumn("Shape", diamond.shape ?? "N/A"),
                detailsColumn("Size", diamond.size ?? "N/A"),
                detailsColumn("Carat", diamond.carat?.toString() ?? "N/A"),
                detailsColumn("Clarity", diamond.clarity ?? "N/A"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column priceColumn(String heading, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Column detailsColumn(String heading, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          heading,
          style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
