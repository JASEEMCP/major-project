import 'package:app/domain/explorer/recent_event_list_model/recent_event_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier _isLoading = ValueNotifier(false);

List<RecentEventListModel> _studentList = [];

class MyEventView extends StatefulWidget {
  const MyEventView({super.key});

  @override
  State<MyEventView> createState() => _MyEventViewState();
}

class _MyEventViewState extends State<MyEventView> {
  _getStudentList() async {
    try {
      if (_studentList.isNotEmpty) return;
      _isLoading.value = true;

      final res = await dioClient.dio.get(
          "${Env().apiBaseUrl}home/student/event/list/?event_type=history");
      if (res.statusCode == 200) {
        _studentList = (res.data as List)
            .map((e) => RecentEventListModel.fromJson(e))
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
      final res = await dioClient.dio.get(
          "${Env().apiBaseUrl}home/student/recent-event/list/?event_type=history");
      if (res.statusCode == 200) {
        _studentList = (res.data as List)
            .map((e) => RecentEventListModel.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      } else {}
    } on DioException catch (_) {}
  }

  //final ValueNotifier _isVerifying = ValueNotifier(false);

  // _verify(BuildContext ctx, String id) async {
  //   try {
  //     _isVerifying.value = true;

  //     final res = await dioClient.dio
  //         .put("${Env().apiBaseUrl}home/tutor/verify-students/", data: {
  //       'student_id': id,
  //     });
  //     if (res.statusCode == 200) {
  //       await _refresh();

  //       if (ctx.mounted) {
  //         ctx.showCustomSnackBar('Verification Success', Colors.green);
  //       }
  //       _isVerifying.value = false;
  //     } else {
  //       _isVerifying.value = false;
  //     }
  //   } on DioException catch (_) {
  //     _isVerifying.value = false;
  //     if (ctx.mounted) {
  //       ctx.showCustomSnackBar('Verification Failed', Colors.red);
  //     }
  //   }
  // }

  //int currentIndex = -1;

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
        centerTitle: false,
        title: const CustomText(
          txt: 'History',
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
          return RefreshIndicator(
            onRefresh: () async => await _refresh(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _studentList.length,
              padding: EdgeInsets.all(inset.xs),
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    context.go(
                        ScreenPath.detail(_studentList[index].eventId ?? 'df'));
                  },
                  tileColor: context.theme.kWhite,
                  title: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          txt: _studentList[index].eventName ?? 'N/A',
                          color: context.theme.indigo,
                        ),
                      ),
                      CustomText(
                        txt: _studentList[index].eventPostDate ?? 'N/A',
                        color: context.theme.indigo,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(inset.sm),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: inset.xxs,
                    children: [
                      rowTitleText(
                          'Fee', _studentList[index].eventFee.toString()),
                      rowTitleText(
                          'Slot', _studentList[index].eventSlotCount.toString())
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
