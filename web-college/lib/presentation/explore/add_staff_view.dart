import 'package:app/domain/explorer/staff_list_model/staff_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_search_field.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);

List<StaffListModel> _staffList = [];

class AddStaffView extends StatefulWidget {
  const AddStaffView({super.key});

  @override
  State<AddStaffView> createState() => _AddStaffViewState();
}

class _AddStaffViewState extends State<AddStaffView> {
  _fetchStaffList() async {
    try {
      if (_staffList.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/staff-list/');
      if (response.statusCode == 200) {
        _staffList = (response.data as List)
            .map((e) => StaffListModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStaffList();
  }

  final _formKey = generateFormKey();

  List<TextEditingController> _staffAddController = [];
  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                txt: 'Add Staff',
                fontSize: 20,
              ),
              CustomCircleBtn(
                icon: Icons.add,
                onTap: () {
                  _staffAddController =
                      List.generate(7, (index) => generateTextController());
                  customAlertBox(
                    context,
                    title: 'Add Staff',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Add Department API
                        //_addDepartment(context);
                      }
                    },
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: inset.sm,
                        children: [
                          CustomTextField(
                            hint: 'Staff Name',
                            controller: _staffAddController[0],
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(0)) {
                                return '* Required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hint: 'Email Address',
                            controller: _staffAddController[1],
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(1)) {
                                return "* Required";
                              }
                              if (_staffAddController.isValidEmailAt(1)) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hint: 'Department',
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(2)) {
                                return '* Required';
                              }
                              return null;
                            },
                          ),
                          CustomDropDownSearch(
                            hintText: 'Gender',
                            enableController: false,
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(3)) {
                                return '* Required';
                              }
                              return null;
                            },
                            onSelect: (p0) {},
                            onChanged: (p0) {},
                            menu: [
                              MenuItem("id", "Male"),
                              MenuItem("id", 'Female'),
                            ],
                          ),
                          CustomTextField(
                            hint: 'Password',
                            controller: _staffAddController[4],
                            validator: (p0) {
                              if (p0!.trim().isEmpty) {
                                return '* Required';
                              }
                              if (_staffAddController.isValidPasswordAt(4)) {
                                return '* Password must be at least 8 characters long and include a number and a special character';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hint: 'Academic Start Date',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            controller: _staffAddController[5],
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(5)) {
                                return '* Required';
                              }
                              if (!isInt(_staffAddController[5].text.trim())) {
                                return 'Enter a valid Year';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hint: 'Academic End Date',
                            controller: _staffAddController[6],
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(6)) {
                                return '* Required';
                              }
                              if (!isInt(_staffAddController[6].text.trim())) {
                                return 'Enter a valid Year';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Gap(inset.md),
          ValueListenableBuilder(
              valueListenable: _isLoading,
              builder: (context, isLoading, _) {
                if (isLoading) {
                  return const Column(
                    children: [
                      Gap(200),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
                if (_staffList.isEmpty) {
                  return const Center(child: CustomText(txt: 'No Staff Found'));
                }

                return ListView.separated(
                  itemCount: _staffList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(inset.xs),
                  itemBuilder: (ctx, index) {
                    return Container(
                      padding: EdgeInsets.all(inset.sm),
                      decoration: applyBorderRadius(context),
                      child: Column(
                        spacing: inset.xs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            txt: _staffList[index].name ?? 'N/A',
                            color: context.theme.indigo,
                          ),
                          rowTitleText(
                              'Email', _staffList[index].email ?? 'N/A'),
                          rowTitleText('Department',
                              _staffList[index].department ?? 'N/A'),
                          rowTitleText(
                              'Gender', _staffList[index].gender ?? 'N/A'),
                          rowTitleText('Academic Year',
                              _staffList[index].academicYear ?? 'N/A'),
                          if ((_staffList[index].isAdmin ?? false) ||
                              (_staffList[index].isTutor ?? false))
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                Gap(inset.xs),
                                CustomText(
                                  txt:
                                      'Role: ${(_staffList[index].isAdmin ?? false) ? 'Admin' : (_staffList[index].isTutor ?? false) ? 'Tutor' : ''}',
                                  color: context.theme.indigo,
                                ),
                              ],
                            )
                        ],
                      ),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
