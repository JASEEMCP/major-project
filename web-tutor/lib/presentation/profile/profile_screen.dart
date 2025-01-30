import 'package:app/presentation/widget/helper_widget.dart';
import 'package:app/resource/utils/common_lib.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          txt: 'Profile',
          fontSize: 16,
        ),
        actions: [
          TextButton(
            onPressed: () {
              customAlertBox(
                context,
                title: 'Logout',
                content: 'Do you want to logout?',
                onTap: () {
                  tokenCubit.logoutUser();
                  context.go(ScreenPath.login);
                },
              );
            },
            child: const CustomText(txt: 'LOGOUT'),
          ),
        ],
      ),
    );
  }
}
