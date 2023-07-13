import 'package:blnk_project/view_model/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final double? radius;
  final double? width;
  final double? height;
  final double? elevation;
  final Color? colors;
  final Color? textColor;
  final double? fontSize;
  final Widget? widget;
  final Color? borderColor;

  const ElevatedButtonCustom({
    Key? key,
    this.text,
    this.onPressed,
    this.radius = 12,
    this.width = 50,
    this.height = 12,
    this.elevation = 0,
    this.colors,
    this.fontSize,
    this.textColor = Colors.white,
    this.widget,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!.r),
          side: BorderSide(
            color: onPressed == null ? Colors.transparent : borderColor ?? AppColors.darkBlue,
          ),
        ),
        backgroundColor: colors ?? AppColors.darkBlue,
        elevation: elevation,
        padding: EdgeInsets.symmetric(horizontal: width!.w, vertical: height!.h),
        textStyle: TextStyle(
          fontSize: fontSize ?? 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: widget ??
          Text(
            text ?? '',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize?.sp,
            ),
            maxLines: 10,
          ),
    );
  }
}
