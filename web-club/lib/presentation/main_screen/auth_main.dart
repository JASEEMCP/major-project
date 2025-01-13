import 'package:flutter/material.dart';

class AuthMainScreen extends StatelessWidget {
  const AuthMainScreen({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
