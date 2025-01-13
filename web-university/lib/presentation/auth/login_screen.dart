import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final _formKey = generateFormKey();
  final List<TextEditingController> _textController = List.generate(
    2,
    (_) => generateTextController(),
  );

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return Scaffold(
      backgroundColor: context.theme.indigoLight.withOpacity(0.5),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(inset.offset),
                Gap(inset.xs),
                Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Text(
                    'Login\nUniversity Profile',
                    textAlign: TextAlign.left,
                    style: $style.text.textEB26.copyWith(),
                  ),
                ),
                Gap(inset.xs),
                CustomTextField(
                  hint: 'University email',
                  validator: (email) {
                    if (_textController.isItemEmpty(0)) {
                      return "* Required";
                    }
                    if (_textController.isValidEmailAt(0)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  controller: _textController[0],
                ),
                Gap(inset.sm),
                CustomTextField(
                  hint: 'Password',
                  controller: _textController[1],
                  validator: (email) {
                    if (_textController.isItemEmpty(0)) {
                      return "* Required";
                    }

                    return null;
                  },
                ),
                Gap(inset.xs),
                Align(
                  alignment: const Alignment(-0.9, 0),
                  child: CustomTextButton(
                    text: 'Forgot Password?',
                    onTap: () {},
                  ),
                ),
                Gap(inset.sm),
                CustomButton(
                  name: 'Login',
                  onTap: () {
                    //if (_formKey.currentState!.validate()) {
                    context.go(ScreenPath.explore);
                    //}
                  },
                ),
                Gap(inset.lg),
                Center(
                  child: CustomTextButton(
                    text: 'Create Account?',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
