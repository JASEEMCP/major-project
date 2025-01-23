import 'package:app/presentation/main_screen/main_screen.dart';
import 'package:app/resource/utils/common_lib.dart';
import 'package:app/resource/utils/extensions.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
      ),
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
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Event',
                  icon: Icon(
                    Icons.event,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'History',
                  icon: Icon(
                    Icons.history,
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
