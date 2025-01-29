import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_search_field.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/resource/utils/common_lib.dart';
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

  final _formKey = generateFormKey();

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: inset.sm,
            children: [
              Gap(inset.xs),
              SizedBox(
                width: 280,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Complete\nClub Profile',
                      textAlign: TextAlign.left,
                      style: $style.text.textEB26.copyWith(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 280,
                child: CustomDropDownSearch(
                  controller: _textController[0],
                  hintText: 'College',
                  menu: [
                    MenuItem("id", "COET"),
                    MenuItem("id", "COEK"),
                  ],
                  onSelect: (s) {},
                  validator: (email) {
                    if (_textController.isItemEmpty(0)) {
                      return "* Required";
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 280,
                child: CustomDropDownSearch(
                  controller: _textController[1],
                  hintText: 'Admin',
                  menu: [
                    MenuItem("id", "Rahul"),
                    MenuItem("id", "Umash"),
                    MenuItem("id", "Aided"),
                  ],
                  onSelect: (s) {},
                  validator: (email) {
                    if (_textController.isItemEmpty(1)) {
                      return "* Required";
                    }

                    return null;
                  },
                ),
              ),
              CustomTextField(
                hint: 'Author Name',
                controller: _textController[2],
                validator: (email) {
                  if (_textController.isItemEmpty(2)) {
                    return "* Required";
                  }

                  return null;
                },
              ),
              CustomButton(
                name: "Submit",
                onTap: () {
                  if (_formKey.currentState!.validate()) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
