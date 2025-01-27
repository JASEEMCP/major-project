import 'package:app/domain/explorer/event_detail_model/event_detail_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/event/host_event_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({super.key, required this.id});

  final String id;

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  EventDetailModel? _myEvent;

  _fetchEventDetail() async {
    try {
      _isLoading.value = true;

      final response = await dioClient.dio.get(
          '${Env().apiBaseUrl}home/club/get-my-event/detail/${widget.id}/');
      if (response.statusCode == 200) {
        _myEvent = EventDetailModel.fromJson(response.data);

        _isLoading.value = false;
      } else {
        _myEvent = null;
      }
    } on DioException catch (_) {
      _myEvent = null;
      _isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEventDetail();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ValueListenableBuilder(
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
        if (_myEvent == null) {
          return const Center(child: CustomText(txt: 'No data found'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(inset.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomCircleBtn(
                    onTap: () {
                      context.pop();
                    },
                  ),
                  Gap(inset.xs),
                  const CustomText(
                    txt: "Event Detail",
                    fontSize: 20,
                  ),
                ],
              ),
              Gap(inset.sm),
              Container(
                padding: EdgeInsets.all(inset.sm),
                decoration: applyBorderRadius(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: inset.xs,
                  children: [
                    CustomText(
                      txt: _myEvent?.eventName ?? 'N/A',
                      fontSize: 18,
                      color: context.theme.indigo,
                    ),
                    Gap(inset.xs),
                    rowTitleText("Organizer", pref.token.value.name ?? 'N/A'),
                    rowTitleText("Post Date", _myEvent?.eventPostDate ?? 'N/A'),
                    rowTitleText(
                        "Expire Date", _myEvent?.eventExpiryDate ?? 'N/A'),
                    rowTitleText("Slot Available",
                        _myEvent?.eventSlotCount.toString() ?? 'N/A'),
                    rowTitleText("Fee", "INR ${_myEvent?.eventFee ?? 'N/A'}"),
                    rowTitleText("Session Count",
                        _myEvent?.sessionCount.toString() ?? 'N/A'),
                    rowTitleText(
                        "Credit Score", _myEvent?.credit.toString() ?? 'N/A'),
                    rowTitleText("Category", _myEvent?.category ?? 'N/A'),
                    rowTitleText("Description", _myEvent?.description ?? 'N/A'),
                  ],
                ),
              ),
              Gap(inset.sm),
              const CustomText(
                txt: "Registered Students",
                fontSize: 20,
              ),
              Gap(inset.sm),
              ListView.separated(
                itemCount: _myEvent?.students?.length ?? 0,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: inset.xs,
                          children: [
                            CustomText(
                              txt: _myEvent?.students?[index].studentName ??
                                  'N/A',
                              color: context.theme.indigo,
                            ),
                            rowTitleText(
                              'Academic Year',
                              _myEvent?.students?[index].academicYear ?? 'N/A',
                            )
                          ],
                        ),
                        rowTitleText(
                          'Branch',
                          _myEvent?.students?[index].department ?? 'N/A',
                        ),
                        Row(
                          children: [
                            rowTitleText('Attended', ''),
                            (_myEvent?.students?[index].isAttended ?? false)
                                ? const Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
