import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///[TextView]  is common text class
class TextView extends StatelessWidget {
  const TextView({
    super.key,
    this.text,
    this.fontSize = 15.0,
    this.fontWeight = FontWeight.w500,
    this.marginTop = 0,
    this.maxLine,
    this.textOverflow,
    this.lineHeight,
    this.textAlign,
    this.textDecoration,
    this.laterSpacing,
    this.fontFamily,
    this.textColor,
    this.isParamEnabled,
  }) : assert(text != null);

  final TextDecoration? textDecoration;
  final double? fontSize;
  final String? text;
  final String? fontFamily;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? marginTop;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final double? lineHeight;
  final TextAlign? textAlign;
  final double? laterSpacing;
  final bool? isParamEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0),
      child: Text(
        text!,
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLine,
        style: TextStyle(
          letterSpacing: laterSpacing,
          decoration: textDecoration,
          height: lineHeight,
          fontSize: fontSize ?? 16.sp,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }
}
