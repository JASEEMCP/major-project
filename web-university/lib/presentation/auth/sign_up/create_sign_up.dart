import 'package:app/domain/auth/token.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

class CreateSignUp extends StatefulWidget {
  const CreateSignUp({super.key});

  @override
  State<CreateSignUp> createState() => _ForgotPwdViewState();
}

class _ForgotPwdViewState extends State<CreateSignUp> {
  final List<TextEditingController> _pwdController =
      List.generate(3, (_) => generateTextController());

  final _formKey = generateFormKey();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  _changePassword(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        final response = await dioCookie.dio.post(
          '${Env().apiBaseUrl}/home/signup/password/',
          data: {
            'password': _pwdController[2].text.trim(),
            'user_type': "University",
          },
        );
        if (response.statusCode == 200) {
          _isLoading.value = false;
          var token = Token.fromJson(response.data);
          token = token.copyWith(
            userType: 'University',
            name: uName,
          );
          pref.token.value = token;
          if (ctx.mounted) {
            ctx.go(ScreenPath.signupProfile);
          }
        } else {
          _isLoading.value = false;
        }
      } on DioException catch (e) {
        if (ctx.mounted) {
          ctx.showCustomSnackBar(
              e.response?.data['message'] ?? 'An error occurred');
          _isLoading.value = false;
        }
      }
    }
  }

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(inset.offset),
              Gap(inset.xs),
              Align(
                alignment: const Alignment(-0.056, 0),
                child: Text(
                  'Create Password?',
                  textAlign: TextAlign.center,
                  style: $style.text.textEB26.copyWith(),
                ),
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                valueListenable: _isObscure,
                builder: (context, isObscure, _) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      spacing: inset.sm,
                      children: [
                        CustomTextField(
                          hint: 'New Password',
                          isObscure: isObscure,
                          controller: _pwdController[1],
                          validator: (p0) {
                            if (p0!.trim().isEmpty) {
                              return '* Password Required';
                            }
                            if (_pwdController.isValidPasswordAt(1)) {
                              return '* Password must be at least 8 characters long and include a number and a special character';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          hint: 'Confirm Password',
                          controller: _pwdController[2],
                          isObscure: isObscure,
                          validator: (p0) {
                            if (p0!.trim().isEmpty) {
                              return '* Password Required';
                            }
                            if (_pwdController.isValidPasswordAt(2)) {
                              return '* Password must be at least 8 characters long and include a number and a special character';
                            }
                            if (![_pwdController[1], _pwdController[2]]
                                .allSame()) {
                              return '* Passwords do not match';
                            }
                            return null;
                          },
                          suffix: IconButton(
                            icon: Icon(isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              _isObscure.value = !isObscure;
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                valueListenable: _isLoading,
                builder: (context, isSending, _) {
                  return CustomButton(
                    name: isSending ? "Submitting" : 'Submit',
                    onTap: isSending
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _changePassword(context);
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
