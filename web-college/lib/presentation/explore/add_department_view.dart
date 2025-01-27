import 'package:app/domain/explorer/department_list_model/department_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);

List<DepartmentListModel> _departmentListModel = [];

class AddDepartmentView extends StatefulWidget {
  const AddDepartmentView({super.key});

  @override
  State<AddDepartmentView> createState() => _AddDepartmentViewState();
}

class _AddDepartmentViewState extends State<AddDepartmentView> {
  _fetchDepartmentList() async {
    try {
      if (_departmentListModel.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/department-list/');
      if (response.statusCode == 200) {
        _departmentListModel = (response.data as List)
            .map((e) => DepartmentListModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  _refreshDepartmentList() async {
    try {
      

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/college/department-list/');
      if (response.statusCode == 200) {
        _departmentListModel = (response.data as List)
            .map((e) => DepartmentListModel.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
       
      }
    } on DioException catch (_) {
      
    }
  }

  _addDepartment(BuildContext ctx) async {
    try {
      final response = await dioClient.dio.post(
        '${Env().apiBaseUrl}home/college/add-department/',
        data: {
          'name': _deptAddController[0].text.toTitleCase(),
          'short_name': _deptAddController[1].text.toTitleCase(),
          'strength': _deptAddController[2].text.trim(),
        }
      );
      if (response.statusCode == 201) {
        if (ctx.mounted) {
          ctx.pop();
          await _refreshDepartmentList();
          if (ctx.mounted) {
            ctx.showCustomSnackBar(
                'Department added successfully', Colors.green);
          }
        }
      }
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Failed to add department', Colors.red);
      }
      _isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDepartmentList();
  }

  List<TextEditingController> _deptAddController = [];

  final _formKey = generateFormKey();

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
                txt: 'Add Department',
                fontSize: 20,
              ),
              CustomCircleBtn(
                icon: Icons.add,
                onTap: () {
                  _deptAddController =
                      List.generate(3, (index) => generateTextController());
                  customAlertBox(
                    context,
                    title: 'Add Department',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Add Department API
                        _addDepartment(context);
                      }
                    },
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: inset.sm,
                        children: [
                          CustomTextField(
                            hint: 'Department Name',
                            controller: _deptAddController[0],
                            validator: (p0) {
                              if (_deptAddController.isItemEmpty(0)) {
                                return '* Required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hint: 'Short Name',
                            controller: _deptAddController[1],
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (p0) {
                              if (_deptAddController.isItemEmpty(1)) {
                                return '* Required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            hint: 'Strength',
                            controller: _deptAddController[2],
                            validator: (p0) {
                              if (_deptAddController.isItemEmpty(2)) {
                                return '* Required';
                              }
                              if (!isInt(_deptAddController[2].text.trim())) {
                                return 'Enter a valid number';
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
                    CircularProgressIndicator(),
                  ],
                );
              }
              if (_departmentListModel.isEmpty) {
                return const Center(child: CustomText(txt: 'No data found'));
              }

              return ListView.separated(
                itemCount: _departmentListModel.length,
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
                          txt: _departmentListModel[index].name ?? 'N/A',
                          color: context.theme.indigo,
                        ),
                        rowTitleText('Strength',
                            _departmentListModel[index].strength.toString()),
                        rowTitleText('Short Name',
                            _departmentListModel[index].shortName ?? 'N/A'),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
