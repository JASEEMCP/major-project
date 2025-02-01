import 'package:app/domain/explorer/my_event_list/my_event_list.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/main_screen/qr_sacn_screen.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:app/router/router.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
List<MyEventList> _myEventsList = [];

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  _fetchMyEventList() async {
    try {
      if (_myEventsList.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio.get(
        '${Env().apiBaseUrl}home/club/my-events-list/',
      );
      if (response.statusCode == 200) {
        _myEventsList = (response.data as List)
            .map((e) => MyEventList.fromJson(e))
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
    _fetchMyEventList();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      backgroundColor: context.theme.kWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomText(
          txt: 'Mark Attendance',
          fontSize: 20,
        ),
        actions: [
          TextButton(
            onPressed: () {
              tokenCubit.logoutUser();
              context.go(ScreenPath.login);
            },
            child: const CustomText(
              txt: 'LOGOUT',
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_myEventsList.isEmpty) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return RefreshIndicator(
            onRefresh: () async => _fetchMyEventList(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _myEventsList.length,
              padding: EdgeInsets.all(inset.xs),
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (ctx, index) {
                return ListTile(
                  //onTap: () {},
                  tileColor: context.theme.kWhite,
                  title: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          txt: _myEventsList[index].eventName ?? 'N/A',
                          color: context.theme.indigo,
                          fontSize: 18,
                        ),
                      ),
                      // CustomText(
                      //   txt: _myEventsList[index].eventDate ?? 'N/A',
                      //   color: context.theme.indigo,
                      // ),
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
                      Row(
                        children: [
                          Expanded(
                            child: rowTitleText('Category',
                                _myEventsList[index].category ?? 'N/A'),
                          ),
                          CustomCircleBtn(
                            onTap: () {
                              AppRouter.rootKey.currentState?.push(
                                MaterialPageRoute(
                                  builder: (ctx) => QrScanScreen(
                                    id: _myEventsList[index].eventId ?? '',
                                  ),
                                ),
                              );
                            },
                            icon: Icons.qr_code_scanner,
                          ),
                        ],
                      ),
                      rowTitleText(
                        'Date',
                        _myEventsList[index].eventDate ?? 'N/A',
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
