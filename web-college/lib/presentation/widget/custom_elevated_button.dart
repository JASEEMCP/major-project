import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    required this.onTap,
    this.width,
    this.color,
    this.textColor,
  });

  final String name;
  final Function() onTap;
  final double? width;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 280,
      child: CupertinoButton(
        
        color: color ?? context.theme.indigo,
        onPressed: onTap,
        child: Text(
          name,
          style: $style.text.textN14.copyWith(
            color: textColor ?? context.theme.kWhite,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
  });
  final String text;
  final Function() onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: $style.text.textSBold12.copyWith(
          color: textColor ?? context.theme.indigo,
        ),
      ),
    );
  }
}
