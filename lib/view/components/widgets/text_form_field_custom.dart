import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/utils/app_color.dart';

// ignore: must_be_immutable
class TextFormFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validate;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  bool? obSecure;
  final IconData? prefixIcon;
  final bool prefix;
  final Widget? prefixWidget;
  final IconData? suffixIcon;
  bool? toggle;
  final bool suffix;
  final Function? suffixOnPressed;
  final Widget? suffixWidget;
  final TextInputType? keyboardType;
  final int maxDigit;
  final Function? onChanged;
  final Function(String?)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Function? onTab;
  final FocusNode? focus;
  final TextAlign align;
  final String? initial;
  final bool? enable;
  final double? padding;
  final double? borderRadius;
  final bool? autoValidate;
  final int? maxLines;
  final TextAlignVertical? textAlignVertical;
  final bool? alignLabelWithHint;
  final Color? filledColor;

  TextFormFieldCustom({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.filledColor,
    this.obSecure = false,
    this.prefix = false,
    this.prefixWidget,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix = false,
    this.suffixWidget,
    this.suffixOnPressed,
    this.validate,
    this.keyboardType,
    this.maxDigit = 100,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onTab,
    this.onSaved,
    this.onEditingComplete,
    this.focus,
    this.align = TextAlign.start,
    this.initial,
    this.enable,
    this.autoValidate = false,
    this.padding = 16.0,
    this.borderRadius = 10,
    this.toggle = false,
    this.maxLines = 1,
    this.textAlignVertical = TextAlignVertical.center,
    this.alignLabelWithHint = false,
  });

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      textAlignVertical: widget.textAlignVertical,
      textAlign: widget.align,
      focusNode: widget.focus,
      // autofocus: true,
      autovalidateMode: widget.autoValidate! ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      enabled: widget.enable,
      initialValue: widget.initial,
      controller: widget.controller,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onChanged: (value) {
        //onChanged!(value);
        widget.onChanged != null ? widget.onChanged!(value) : null;
      },
      onEditingComplete: widget.onEditingComplete,
      obscureText: widget.obSecure!,
      validator: widget.validate,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.darkBlue,
      onTap: () {
        widget.onTab != null ? widget.onTab!() : null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxDigit),
      ],
      //maxLength: maxDigit,
      decoration: InputDecoration(
        isDense: true,
        alignLabelWithHint: widget.alignLabelWithHint,
        //floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!.r),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 2.w,
          ),
        ),
        fillColor: widget.filledColor,
        filled: widget.filledColor == null ? false : true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!.r),
          borderSide: BorderSide(
            color: AppColors.darkBlue,
            width: 2.w
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!.r),
          borderSide: const BorderSide(
            color: AppColors.grey,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.padding!.h,
          horizontal: 16.w,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!.r),
          borderSide: BorderSide(
            color: AppColors.darkBlue,
            width: 2.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!.r),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1.5.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!.r),
          borderSide: const BorderSide(
            color: AppColors.red,
          ),
        ),
        suffixIconColor: AppColors.grey,
        focusColor: AppColors.darkBlue,
        prefixIcon: widget.prefix
            ? Icon(
                widget.prefixIcon,
                color: AppColors.grey,
                size: 16.h,
              )
            : widget.prefixWidget,
        suffixIcon: widget.suffix
            ? IconButton(
                icon: Icon(
                  widget.toggle! ? Icons.visibility_off : Icons.visibility,
                  color: widget.toggle! ? AppColors.grey : AppColors.darkBlue,
                  size: 16.h,
                ),
                onPressed: () {
                  setState(() {
                    widget.toggle = !widget.toggle!;
                    widget.obSecure = !widget.obSecure!;
                  });
                },
              )
            : widget.suffixWidget,
        // suffix: widget.suffixWidget,
        labelText: widget.label,
        hintText: widget.hint,
        labelStyle: TextStyle(
          color: AppColors.grey,
          fontSize: 14.sp,
        ),
        hintStyle: TextStyle(
          color: AppColors.grey,
          fontSize: 14.sp,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
