import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Gif(
        image: const AssetImage('assets/images/splash_icon.gif'),
        autostart: Autostart.loop,
        height: 250,
        width: 250,
      )),
    );
  }
}
