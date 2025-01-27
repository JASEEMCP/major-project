import 'package:app/domain/explorer/event_create_model/sessions.dart';
import 'package:app/presentation/event/host_event_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_search_field.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:intl/intl.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final ValueNotifier<List<Sessions>> _sessionList = ValueNotifier([]);

  final List<TextEditingController> _sessionController = List.generate(
    5,
    (_) => generateTextController(),
  );

  final _sessionFormKey = generateFormKey();

  final _formKey = generateFormKey();

  final List<TextEditingController> _textController = List.generate(
    7,
    (_) => generateTextController(),
  );

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Stack(
        children: [
          Column(
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
                    txt: "Create Event",
                    fontSize: 20,
                  ),
                ],
              ),
              Gap(inset.sm),
              Form(
                key: _formKey,
                child: Wrap(
                  spacing: inset.xs,
                  runSpacing: inset.xs,
                  children: [
                    CustomTextField(
                      hint: "Event Name",
                      controller: _textController[0],
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hint: "Expire Date",
                      readOnly: true,
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2026),
                        );
                        if (date != null) {
                          final newDate = DateFormat('yyyy-MM-dd').format(date);
                          _textController[1].text = newDate;
                        }
                      },
                      controller: _textController[1],
                    ),
                    CustomTextField(
                      hint: "Fee",
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        if (!isInt(p0.trim())) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                      controller: _textController[2],
                    ),
                    CustomTextField(
                      hint: "Number of Slot",
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        if (!isInt(p0.trim())) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                      controller: _textController[3],
                    ),
                    CustomTextField(
                      hint: "Session Count",
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        if (!isInt(p0.trim())) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                      controller: _textController[4],
                    ),
                    CustomDropDownSearch(
                      hintText: "Category",
                      menu: [
                        MenuItem("id", "label"),
                      ],
                      controller: _textController[5],
                      onSelect: (p0) {},
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      hint: "Description",
                      maxLine: 5,
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      controller: _textController[6],
                    ),
                  ],
                ),
              ),
              Gap(inset.sm),
              const CustomText(
                txt: "Add Session",
                fontSize: 20,
              ),
              Gap(inset.sm),
              Form(
                key: _sessionFormKey,
                child: Wrap(
                  spacing: inset.xs,
                  runSpacing: inset.xs,
                  children: [
                    CustomTextField(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2026),
                        );
                        if (date != null) {
                          final newDate = DateFormat('yyyy-MM-dd').format(date);
                          _sessionController[0].text = newDate;
                        }
                      },
                      readOnly: true,
                      hint: "Session Date",
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      controller: _sessionController[0],
                    ),
                    CustomTextField(
                      hint: "Start Time",
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          _sessionController[1].text =
                              '${time.hour}:${time.minute}';
                        }
                      },
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      controller: _sessionController[1],
                    ),
                    CustomTextField(
                      hint: "End Time",
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          _sessionController[2].text =
                              '${time.hour}:${time.minute}';
                        }
                      },
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      controller: _sessionController[2],
                    ),
                    CustomTextField(
                      hint: "Faculty Name",
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      controller: _sessionController[3],
                    ),
                    CustomTextField(
                      hint: "Venue",
                      validator: (p0) {
                        if (p0!.trim().isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                      controller: _sessionController[4],
                    ),
                    CustomCircleBtn(
                      icon: Icons.add,
                      iconColor: Colors.green,
                      onTap: () {
                        if (_sessionFormKey.currentState!.validate()) {
                          int? sessionCount =
                              stringToInt(_textController[4].text.trim());

                          if (sessionCount == null) {
                            return context.showCustomSnackBar(
                                'Mark Session Count', Colors.red);
                          }
                          if ((sessionCount) <= _sessionList.value.length) {
                            return context.showCustomSnackBar(
                                'Session Limit Exceed', Colors.red);
                          }
                          _sessionList.value = [
                            ..._sessionList.value,
                            Sessions(
                              date: _sessionController[0].text,
                              eventStartTime: _sessionController[1].text,
                              eventEndTime: _sessionController[2].text,
                              facultyName: _sessionController[3].text,
                              venue: _sessionController[4].text,
                            )
                          ];
                          for (final ctl in _sessionController) {
                            ctl.clear();
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
              Gap(inset.sm),
              ValueListenableBuilder(
                  valueListenable: _sessionList,
                  builder: (context, item, _) {
                    return ListView.separated(
                      itemCount: item.length,
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
                                    txt: item[index].facultyName ?? 'N/A',
                                    color: context.theme.indigo,
                                  ),
                                  rowTitleText(
                                    'Venue',
                                    item[index].venue ?? 'N/A',
                                  ),
                                ],
                              ),
                              rowTitleText(
                                'Date',
                                item[index].date ?? 'N/A',
                              ),
                              rowTitleText(
                                'Time',
                                "${item[index].eventStartTime ?? 'N/A'}-${item[index].eventEndTime ?? 'N/A'}",
                              ),
                              IconButton(
                                onPressed: () {
                                  _sessionList.value.removeAt(index);
                                  _sessionList.value = [..._sessionList.value];
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
          Gap(inset.sm),
          Positioned(
            right: 0,
            top: 0,
            child: CustomButton(
              width: 100,
              color: Colors.green,
              name: "Create",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (_sessionList.value.isEmpty) {
                    return context.showCustomSnackBar(
                        'Add Sessions', Colors.red);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
