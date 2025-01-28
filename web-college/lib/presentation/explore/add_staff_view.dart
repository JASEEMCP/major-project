import 'package:app/domain/explorer/department_list_model/department_list_model.dart';
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

List<DepartmentListModel> _departmentListModel = [];

class AddStaffView extends StatefulWidget {
  const AddStaffView({super.key});

  @override
  State<AddStaffView> createState() => _AddStaffViewState();
}

class _AddStaffViewState extends State<AddStaffView> {
  List<MenuItem> _deptMenu = [];

  _fetchDepartmentList() async {
    try {
      
      if (_departmentListModel.isNotEmpty)return;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/department-list/');
      if (response.statusCode == 200) {
        _departmentListModel = (response.data as List)
            .map((e) => DepartmentListModel.fromJson(e))
            .toList();

        _deptMenu = _departmentListModel
            .map((e) => MenuItem(e.departmentId.toString(), e.name.toString()))
            .toList();
      }
    } on DioException catch (_) {}
  }

  _fetchStaffList() async {
    try {
      if (_staffList.isNotEmpty) {
        _deptMenu = _departmentListModel
            .map((e) => MenuItem(e.departmentId.toString(), e.name.toString()))
            .toList();
            return;
      }
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/staff-list/');
      await _fetchDepartmentList();
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

  _refreshStaffList() async {
    try {
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/staff-list/');
      await _fetchDepartmentList();
      if (response.statusCode == 200) {
        _staffList = (response.data as List)
            .map((e) => StaffListModel.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      }
    } on DioException catch (_) {}
  }

  _addStaff(BuildContext ctx) async {
    try {
      final response = await dioClient.dio
          .post('${Env().apiBaseUrl}home/college/add-staff/', data: {
        'name': _staffAddController[0].text.toTitleCase(),
        'email': _staffAddController[1].text.trim(),
        'department': selectedMenuId,
        'gender': _staffAddController[3].text.trim(),
        'password': _staffAddController[4].text.trim(),
        'is_tutor': _selectedRole.value == 'Tutor',
        'is_admin': _selectedRole.value == 'Admin',
        'academic_start_year': handleNullString(_staffAddController[5]),
        'academic_end_year': handleNullString(_staffAddController[6])
      });
      if (response.statusCode == 201) {
        if (ctx.mounted) {
          ctx.pop();
          await _refreshStaffList();
          if (ctx.mounted) {
            ctx.showCustomSnackBar('Staff added successfully', Colors.green);
          }
        }
      }
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Failed to add Staff', Colors.red);
      }
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

  final ValueNotifier<String> _selectedRole = ValueNotifier('some');

  String selectedMenuId = '';

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
                        _addStaff(context);
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
                          CustomDropDownSearch(
                            menu: _deptMenu,
                            controller: _staffAddController[2],
                            onSelect: (mm) {
                              selectedMenuId = mm?.id ?? '';
                            },
                            hintText: 'Department',
                            validator: (p0) {
                              if (_staffAddController.isItemEmpty(2)) {
                                return '* Required';
                              }
                              return null;
                            },
                          ),
                          CustomDropDownSearch(
                            hintText: 'Gender',
                            controller: _staffAddController[3],
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
                          ValueListenableBuilder(
                            valueListenable: _selectedRole,
                            builder: (context, selectedRole, _) {
                              return Column(
                                children: [
                                  RadioListTile(
                                    value: selectedRole,
                                    groupValue: 'Admin',
                                    title: const CustomText(txt: 'Admin'),
                                    contentPadding: EdgeInsets.zero,
                                    onChanged: (s) {
                                      _selectedRole.value = 'Admin';
                                    },
                                  ),
                                  RadioListTile(
                                    value: selectedRole,
                                    groupValue: 'Tutor',
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const CustomText(txt: 'Tutor'),
                                    onChanged: (s) {
                                      _selectedRole.value = 'Tutor';
                                    },
                                  ),
                                  Gap(inset.sm),
                                  if (selectedRole == 'Tutor')
                                    Column(
                                      spacing: inset.sm,
                                      children: [
                                        CustomTextField(
                                          hint: 'Academic Start Date',
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(4)
                                          ],
                                          controller: _staffAddController[5],
                                          validator: (p0) {
                                            if (_staffAddController
                                                .isItemEmpty(5)) {
                                              return '* Required';
                                            }
                                            if (!isInt(_staffAddController[5]
                                                .text
                                                .trim())) {
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
                                            if (_staffAddController
                                                .isItemEmpty(6)) {
                                              return '* Required';
                                            }
                                            if (!isInt(_staffAddController[6]
                                                .text
                                                .trim())) {
                                              return 'Enter a valid Year';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              );
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
                          if ((_staffList[index].isTutor ?? false))
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
