import 'package:app/presentation/widget/helper_widget.dart';
import 'package:flutter/material.dart';

class ScreenVerifyStudent extends StatelessWidget {
  const ScreenVerifyStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          txt: 'Verify Student',
          fontSize: 16,
        ),
      ),
    );
  }
}
