import 'package:app/presentation/main_screen/layout/desktop_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:app/styles/responsive_layout.dart';


ValueNotifier<int> tabChangeNotifier = ValueNotifier<int>(0);

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key, required this.child});

  final Widget child;

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: DesktopLayout(
        child: widget.child,
      ),
      tablet: DesktopLayout(
        child: widget.child,
      ),
      desktop: DesktopLayout(
        child: widget.child,
      ),
    );
  }
}
