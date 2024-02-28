import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
      ),
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('images/Group 1.png')),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 134, 185, 253),
                  Color.fromARGB(255, 214, 226, 249),
                ])),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: SafeArea(child: Image.asset('images/Group Sun.png'))),
          Stack(
            children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.bottomRight,
                  child: Image.asset('images/Vector.png')),
              const Positioned(
                top: 70,
                left: 20,
                child: Text(
                  'Never get caught\nin the rain again',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
                ),
              ),
              const Positioned(
                top: 170,
                left: 20,
                child: Text(
                  'Stay ahead of the weather with our\naccurate forecasts',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              Positioned(
                  top: 235,
                  right: 75,
                  child: SizedBox(
                    height: 75,
                    width: 175,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Get Started'),
                    ),
                  )),
            ],
          ),
        ]),
      )),
    );
  }
}