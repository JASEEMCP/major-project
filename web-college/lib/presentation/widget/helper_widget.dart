import 'dart:ui';

import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.txt,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLine,
  });
  final String txt;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textScaler: const TextScaler.linear(1),
      maxLines: maxLine,
      style: $style.text.textSBold14.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.txt,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLine,
    this.onTap,
  });
  final String txt;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLine;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        txt,
        textScaler: const TextScaler.linear(1),
        maxLines: maxLine,
        style: $style.text.textSBold12.copyWith(
          color: color ?? Colors.indigo,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    super.key,
    this.content,
    this.onTap,
  });

  final String? content;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content ?? 'Something went wrong',
          style: $style.text.textN16.copyWith(
            color: context.theme.kBlack.withOpacity(0.6),
          ),
        ),
        Gap(inset.sm),
        if (onTap != null)
          CustomButton(
            onTap: onTap!,
            width: 150,
            name: 'Try Again',
          ),
      ],
    );
  }
}

Future<dynamic> customAlertBox(
  BuildContext context, {
  Function()? onTap,
  String? title,
  String? content,
  Widget? child,
}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              fontSize: 16,
              txt: title ?? 'Appointment',
            ),
            CustomCircleBtn(
              icon: Icons.close_rounded,
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
        content: child ??
            CustomText(
              fontWeight: FontWeight.w400,
              txt: content ??
                  'Are you sure you want to proceed with the booking?',
            ),
        actions: [
          CustomButton(
            name: 'Confirm',
            onTap: onTap ?? () {},
          ),
        ],
      );
    },
  );
}

Row rowTitleText(String title, String content) {
  return Row(
    children: [
      CustomText(
        txt: '$title : ',
        fontSize: 14,
      ),
      CustomText(
        txt: content,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      )
    ],
  );
}
