import 'package:app/domain/explorer/event_detail_model/event_detail_model.dart';
import 'package:app/domain/explorer/event_detail_model/session.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/certificate_genarte.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyEventDetailScreen extends StatefulWidget {
  final String id;
  const MyEventDetailScreen({super.key, required this.id});

  @override
  State<MyEventDetailScreen> createState() => _MyEventDetailScreenState();
}

class _MyEventDetailScreenState extends State<MyEventDetailScreen> {
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
        final sessionList = List.generate(
          (_model?.sessions ?? []).length,
          (i) => Session(
            eventSessionId: _model?.sessions?[i].eventSessionId,
            date: _model?.sessions?[i].date,
            time: _model?.sessions?[i].time,
            venue: _model?.sessions?[i].venue,
            isCurrentSession: _model?.sessions?[i].isCurrentSession,
            facultyName: _model?.sessions?[i].facultyName,
            index: i,
          ),
        ).toList();

        _model?.sessions = sessionList;
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

  _confirmDutyLeave(BuildContext ctx, String id) async {
    try {
      final res = await dioClient.dio.put(
        "${Env().apiBaseUrl}home/tutor/confirmed-duty-leave/",
        data: {
          'registration_id': id,
        },
      );
      if (res.statusCode == 200) {
        await _refresh();
        if (ctx.mounted) {
          ctx.pop();

          ctx.showCustomSnackBar('Duty Leave approved', Colors.green);
        }
      } else {}
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Failed to approve', Colors.red);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getEventDetail();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
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
                          if ((_model?.sessions?[index].isCurrentSession ??
                              false))
                            CustomCircleBtn(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      width: 300, // Set a fixed width
                                      child: Padding(
                                        padding: EdgeInsets.all(inset.sm),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // Ensures it takes only necessary height
                                          children: [
                                            const CustomText(
                                              txt: "Session QR",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Gap(inset.sm),
                                            QrImageView(
                                              data: _model?.sessions?[index]
                                                      .eventSessionId ??
                                                  "N/A",
                                              version: QrVersions.auto,
                                              size: 200.0,
                                            ),
                                            Gap(inset.sm),
                                            CustomText(
                                              txt:
                                                  "Scan this QR code for Session ${index + 1}",
                                              fontSize: 14,
                                            ),
                                            Gap(inset.sm),
                                            CustomButton(
                                              name: 'Close',
                                              color: Colors.green,
                                              onTap: () {
                                                context.pop();
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: Icons.qr_code_2,
                            )
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(inset.sm),
        child: CustomButton(
          onTap: () {
            customAlertBox(
              context,
              title: 'Register Event',
              onTap: () {
                CertificateGenerator.generateCertificate(
                    "John Doe", "Flutter Workshop");
              },
            );
          },
          name: 'Register Now',
        ),
      ),
    );
  }
}
