import 'package:app/presentation/widget/custom_circle_btn.dart';
import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';

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
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: inset.xs,
          children: [
            Gap(inset.lg),
            Align(
              alignment: const Alignment(-0.58, 0),
              child: Text(
                'Complete\nUniversity Profile',
                textAlign: TextAlign.left,
                style: $style.text.textEB26.copyWith(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: inset.sm,
              children: [
                Column(
                  spacing: inset.sm,
                  children: [
                    Gap(inset.sm),
                    CustomTextField(
                      readOnly: true,
                      hint: 'University Name',
                      controller: _textController[0],
                    ),
                    CustomTextField(
                      readOnly: true,
                      hint: 'University email',
                      controller: _textController[1],
                    ),
                    CustomTextField(
                      readOnly: true,
                      hint: 'Short Name',
                      controller: _textController[2],
                    ),
                    CustomTextField(
                      readOnly: true,
                      hint: 'Phone Number',
                      controller: _textController[3],
                    ),
                    CustomTextField(
                      readOnly: true,
                      hint: 'Address',
                      controller: _textController[4],
                    ),
                    CustomTextField(
                      readOnly: true,
                      hint: 'Website',
                      controller: _textController[5],
                    ),
                    CustomButton(
                      name: 'Submit',
                      onTap: () {},
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(inset.xs),
                    const CustomText(txt: 'Add Category'),
                    Gap(inset.xxs),
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextField(
                            width: 150,
                            readOnly: true,
                            hint: 'Category Name',
                            controller: _textController[5],
                          ),
                          CustomTextField(
                            width: 80,
                            readOnly: true,
                            hint: 'Credit',
                            controller: _textController[5],
                          ),
                          CustomCircleBtn(
                            onTap: () {},
                            icon: Icons.add,
                            iconColor: Colors.green,
                          )
                        ],
                      ),
                    ),
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
