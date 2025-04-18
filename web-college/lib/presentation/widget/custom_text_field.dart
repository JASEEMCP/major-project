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
    this.inputFormatters,
    this.readOnly,
  });
  final String hint;
  final String? Function(String?)? validator;
  final double? width;
  final TextEditingController? controller;
  final bool? isObscure;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 280,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly ?? false,
        validator: validator,
        inputFormatters: inputFormatters,
        obscureText: isObscure ?? false,
        style: $style.text.textSBold12,
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


