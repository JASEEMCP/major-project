import 'package:app/domain/explorer/unverified_event_list_model/unverified_event_list_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
List<UnverifiedEventListModel> _myEvent = [];

class EventVerifyView extends StatefulWidget {
  const EventVerifyView({super.key});

  @override
  State<EventVerifyView> createState() => _EventVerifyViewState();
}

class _EventVerifyViewState extends State<EventVerifyView> {
  refreshList() async {
    try {
      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/unverified-events-list/');
      if (response.statusCode == 200) {
        _myEvent = (response.data as List)
            .map((e) => UnverifiedEventListModel.fromJson(e))
            .toList();
        _isLoading.value = true;
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = true;
      _isLoading.value = false;
    }
  }

  _fetchClubList() async {
    try {
      if (_myEvent.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/admin/unverified-events-list/');
      if (response.statusCode == 200) {
        _myEvent = (response.data as List)
            .map((e) => UnverifiedEventListModel.fromJson(e))
            .toList();
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  final ValueNotifier<bool> _isVerifying = ValueNotifier(false);

  _verifyClub(BuildContext ctx, String id) async {
    try {
      //_isVerifying.value = true;
      final response = await dioClient.dio
          .put('${Env().apiBaseUrl}home/admin/unverified-events-list/', data: {
        'event_id': id,
      });
      if (response.statusCode == 200) {
        if (ctx.mounted) {
          ctx.showCustomSnackBar('Verification Successful', Colors.green);
        }
        await refreshList();
        //_isVerifying.value = false;
      }
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Verification Failed', Colors.red);
      }
      //_isVerifying.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClubList();
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
          if (_myEvent.isEmpty) {
            return const Center(
                child: CustomText(txt: 'No Unverified Authority'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  txt: 'Verify Event',
                  fontSize: 20,
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
                        itemCount: _myEvent.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Gap(inset.xs),
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: EdgeInsets.all(inset.sm),
                            decoration: applyBorderRadius(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      txt: "Organizer Detail",
                                      fontSize: 20,
                                      color: context.theme.indigo,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: _isVerifying,
                                      builder: (context, verify, _) {
                                        return CustomButton(
                                          width: 80,
                                          name: 'Verify',
                                          radius: 30,
                                          color: Colors.green,
                                          onTap: () {
                                            _verifyClub(
                                                context,
                                                _myEvent[index].eventId ??
                                                    'N/A');
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                                CustomText(
                                  txt: _myEvent[index]
                                          .authority
                                          ?.authorityName ??
                                      'N/A',
                                  color: Colors.green,
                                ),
                                Gap(inset.xs),

                                rowTitleText(
                                  'Authorizer Name',
                                  _myEvent[index].authority?.authorName ??
                                      'N/A',
                                ),

                                Gap(inset.xs),
                                CustomText(
                                  txt: "Event Detail",
                                  fontSize: 20,
                                  color: context.theme.indigo,
                                ),
                                Gap(inset.xs),
                                rowTitleText('Organizer',
                                    _myEvent[index].eventName ?? 'N/A'),
                                // rowTitleText('Post date', "content"),
                                // rowTitleText('Expire Date', "content"),
                                //rowTitleText('Slot Available', "content"),
                                rowTitleText(
                                    'Fee', _myEvent[index].eventFee.toString()),
                                rowTitleText(
                                    'Credit Score',
                                    _myEvent[index]
                                            .category
                                            ?.credits
                                            .toString() ??
                                        'N/A'),
                                rowTitleText(
                                    'Category',
                                    _myEvent[index].category?.categoryName ??
                                        'N/A'),
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
