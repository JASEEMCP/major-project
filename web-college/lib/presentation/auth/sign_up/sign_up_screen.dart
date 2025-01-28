import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/resource/api/dio_cookie_manager.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

String email = '';

final DioCookieManger dioCookie = DioCookieManger();

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final List<TextEditingController> _textController = List.generate(
    3,
    (_) => generateTextController(),
  );

  final ValueNotifier<bool> _isSending = ValueNotifier(false);

  final ValueNotifier<bool> _isSended = ValueNotifier(false);

  _sendOtp(BuildContext ctx) async {
    try {
      _isSending.value = true;
      final response = await dioCookie.dio.post(
        "${Env().apiBaseUrl}home/signup/",
        data: {
          'email': _textController[0].text.trim(),
          'name': _textController[2].text.trim()
        },
      );
      if (response.statusCode == 200) {
        _isSending.value = false;
        _isSended.value = true;
        email = _textController[0].text.trim();
        if (ctx.mounted) {
          ctx.showCustomSnackBar(
              response.data['message'] ?? 'An error occurred', Colors.green);
        }
      } else {
        _isSending.value = false;
        if (ctx.mounted) {
          ctx.showCustomSnackBar(
            response.data['message'] ?? 'An error occurred',
          );
        }
      }
    } on DioException catch (e) {
      _isSending.value = false;
      if (ctx.mounted) {
        ctx.showCustomSnackBar(
          e.response?.data['message'] ?? 'An error occurred',
        );
      }
    }
  }

  _verifyOtp(BuildContext context) async {
    try {
      _isSending.value = true;
      final response = await dioCookie.dio.post(
        "${Env().apiBaseUrl}home/signup/otp-verify/",
        data: {
          'otp': _textController[1].text.trim(),
        },
      );
      if (response.statusCode == 200) {
        _isSending.value = false;
        if (context.mounted) {
          context.showCustomSnackBar(
              response.data['message'] ?? 'An error occurred', Colors.green);
          context.go(ScreenPath.signupPwd);
        }
      } else {
        _isSending.value = false;
        if (context.mounted) {
          context.showCustomSnackBar(
            response.data['message'] ?? 'An error occurred',
          );
        }
      }
    } on DioException catch (e) {
      _isSending.value = false;
      if (context.mounted) {
        context.showCustomSnackBar(
          e.response?.data['message'] ?? 'An error occurred',
        );
      }
    }
  }

  final _formKey = generateFormKey();

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(inset.offset),
              Gap(inset.xs),
              Align(
                alignment: const Alignment(-0.056, 0),
                child: Text(
                  'Create Account?',
                  textAlign: TextAlign.center,
                  style: $style.text.textEB26.copyWith(),
                ),
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                valueListenable: _isSended,
                builder: (context, isSended, _) {
                  return Column(
                    spacing: inset.sm,
                    children: [
                      CustomTextField(
                        readOnly: isSended,
                        hint: 'College Name',
                        validator: (email) {
                          if (_textController.isItemEmpty(2)) {
                            return "* Required";
                          }

                          return null;
                        },
                        controller: _textController[2],
                      ),
                      CustomTextField(
                        readOnly: isSended,
                        hint: 'College email',
                        validator: (email) {
                          if (_textController.isItemEmpty(0)) {
                            return "* Required";
                          }
                          if (_textController.isValidEmailAt(0)) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                        controller: _textController[0],
                      ),
                    ],
                  );
                },
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                valueListenable: _isSended,
                builder: (context, isSended, _) {
                  return !isSended
                      ? const SizedBox.shrink()
                      : CustomTextField(
                          hint: 'Enter OTP',
                          validator: (p0) {
                            if (_textController.isItemEmpty(1)) {
                              return "* Required";
                            }
                            return null;
                          },
                          inputFormatters: [LengthLimitingTextInputFormatter(4)],
                          controller: _textController[1],
                        );
                },
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                valueListenable: _isSending,
                builder: (context, isSending, _) {
                  return CustomButton(
                    name: isSending ? "Submitting" : 'Submit',
                    onTap: isSending
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              if (_isSended.value) {
                                _verifyOtp(context);
                              } else {
                                _sendOtp(context);
                              }
                            }
                          },
                  );
                },
              ),
              Gap(inset.sm),
              CustomTextButton(
                text: 'Back',
                onTap: () {
                  context.go(ScreenPath.login);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
