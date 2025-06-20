import 'dart:async';
import 'package:booklub/ui/core/splash_animations/splash_animation_screen.dart';
import 'package:flutter/material.dart';

class SplashWrapper extends StatefulWidget {
  final Widget child;
  const SplashWrapper({required this.child, super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash ? const SplashScreen() : widget.child;
  }
}
