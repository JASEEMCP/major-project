import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final List<TextEditingController> _pwdController =
      List.generate(3, (_) => generateTextController());

  final _formKey = generateFormKey();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  _changePassword(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        final response = await dioClient.dio.post(
          '${Env().apiBaseUrl}/home/reset-password/',
          data: {
            'old_password': _pwdController[0].text,
            'new_password': _pwdController[2].text,
          },
        );
        if (response.statusCode == 200) {
          _isLoading.value = false;
          if (ctx.mounted) {
            ctx.showCustomSnackBar(
                'Password changed successfully', Colors.green);
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            txt: 'My Profile',
            fontSize: 20,
          ),
          Gap(inset.sm),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomTextField(hint: 'University Name'),
              CustomTextField(hint: 'Email Address'),
              CustomTextField(hint: 'Website'),
              CustomTextField(hint: 'Address'),
            ],
          ),
          Gap(inset.sm),
          const CustomText(
            txt: 'Change Password',
            fontSize: 20,
          ),
          Gap(inset.sm),
          ValueListenableBuilder(
              valueListenable: _isObscure,
              builder: (context, isObscure, _) {
                return Form(
                  key: _formKey,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      CustomTextField(
                        hint: 'Old Password',
                        isObscure: isObscure,
                        controller: _pwdController[0],
                        validator: (p0) {
                          if (p0!.trim().isEmpty) {
                            return '* Password Required';
                          }

                          return null;
                        },
                      ),
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
              }),
          Gap(inset.sm),
          ValueListenableBuilder(
              valueListenable: _isLoading,
              builder: (context, isLoading, _) {
                return CustomButton(
                  name: isLoading ? 'Submitting' : 'Submit',
                  color: Colors.green,
                  onTap: isLoading
                      ? null
                      : () {
                          _changePassword(context);
                        },
                );
              }),
        ],
      ),
    );
  }
}
