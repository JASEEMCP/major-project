import 'package:app/domain/explorer/unverified_event_list_model/unverified_event_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/main.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final ValueNotifier _isLoading = ValueNotifier(false);

List<UnverifiedEventListModel> _eventList = [];

class ScreenEventConfirmation extends StatefulWidget {
  const ScreenEventConfirmation({super.key});

  @override
  State<ScreenEventConfirmation> createState() =>
      _ScreenEventConfirmationState();
}

class _ScreenEventConfirmationState extends State<ScreenEventConfirmation> {
  _getEventList() async {
    try {
      if (_eventList.isNotEmpty) return;
      _isLoading.value = true;

      final res = await dioClient.dio
          .get("${Env().apiBaseUrl}home/tutor/unconfirmed-events/");
      if (res.statusCode == 200) {
        _eventList = (res.data as List)
            .map((e) => UnverifiedEventListModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      } else {
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  // _refresh() async {
  //   try {
  //     final res = await dioClient.dio
  //         .get("${Env().apiBaseUrl}home/tutor/verify-students");
  //     if (res.statusCode == 200) {
  //       _eventList = (res.data as List)
  //           .map((e) => StudentListModel.fromJson(e))
  //           .toList();
  //       _isLoading.value = true;
  //       _isLoading.value = false;
  //     } else {}
  //   } on DioException catch (_) {}
  // }

  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _getEventList();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          txt: 'Verify Event',
          fontSize: 16,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_eventList.isEmpty) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return ListView.separated(
            itemCount: _eventList.length,
            padding: EdgeInsets.symmetric(horizontal: inset.sm),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: _eventList[index].eventName ?? 'N/A',
                      color: context.theme.indigo,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        radius: 8,
                        child: CustomText(
                          txt: _eventList[index]
                              .registeredStudentCount
                              .toString(),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: context.theme.kWhite,
                //contentPadding: EdgeInsets.all(inset.sm),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: inset.xxs,
                  children: [
                    CustomText(
                      txt: _eventList[index].eventPostDate ?? 'N/A',
                      fontSize: 10,
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
