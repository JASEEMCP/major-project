import 'package:app/domain/explorer/student_list_model/student_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/main.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final ValueNotifier _isLoading = ValueNotifier(false);

List<StudentListModel> _studentList = [];

class ScreenVerifyStudent extends StatefulWidget {
  const ScreenVerifyStudent({super.key});

  @override
  State<ScreenVerifyStudent> createState() => _ScreenVerifyStudentState();
}

class _ScreenVerifyStudentState extends State<ScreenVerifyStudent> {
  _getStudentList() async {
    try {
      if (_studentList.isNotEmpty) return;
      _isLoading.value = true;

      final res = await dioClient.dio
          .get("${Env().apiBaseUrl}home/tutor/verify-students");
      if (res.statusCode == 200) {
        _studentList = (res.data as List)
            .map((e) => StudentListModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  _refresh() async {
    try {
      final res = await dioClient.dio
          .get("${Env().apiBaseUrl}home/tutor/verify-students");
      if (res.statusCode == 200) {
        _studentList = (res.data as List)
            .map((e) => StudentListModel.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      } else {}
    } on DioException catch (_) {}
  }

  final ValueNotifier _isVerifying = ValueNotifier(false);

  _verify(BuildContext ctx, String id) async {
    try {
      _isVerifying.value = true;

      final res = await dioClient.dio
          .put("${Env().apiBaseUrl}home/tutor/verify-students/", data: {
        'student_id': id,
      });
      if (res.statusCode == 200) {
        await _refresh();

        if (ctx.mounted) {
          ctx.showCustomSnackBar('Verification Success', Colors.green);
        }
        _isVerifying.value = false;
      } else {
        _isVerifying.value = false;
      }
    } on DioException catch (_) {
      _isVerifying.value = false;
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Verification Failed', Colors.red);
      }
    }
  }

  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _getStudentList();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.indigoLight,
        centerTitle: false,
        title: const CustomText(
          txt: 'Verify Student',
          fontSize: 20,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_studentList.isEmpty) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return ListView.separated(
            itemCount: _studentList.length,
            padding: EdgeInsets.symmetric(horizontal: inset.sm),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (ctx, index) {
              return ListTile(
                title: CustomText(
                  txt: _studentList[index].registerNo ?? 'N/A',
                  color: context.theme.indigo,
                ),
                trailing: ValueListenableBuilder(
                  valueListenable: _isVerifying,
                  builder: (context, isVerifying, _) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: isVerifying && currentIndex == index
                          ? null
                          : () {
                              currentIndex = index;
                              _verify(
                                  context, _studentList[index].studentId ?? '');
                            },
                      child: const CustomText(
                        txt: 'Verify',
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: inset.xxs,
                  children: [
                    CustomText(
                      txt: _studentList[index].name ?? 'N/A',
                    ),
                    CustomText(
                      txt: _studentList[index].department ?? 'N/A',
                      fontSize: 12,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
