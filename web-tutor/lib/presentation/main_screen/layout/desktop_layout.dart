import 'package:app/presentation/main_screen/main_screen.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.indigoLight,
      body: child,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: tabChangeNotifier,
          builder: (context, index, _) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              onTap: (value) {
                tabChangeNotifier.value = value;
                switch(value){
                  case 0:
                  return context.go(ScreenPath.explore);
                  case 1:
                  return context.go(ScreenPath.confirmation);
                  default:
                  return context.go(ScreenPath.profile);
                }
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Verification',
                  icon: Icon(
                    Icons.verified_outlined,
                    
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Confirmation',
                  icon: Icon(
                    Icons.check_box_outlined,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(
                    Icons.account_circle_outlined,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
