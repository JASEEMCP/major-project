import 'package:app/domain/explorer/admin_list_model/admin_list_model.dart';
import 'package:app/domain/explorer/college_list_model/college_list_model.dart';
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

  final _formKey = generateFormKey();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _submitting = ValueNotifier(false);

  /// College
  List<MenuItem> _universityList = [];
  List<CollegeListModel> university = [];

  /// Admin
  List<MenuItem> _adminList = [];
  List<AdminListModel> adminList = [];

  _getCollegeList() async {
    try {
      _isLoading.value = true;

      final response =
          await dioClient.dio.get('${Env().apiBaseUrl}home/club/college-list/');
      if (response.statusCode == 200) {
        university = (response.data as List)
            .map((e) => CollegeListModel.fromJson(e))
            .toList();
        _universityList = university
            .map((e) => MenuItem(e.collegeId.toString(), e.name.toString()))
            .toList();
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  _getAdminList(String id) async {
    try {
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/student/tutor-list/$id/');
      if (response.statusCode == 200) {
        adminList = (response.data as List)
            .map((e) => AdminListModel.fromJson(e))
            .toList();
        _adminList = adminList
            .map((e) => MenuItem(e.staffId.toString(), e.name.toString()))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      } else {}
    } on DioException catch (_) {}
  }

  _profileUpdate() async {
    try {
      _submitting.value = true;
      final club = {
        "register_no": _textController[0].text.trim(),
        "tutor": selectedAdminID,
      };

      final response = await dioClient.dio.put(
        '${Env().apiBaseUrl}home/student/manage-profile/',
        data: club,
      );
      if (response.statusCode == 200) {
        pref.token.value = pref.token.value.copyWith(
          isProfileCreated: true,
        );
        tokenCubit.updateToken(pref.token.value);
        appRouter.go(ScreenPath.explore);
        _submitting.value = false;
      } else {
        _submitting.value = false;
      }
    } on DioException catch (_) {
      _submitting.value = false;
    }
  }

  String selectedUId = '';

  String selectedAdminID = '';

  @override
  void initState() {
    super.initState();
    _getCollegeList();
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
                            'Complete\nStudent Profile',
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
                        hintText: 'College',
                        menu: _universityList,
                        onSelect: (s) {
                          _getAdminList(s?.id.toString() ?? 'd');
                          selectedUId = s?.id ?? 'ds';
                        },
                        validator: (email) {
                          if (_textController.isItemEmpty(6)) {
                            return "* Required";
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: CustomDropDownSearch(
                        controller: _textController[5],
                        hintText: 'Tutor',
                        menu: _adminList,
                        onSelect: (s) {
                          selectedAdminID = s?.id.toString() ?? 'fg';
                        },
                        validator: (email) {
                          if (_textController.isItemEmpty(5)) {
                            return "* Required";
                          }

                          return null;
                        },
                      ),
                    ),
                    CustomTextField(
                      hint: 'University Number',
                      controller: _textController[0],
                      validator: (email) {
                        if (_textController.isItemEmpty(0)) {
                          return "* Required";
                        }

                        return null;
                      },
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
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
