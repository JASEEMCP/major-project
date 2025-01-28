import 'package:app/domain/explorer/my_event_list/my_event_list.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
List<MyEventList> _myEventsList = [];

refreshList() async {
  try {
    final response = await dioClient.dio
        .get('${Env().apiBaseUrl}home/admin/my-events-list/');
    if (response.statusCode == 200) {
      _myEventsList =
          (response.data as List).map((e) => MyEventList.fromJson(e)).toList();
      _isLoading.value = true;
      _isLoading.value = false;
    }
  } on DioException catch (_) {
    _isLoading.value = true;
    _isLoading.value = false;
  }
}

class HostEventView extends StatefulWidget {
  const HostEventView({super.key});

  @override
  State<HostEventView> createState() => _HostEventViewState();
}

class _HostEventViewState extends State<HostEventView> {
  _fetchMyEventList() async {
    try {
      if (_myEventsList.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/my-events-list/');
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
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_myEventsList.isEmpty) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      txt: 'My Events',
                      fontSize: 20,
                    ),
                    CustomCircleBtn(
                      iconColor: Colors.green,
                      icon: Icons.add,
                      onTap: () {
                        context.go(ScreenPath.createEvent());
                      },
                    )
                  ],
                ),
                Gap(inset.sm),
                Container(
                  width: double.maxFinite,
                  color: context.theme.indigoLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                        itemCount: _myEventsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Gap(inset.xs),
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(inset.sm),
                            decoration: applyBorderRadius(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  spacing: inset.xs,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      txt: _myEventsList[index].eventName ??
                                          'N/A',
                                      color: context.theme.indigo,
                                    ),
                                    rowTitleText(
                                      'Category',
                                      _myEventsList[index].category ?? 'N/A',
                                    )
                                  ],
                                ),
                                rowTitleText(
                                  'Date',
                                  _myEventsList[index].eventDate ?? 'N/A',
                                ),
                                rowTitleText('Fee',
                                    "INR ${_myEventsList[index].eventFee ?? 'N/A'}"),
                                rowTitleText(
                                  'Credit',
                                  _myEventsList[index].credit.toString(),
                                ),
                                CustomButton(
                                  width: 80,
                                  name: 'View',
                                  radius: 30,
                                  onTap: () {
                                    context.go(ScreenPath.detail(
                                      _myEventsList[index].eventId ?? 'N/A',
                                    ));
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

BoxDecoration applyBorderRadius(BuildContext context) {
  return BoxDecoration(
    color: context.theme.kWhite,
    borderRadius: BorderRadius.circular(10),
  );
}
