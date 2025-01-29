import 'package:app/presentation/widget/custom_text_field.dart';
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
            Gap(inset.offset),
            Gap(inset.xs),
            Align(
              alignment: const Alignment(-0.1, 0),
              child: Text(
                'Complete\nUniversity Profile',
                textAlign: TextAlign.left,
                style: $style.text.textEB26.copyWith(),
              ),
            ),
            Gap(inset.xs),
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
          ],
        ),
      ),
    );
  }
}
