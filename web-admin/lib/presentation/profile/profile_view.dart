import 'package:app/presentation/widget/custom_elevated_button.dart';
import 'package:app/presentation/widget/custom_text_field.dart';
import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = $style.insets;
    return SingleChildScrollView(
      padding: EdgeInsets.all(inset.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            txt: 'My Profile',
            fontSize: 20,
          ),
          Gap(inset.sm),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomTextField(hint: 'User Name'),
              CustomTextField(hint: 'Email Address'),
              CustomTextField(hint: 'Gender'),
              CustomTextField(hint: 'Academic Year'),
              CustomTextField(hint: 'Phone Number'),
            ],
          ),
          Gap(inset.sm),
          const CustomText(
            txt: 'Change Password',
            fontSize: 20,
          ),
          Gap(inset.sm),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomTextField(hint: 'Old Password'),
              CustomTextField(hint: 'New Password'),
              CustomTextField(hint: 'Confirm Password'),
            ],
          ),
          Gap(inset.sm),
          CustomButton(
            name: 'Submit',
            color: Colors.green,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
