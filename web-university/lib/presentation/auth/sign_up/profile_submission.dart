import 'package:app/domain/explorer/category_list_model/category_list_model.dart';
import 'package:app/presentation/explore/explore_view.dart';
import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';
import 'package:flutter/services.dart';

class ProfileSubmission extends StatefulWidget {
  const ProfileSubmission({super.key});

  @override
  State<ProfileSubmission> createState() => _ProfileSubmissionState();
}

class _ProfileSubmissionState extends State<ProfileSubmission> {
  final List<TextEditingController> _textController = List.generate(
    7,
    (_) => generateTextController(),
  );

  @override
  void initState() {
    super.initState();
  }

  final ValueNotifier<List<CategoryListModel>> _categoryList =
      ValueNotifier([]);

  final _formKey = generateFormKey();
  final _catgoryKey = generateFormKey();

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: inset.xs,
          children: [
            Gap(inset.lg),
            // Align(
            //   alignment: const Alignment(-0.35, 0),
            //   child: Text(
            //     'Complete\nUniversity Profile',
            //     textAlign: TextAlign.left,
            //     style: $style.text.textEB26.copyWith(),
            //   ),
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: inset.sm,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: inset.sm,
                    children: [
                      Text(
                        'Complete\nUniversity Profile',
                        textAlign: TextAlign.left,
                        style: $style.text.textEB26.copyWith(),
                      ),
                      Gap(inset.sm),
                      // CustomTextField(
                      //   readOnly: true,
                      //   hint: 'University Name',
                      //   controller: _textController[0],
                      // ),
                      // CustomTextField(
                      //   readOnly: true,
                      //   hint: 'University email',
                      //   controller: _textController[1],
                      // ),
                      CustomTextField(
                        hint: 'Short Name',
                        controller: _textController[0],
                        validator: (email) {
                          if (_textController.isItemEmpty(0)) {
                            return "* Required";
                          }

                          return null;
                        },
                      ),
                      CustomTextField(
                        hint: 'Phone Number',
                        controller: _textController[1],
                        inputFormatter: [LengthLimitingTextInputFormatter(10)],
                        validator: (email) {
                          if (_textController.isItemEmpty(1)) {
                            return "* Required";
                          }
                          if (_textController.isInvalidPhoneAt(1)) {
                            return "Invalid Phone Number";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        hint: 'Address',
                        controller: _textController[2],
                        validator: (email) {
                          if (_textController.isItemEmpty(2)) {
                            return "* Required";
                          }

                          return null;
                        },
                      ),
                      CustomTextField(
                        hint: 'Website',
                        validator: (email) {
                          if (_textController.isItemEmpty(3)) {
                            return "* Required";
                          }
                          if (!isValidUrl(_textController[3].text.trim())) {
                            return "Invalid URL (eg:https://example.com)";
                          }
                          return null;
                        },
                        controller: _textController[3],
                      ),
                      CustomButton(
                        name: 'Submit',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_categoryList.value.isEmpty) {
                              return context
                                  .showCustomSnackBar('Category Not Empty');
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(100),
                    const CustomText(txt: 'Add Category'),
                    Gap(inset.xxs),
                    Form(
                      key: _catgoryKey,
                      child: SizedBox(
                        width: 280,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              width: 150,
                              hint: 'Category Name',
                              validator: (email) {
                                if (_textController.isItemEmpty(4)) {
                                  return "* Required";
                                }

                                return null;
                              },
                              controller: _textController[4],
                            ),
                            CustomTextField(
                              width: 80,
                              hint: 'Credit',
                              validator: (email) {
                                if (_textController.isItemEmpty(5)) {
                                  return "*Required";
                                }
                                if (!isInt(_textController[5].text.trim())) {
                                  return 'Invalid Input';
                                }

                                return null;
                              },
                              controller: _textController[5],
                            ),
                            CustomCircleBtn(
                              onTap: () {
                                if (_catgoryKey.currentState!.validate()) {
                                  _categoryList.value = [
                                    ..._categoryList.value,
                                    CategoryListModel(
                                      categoryName:
                                          _textController[4].text.trim(),
                                      credits: stringToInt(
                                          _textController[5].text.trim()),
                                    ),
                                  ];

                                  _textController[4].clear();
                                  _textController[5].clear();
                                }
                              },
                              icon: Icons.add,
                              iconColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(inset.xs),
                    SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                          valueListenable: _categoryList,
                          builder: (context, item, _) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: inset.xs,
                              // Wrap in a Column to display multiple items
                              children: item
                                  .map(
                                    (e) => Container(
                                      width: 280,
                                      padding: EdgeInsets.all(inset.xs),
                                      decoration: applyBorderRadius(context),
                                      child: Row(
                                        children: [
                                          Gap(inset.xs),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  txt: e.categoryName ??
                                                      '', // Assuming `Category` has a `name` property
                                                  color: context.theme.indigo,
                                                ),
                                                CustomText(
                                                  txt: e.credits
                                                      .toString(), // Assuming `Category` has a `credit` property
                                                  fontSize: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // Handle item removal
                                              _categoryList.value.remove(e);

                                              _categoryList.value = [
                                                ..._categoryList.value
                                              ];
                                            },
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
