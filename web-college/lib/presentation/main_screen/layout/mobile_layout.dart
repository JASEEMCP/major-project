import 'package:app/domain/explorer/college_detail_model/event_list.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/main.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final ValueNotifier _isLoading = ValueNotifier(false);

List<EventList> _eventList = [];

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() =>
      _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  _getEventList() async {
    try {
      if (_eventList.isNotEmpty) return;
      _isLoading.value = true;

      final res = await dioClient.dio
          .get("${Env().apiBaseUrl}home/tutor/unconfirmed-events/");
      if (res.statusCode == 200) {
        _eventList = (res.data as List)
            .map((e) => EventList.fromJson(e))
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
          .get("${Env().apiBaseUrl}home/tutor/unconfirmed-events/");
      if (res.statusCode == 200) {
        _eventList = (res.data as List)
            .map((e) => EventList.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      } else {}
    } on DioException catch (_) {}
  }

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
          txt: 'Mark Attendance',
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
          return RefreshIndicator(
            onRefresh: () async {
              await _refresh();
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _eventList.length,
              padding: EdgeInsets.symmetric(horizontal: inset.sm),
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    // AppRouter.rootKey.currentState?.push(
                    //   CupertinoPageRoute(
                    //     builder: (ctx) => StudentDetailScreen(
                    //       id: _eventList[index].eventId ?? '',
                    //     ),
                    //   ),
                    // );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        txt: _eventList[index].eventName ?? 'N/A',
                        color: context.theme.indigo,
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
                        txt: _eventList[index].date ?? 'N/A',
                        fontSize: 10,
                      ),
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
