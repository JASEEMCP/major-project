import 'package:app/domain/explorer/event_detail_model/event_detail_model.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/widget/certificate_genarte.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';

class StudentDetailScreen extends StatefulWidget {
  final String id;
  const StudentDetailScreen({super.key, required this.id});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  final ValueNotifier _isLoading = ValueNotifier(false);

  EventDetailModel? _model;

  _getEventDetail() async {
    try {
      if (_model != null) return;
      _isLoading.value = true;

      final res = await dioClient.dio.get(
          "${Env().apiBaseUrl}home/tutor/unconfirmed-event/detail/${widget.id}/");
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
          "${Env().apiBaseUrl}home/tutor/unconfirmed-event/detail/${widget.id}/");
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
                  if ((_model?.students ?? []).isNotEmpty)
                    CustomText(
                      txt: 'Attended Student',
                      color: context.theme.indigo,
                      fontSize: 20,
                    ),
                  Gap(inset.sm),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _model?.students?.length ?? 0,
                    separatorBuilder: (context, index) => Gap(inset.xs),
                    itemBuilder: (ctx, index) {
                      print(_model?.students?.length);
                      return ListTile(
                        tileColor: context.theme.kWhite,
                        title: CustomText(
                          txt: _model?.students?[index].registerNo ?? 'N/A',
                          color: context.theme.indigo,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            customAlertBox(
                              context,
                              title: 'Approve Duty Leave',
                              content: 'Confirm Duty Leave',
                              onTap: () {
                                _confirmDutyLeave(
                                    context,
                                    _model?.students?[index].registrationId ??
                                        '');
                              },
                            );
                          },
                          child: const CustomText(
                            txt: 'Approve',
                            color: Colors.green,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(inset.sm),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: inset.xxs,
                          children: [
                            CustomText(
                              txt: _model?.students?[index].name ?? 'N/A',
                            ),
                            CustomText(
                              txt:
                                  "Credit :${_model?.students?[index].creditEarned}",
                              fontSize: 12,
                            ),
                            CustomCircleBtn(
                              onTap: () {
                                CertificateGenerator.generateCertificate(
                                  _model?.students?[index].name ?? '',
                                  _model?.eventName ?? 'N/A',
                                );
                              },
                              icon: Icons.print_outlined,
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}
