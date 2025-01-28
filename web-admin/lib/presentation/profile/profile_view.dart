import 'package:app/domain/explorer/admin_profile_model/admin_profile_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);

AdminProfileModel? _universityProfileModel;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List<TextEditingController> _pwdController =
      List.generate(3, (_) => generateTextController());

  final _formKey = generateFormKey();

  final ValueNotifier<bool> _isChanging = ValueNotifier(false);

  _changePassword(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      try {
        _isChanging.value = true;
        final response = await dioClient.dio.post(
          '${Env().apiBaseUrl}/home/reset-password/',
          data: {
            'old_password': _pwdController[0].text,
            'new_password': _pwdController[2].text,
          },
        );
        if (response.statusCode == 200) {
          _isChanging.value = false;
          for (TextEditingController controller in _pwdController) {
            controller.clear();
          }
          if (ctx.mounted) {
            ctx.showCustomSnackBar(
                'Password changed successfully', Colors.green);
          }
        } else {
          _isChanging.value = false;
        }
      } on DioException catch (e) {
        if (ctx.mounted) {
          ctx.showCustomSnackBar(
              e.response?.data['message'] ?? 'An error occurred');
          _isChanging.value = false;
        }
      }
    }
  }

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  _fetchProfile() async {
    try {
      if (_universityProfileModel != null) {
        _textController[0].text = _universityProfileModel?.email ?? 'N/A';
        _textController[1].text = _universityProfileModel?.phoneNumber ?? 'N/A';
        _textController[2].text = _universityProfileModel?.gender ?? 'N/A';
        return;
      }
      _isLoading.value = true;
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}/home/admin/manage-profile/');
      if (response.statusCode == 200) {
        _isLoading.value = false;
        _universityProfileModel = AdminProfileModel.fromJson(response.data);

        _textController[0].text = _universityProfileModel?.email ?? 'N/A';
        _textController[1].text = _universityProfileModel?.phoneNumber ?? 'N/A';
        _textController[2].text = _universityProfileModel?.gender ?? 'N/A';
      }
    } on DioException catch (_) {
      _universityProfileModel = null;
      _isLoading.value = false;
    }
  }

  final List<TextEditingController> _textController =
      List.generate(5, (_) => generateTextController());

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;

    return ValueListenableBuilder(
      valueListenable: _isLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_universityProfileModel == null) {
          return const Center(child: Text('No data found'));
        }
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
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  CustomTextField(
                    hint: 'Email Address',
                    readOnly: true,
                    controller: _textController[0],
                  ),
                  CustomTextField(
                    hint: 'Phone Number',
                    readOnly: true,
                    controller: _textController[1],
                  ),
                  CustomTextField(
                    hint: 'Gender',
                    readOnly: true,
                    controller: _textController[2],
                  ),
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
                },
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                valueListenable: _isChanging,
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
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
