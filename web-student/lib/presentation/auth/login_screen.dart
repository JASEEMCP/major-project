import 'package:app/domain/auth/token.dart';
import 'package:app/domain/common_state.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/resource/api/end_points.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: must_be_immutable
class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final _formKey = generateFormKey();
  final List<TextEditingController> _textController = List.generate(
    2,
    (_) => generateTextController(),
  );
  ApiState apiState = InitialState();
  _login(BuildContext context) async {
    apiState = LoadingState();

    try {
      print(Env().apiBaseUrl);
      final token = await FirebaseMessaging.instance.getToken();
      final response = await Dio().post(
        "${Env().apiBaseUrl}${EndPoints.login}",
        data: {
          'email': _textController[0].text.trim(),
          'password': _textController[1].text.trim(),
          'fcm_token': token,
        },
      );

      if (response.statusCode == 200) {
        apiState = SuccessState();
        pref.token.value = Token.fromJson(response.data);
        // if (!(pref.token.value.isVerified ?? false)) {
        //   if (context.mounted) {
        //     return context.showCustomSnackBar(
        //         'Student is Not verified', Colors.red);
        //   }
        // }
        tokenCubit.updateToken(pref.token.value);
        if (pref.token.value.isProfileCreated ?? false) {
          appRouter.go(ScreenPath.explore);
        } else {
          appRouter.go(ScreenPath.signupProfile);
        }
      } else {
        apiState = ErrorState();
      }
    } on DioException catch (e) {
      // print(e.response?.statusCode);

      if (context.mounted) {
        if (e.response?.statusCode == 400) {
          return context.showCustomSnackBar(
              e.response?.data['message'] ?? 'An error occurred', Colors.red);
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar('Invalid Username or Password'));
      }

      apiState = ErrorState();
    }
  }

  final ValueNotifier<bool> _visibilityNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      backgroundColor: context.theme.indigoLight.withOpacity(0.5),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(inset.offset),
                Gap(inset.xs),
                Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Text(
                    'Login\nStudent Profile',
                    textAlign: TextAlign.left,
                    style: $style.text.textEB26.copyWith(),
                  ),
                ),
                Gap(inset.xs),
                CustomTextField(
                  hint: 'Student email',
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
                Gap(inset.sm),
                ValueListenableBuilder(
                    valueListenable: _visibilityNotifier,
                    builder: (context, isVisible, _) {
                      return CustomTextField(
                        hint: 'Password',
                        isObscure: isVisible,
                        suffix: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            _visibilityNotifier.value = !isVisible;
                          },
                        ),
                        controller: _textController[1],
                        validator: (email) {
                          if (_textController.isItemEmpty(0)) {
                            return "* Required";
                          }

                          return null;
                        },
                      );
                    }),
                Gap(inset.xs),
                Align(
                  alignment: const Alignment(-0.9, 0),
                  child: CustomTextButton(
                    text: 'Forgot Password?',
                    onTap: () {
                      context.go(ScreenPath.forgotPwd);
                    },
                  ),
                ),
                Gap(inset.sm),
                CustomButton(
                  name: 'Login',
                  onTap: () {
                    print('Hello');
                    if (_formKey.currentState!.validate()) {
                      _login(context);
                    }
                  },
                ),
                Gap(inset.lg),
                Center(
                  child: CustomTextButton(
                    text: 'Create Account?',
                    onTap: () {
                      context.go(ScreenPath.signup);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
