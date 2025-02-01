import 'package:app/domain/explorer/event_detail_model/event_detail_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_search_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

class EventDetailScreen extends StatefulWidget {
  final String id;
  const EventDetailScreen({super.key, required this.id});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final ValueNotifier _isLoading = ValueNotifier(false);

  EventDetailModel? _model;

  _getEventDetail() async {
    try {
      if (_model != null) return;
      _isLoading.value = true;

      final res = await dioClient.dio.get(
          "${Env().apiBaseUrl}home/student/recent-event-detail/${widget.id}/");
      if (res.statusCode == 200) {
        _model = EventDetailModel.fromJson(res.data);
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
          "${Env().apiBaseUrl}home/student/recent-event-detail/${widget.id}/");
      if (res.statusCode == 200) {
        _model = EventDetailModel.fromJson(res.data);
        _isLoading.value = true;
        _isLoading.value = false;
      } else {
        _isLoading.value = true;
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = true;
      _isLoading.value = false;
    }
  }

  _registerEvent(BuildContext ctx) async {
    try {
      final res = await dioClient.dio.post(
        "${Env().apiBaseUrl}home/student/register-event/",
        data: {
          'event_id': _model?.eventId,
          'semester': _textController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        await _refresh();
        if (ctx.mounted) {
          ctx.pop();

          ctx.showCustomSnackBar('Registration Successful', Colors.green);
        }
      } else {}
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Registration Failed', Colors.red);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getEventDetail();
  }

  final _formKey = generateFormKey();
  final _textController = generateTextController();

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    print(_model?.isRegistered);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(txt: 'Event Detail'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_model == null) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txt: _model?.eventName ?? 'N/A',
                  fontSize: 20,
                  color: context.theme.indigo,
                ),
                Gap(inset.sm),
                Container(
                  padding: EdgeInsets.all($style.insets.sm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.theme.kWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: $style.insets.xs,
                    children: [
                      CustomText(
                        txt: _model?.description ?? 'N/A',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      rowTitleText('Event Date', _model?.eventDate ?? 'N/A'),
                      rowTitleText('Category', _model?.category ?? 'N/A'),
                      rowTitleText('Authority', _model?.authority ?? 'N/A'),
                      rowTitleText(
                          'Credit', _model?.credit.toString() ?? 'N/A'),
                      rowTitleText('Fee', "INR ${_model?.eventFee}"),
                    ],
                  ),
                ),
                Gap(inset.sm),
                if ((_model?.sessions ?? []).isNotEmpty)
                  CustomText(
                    txt: 'Event Session',
                    color: context.theme.indigo,
                    fontSize: 20,
                  ),
                Gap(inset.sm),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _model?.sessions?.length ?? 0,
                  separatorBuilder: (context, index) => Gap(inset.xs),
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      tileColor: context.theme.kWhite,
                      title: CustomText(
                        txt: "Session ${index + 1}",
                        color: context.theme.indigo,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // ,
                      contentPadding: EdgeInsets.all(inset.sm),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: inset.xxs,
                        children: [
                          CustomText(
                            fontSize: 12,
                            txt:
                                "Time : ${_model?.sessions?[index].time ?? 'N/A'}",
                          ),
                          CustomText(
                            txt:
                                "Venue : ${_model?.sessions?[index].venue ?? 'N/A'}",
                            fontSize: 12,
                          ),
                          CustomText(
                            txt:
                                "Faculty Name : ${_model?.sessions?[index].facultyName}",
                            fontSize: 12,
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, _) {
          if (value || _model == null) {
            return const SizedBox.shrink();
          }
          if (_model?.isRegistered ?? false) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: EdgeInsets.all(inset.sm),
            child: CustomButton(
              onTap: () {
                customAlertBox(
                  context,
                  title: 'Register Event',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,
                        child: CustomDropDownSearch(
                          validator: (p0) {
                            if(p0!.trim().isEmpty){
                              return '* Required';
                            }
                            return null;
                          },
                          controller: _textController,
                          hintText: 'Select Semester',
                          menu: [
                            for (int i = 0; i < 8; i++)
                              MenuItem('id', 'Semester ${i + 1}'),
                          ],
                          onSelect: (s) {},
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    if(_formKey.currentState!.validate()){
                    _registerEvent(context);
                    }
                  },
                );
              },
              name: 'Register Now',
            ),
          );
        },
      ),
    );
  }
}
