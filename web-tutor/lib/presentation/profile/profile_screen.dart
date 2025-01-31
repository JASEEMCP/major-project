import 'package:app/domain/explorer/tutor_profile_model/tutor_profile_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier _isLoading = ValueNotifier(false);

TutorProfileModel? _studentList;

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  _getStudentList() async {
    try {
      if (_studentList != null) return;
      _isLoading.value = true;

      final res = await dioClient.dio
          .get("${Env().apiBaseUrl}home/tutor/manage-profile/");
      if (res.statusCode == 200) {
        _studentList = TutorProfileModel.fromJson(res.data);
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getStudentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.indigoLight,
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          txt: 'Profile',
          fontSize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              customAlertBox(
                context,
                title: 'Logout',
                content: 'Do you want to logout?',
                onTap: () {
                  tokenCubit.logoutUser();
                  context.go(ScreenPath.login);
                },
              );
            },
            child: const CustomText(txt: 'LOGOUT'),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_studentList == null) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all($style.insets.xs),
            child: Container(
              padding: EdgeInsets.all($style.insets.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.theme.kWhite,
              ),
              child: Column(
                spacing: $style.insets.xs,
                children: [
                  rowTitleText('Name', _studentList?.name ?? 'N/A'),
                  rowTitleText('Department', _studentList?.department ?? 'N/A'),
                  rowTitleText('Email', _studentList?.email ?? 'N/A'),
                  rowTitleText('Gender', _studentList?.gender ?? 'N/A'),
                  rowTitleText(
                      'Academic Year', _studentList?.academicYear ?? 'N/A'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
