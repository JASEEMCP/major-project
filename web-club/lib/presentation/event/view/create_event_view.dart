import 'package:app/domain/explorer/category_list_model/category_list_model.dart';
import 'package:app/domain/explorer/event_create_model/event_create_model.dart';
import 'package:app/domain/explorer/event_create_model/sessions.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/presentation/event/host_event_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_search_field.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:dio/dio.dart';
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

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  final ValueNotifier<bool> _isCreating = ValueNotifier(false);

  List<CategoryListModel> _category = [];

  _fetchCategoryList() async {
    try {
      if (_category.isNotEmpty) return;
      _isLoading.value = true;

      final response = await dioClient.dio
          .get('${Env().apiBaseUrl}home/events/category-list/');
      if (response.statusCode == 200) {
        _category = (response.data as List)
            .map((e) => CategoryListModel.fromJson(e))
            .toList();
        categoryMenu = _category
            .map((e) => MenuItem(e.categoryId ?? '', e.categoryName ?? ''))
            .toList();
        _isLoading.value = false;
      }
    } on DioException catch (_) {
      _isLoading.value = false;
    }
  }

  _createEvent(BuildContext ctx) async {
    _isCreating.value = true;
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      EventCreateModel m = EventCreateModel(
        eventName: _textController[0].text.trim(),
        eventPostDate: currentDate,
        eventExpiryDate: _textController[1].text.trim(),
        eventFee: stringToInt(_textController[2].text.trim()),
        eventSlotCount: stringToInt(_textController[3].text.trim()),
        sessionCount: stringToInt(_textController[4].text.trim()),
        category: selectedCategoryId,
        description: _textController[6].text.trim(),
        sessions: _sessionList.value,
      );

      final response = await dioClient.dio.post(
        '${Env().apiBaseUrl}home/club/create-event/',
        data: m.toJson(),
      );
      if (response.statusCode == 201) {
        await refreshList();
        if (ctx.mounted) {
          ctx.showCustomSnackBar('Event Created Successfully!', Colors.green);
          _isCreating.value = false;
          ctx.pop();
        }
      }
    } on DioException catch (_) {
      if (ctx.mounted) {
        ctx.showCustomSnackBar('Unable to create Event', Colors.red);
        _isCreating.value = false;
      }
    }
  }

  List<MenuItem> categoryMenu = [];

  String selectedCategoryId = '';

  @override
  void initState() {
    super.initState();
    _fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_category.isEmpty) {
            return const Center(child: CustomText(txt: 'No data found'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(inset.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CustomCircleBtn(
                      onTap: () {
                        context.pop();
                      },
                    ),
                    Gap(inset.xs),
                    const Expanded(
                      child: CustomText(
                        txt: "Create Event",
                        fontSize: 20,
                      ),
                    ),
                    Gap(inset.sm),
                    ValueListenableBuilder(
                        valueListenable: _isCreating,
                        builder: (context, isCreating, _) {
                          return CustomButton(
                            width: 100,
                            color: Colors.green,
                            name: "Create",
                            onTap: isCreating
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      if (_sessionList.value.isEmpty) {
                                        return context.showCustomSnackBar(
                                            'Add Sessions', Colors.red);
                                      }
                                      _createEvent(context);
                                    }
                                  },
                          );
                        }),
                  ],
                ),
                Gap(inset.sm),
                Form(
                  key: _formKey,
                  child: Wrap(
                    alignment: WrapAlignment.start,
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
                            final newDate =
                                DateFormat('yyyy-MM-dd').format(date);
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
                      SizedBox(
                        width: 280,
                        child: CustomDropDownSearch(
                          width: 280,
                          hintText: "Category",
                          menu: categoryMenu,
                          controller: _textController[5],
                          onSelect: (p0) {
                            selectedCategoryId = p0?.id ?? "";
                          },
                          validator: (p0) {
                            if (p0!.trim().isEmpty) {
                              return '* Required';
                            }
                            return null;
                          },
                        ),
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
                            final newDate =
                                DateFormat('yyyy-MM-dd').format(date);
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
                                    _sessionList.value = [
                                      ..._sessionList.value
                                    ];
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
          );
        });
  }
}
