import 'package:app/presentation/widget/helper_widget.dart';
import 'package:flutter/material.dart';

class ScreenEventConfirmation extends StatelessWidget {
  const ScreenEventConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          txt: 'Verify Event',
          fontSize: 16,
        ),
      ),
    );
  }
}
