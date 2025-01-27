import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.width,
    this.validator,
    this.controller,
    this.isObscure,
    this.suffix,
    this.inputFormatter,
    this.readOnly,
    this.onTap,
    this.maxLine,
  });
  final String hint;
  final String? Function(String?)? validator;
  final double? width;
  final TextEditingController? controller;
  final bool? isObscure;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatter;
  final bool? readOnly;
  final Function()? onTap;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 280,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly ?? false,
        validator: validator,
        onTap: onTap,
        minLines: 1,
        maxLines: maxLine ?? 1,
        inputFormatters: inputFormatter,
        obscureText: isObscure ?? false,
        style: $style.text.textSBold12.copyWith(
          color: context.theme.indigo,
        ),
        decoration: InputDecoration(
          suffixIcon: suffix,
          hintText: hint,
          isDense: true,
          filled: true,
          hintStyle: $style.text.textSBold12,
          fillColor: context.theme.kWhite,
          border: _applyBorderStyle(),
          enabledBorder: _applyBorderStyle(),
          focusedBorder: _applyBorderStyle(),
          errorBorder: _applyBorderStyle(),
        ),
      ),
    );
  }

  OutlineInputBorder _applyBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    );
  }
}
