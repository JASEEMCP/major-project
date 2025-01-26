import 'package:app/domain/explorer/university_profile_model/university_profile_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);

UniversityProfileModel? _universityProfileModel;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List<TextEditingController> _pwdController =
      List.generate(3, (_) => generateTextController());

  final _formKey = generateFormKey();

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

  _fetchProfile() async {
    try {
      if (_universityProfileModel != null) {
        return;
      }
      _isLoading.value = true;
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}/home/university/manage-profile/');
      if (response.statusCode == 200) {
        _isLoading.value = false;
        _universityProfileModel =
            UniversityProfileModel.fromJson(response.data);

        _textController[0].text = _universityProfileModel?.name ?? 'N/A';
        _textController[1].text = _universityProfileModel?.email ?? 'N/A';
        _textController[2].text = _universityProfileModel?.website ?? 'N/A';
        _textController[3].text = _universityProfileModel?.phoneNo ?? 'N/A';
        _textController[4].text = _universityProfileModel?.address ?? 'N/A';
      }
    } on DioException catch (_) {
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
                      hint: 'University Name',
                      controller: _textController[0],
                    ),
                    CustomTextField(
                      hint: 'Email Address',
                      controller: _textController[1],
                    ),
                    CustomTextField(
                      hint: 'Website',
                      controller: _textController[2],
                    ),
                    CustomTextField(
                      hint: 'Phone Number',
                      controller: _textController[3],
                    ),
                    CustomTextField(
                      hint: 'Address',
                      controller: _textController[4],
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
        });
  }
}
