import 'package:app/domain/explorer/university_list_model/university_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_search_field.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ProfileSubmission extends StatefulWidget {
  const ProfileSubmission({super.key});

  @override
  State<ProfileSubmission> createState() => _ProfileSubmissionState();
}

class _ProfileSubmissionState extends State<ProfileSubmission> {
  final List<TextEditingController> _textController = List.generate(
    7,
    (_) => generateTextController(),
  );
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _submitting = ValueNotifier(false);

  List<MenuItem> _universityList = [];
  List<UniversityListModel> university = [];

  _getUniversityList() async {
    try {
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/university-list/');
      if (response.statusCode == 200) {
        university = (response.data as List)
            .map((e) => UniversityListModel.fromJson(e))
            .toList();
        _universityList = university
            .map((e) => MenuItem(e.universityId.toString(), e.name.toString()))
            .toList();
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  String selectedUId = '';

  _profileUpdate() async {
    try {
      _submitting.value = true;
      final university = {
        "phone_no": _textController[2].text.trim(),
        "address": _textController[3].text.trim(),
        "affiliation": selectedUId,
        "website": _textController[4].text.trim(),
        "type": _textController[5].text.trim(),
        "short_name": _textController[1].text.trim(),
        "principal_name": _textController[0].text.trim(),
      };

      final response = await dioClient.dio.put(
        '${Env().apiBaseUrl}home/college/create-profile/',
        data: university,
      );
      if (response.statusCode == 201) {
        pref.token.value = pref.token.value.copyWith(
          isProfileCreated: true,
          isVerified: false,
        );
        //tokenCubit.updateToken(pref.token.value);
        appRouter.go(ScreenPath.login);
        _submitting.value = false;
      } else {
        _submitting.value = false;
      }
    } on DioException catch (_) {
      _submitting.value = false;
    }
  }

  final _formKey = generateFormKey();

  @override
  void initState() {
    super.initState();
    _getUniversityList();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (university.isEmpty) {
              return const Center(child: ErrorTextWidget());
            }
            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: inset.sm,
                  children: [
                    Gap(inset.xs),
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Complete\nCollege Profile',
                            textAlign: TextAlign.left,
                            style: $style.text.textEB26.copyWith(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: CustomDropDownSearch(
                        controller: _textController[6],
                        hintText: 'University',
                        menu: _universityList,
                        onSelect: (s) {
                          selectedUId = s?.id.toString() ?? 'uis';
                        },
                        validator: (email) {
                          if (_textController.isItemEmpty(6)) {
                            return "* Required";
                          }

                          return null;
                        },
                      ),
                    ),
                    CustomTextField(
                      hint: 'Principal Name',
                      controller: _textController[0],
                      validator: (email) {
                        if (_textController.isItemEmpty(0)) {
                          return "* Required";
                        }

                        return null;
                      },
                    ),
                    CustomTextField(
                      hint: 'Short Name',
                      controller: _textController[1],
                      validator: (email) {
                        if (_textController.isItemEmpty(1)) {
                          return "* Required";
                        }

                        return null;
                      },
                    ),
                    CustomTextField(
                      hint: 'Phone Number',
                      controller: _textController[2],
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      validator: (email) {
                        if (_textController.isItemEmpty(2)) {
                          return "* Required";
                        }
                        if (_textController.isInvalidPhoneAt(2)) {
                          return "Invalid Phone Number";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hint: 'Address',
                      controller: _textController[3],
                      validator: (email) {
                        if (_textController.isItemEmpty(3)) {
                          return "* Required";
                        }

                        return null;
                      },
                    ),
                    CustomTextField(
                      hint: 'Website',
                      controller: _textController[4],
                      validator: (email) {
                        if (_textController.isItemEmpty(4)) {
                          return "* Required";
                        }
                        if (!isValidUrl(_textController[4].text.trim())) {
                          return "Invalid URL (eg:https://example.com)";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      width: 280,
                      child: CustomDropDownSearch(
                        controller: _textController[5],
                        hintText: 'Type',
                        menu: [
                          MenuItem("id", "Government"),
                          MenuItem("id", "Private"),
                          MenuItem("id", "Aided"),
                        ],
                        onSelect: (s) {},
                        validator: (email) {
                          if (_textController.isItemEmpty(5)) {
                            return "* Required";
                          }

                          return null;
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: _submitting,
                        builder: (context, submit, _) {
                          return CustomButton(
                            name: "Submit",
                            onTap: submit
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _profileUpdate();
                                    }
                                  },
                          );
                        })
                  ],
                ),
              ),
            );
          }),
    );
  }
}
