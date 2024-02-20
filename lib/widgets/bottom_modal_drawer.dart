import 'package:flutter/material.dart';

class BottomModalDrawer extends StatelessWidget {
  const BottomModalDrawer({super.key});

  static const _weatherDescriprion =
      'The weather forecast for today is mostly sunny with a mild temperature drop. The high will be around 25°C and the low will be around 19°C. A slight chance of rain is expected in the afternoon';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Details',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          const Placeholder(
            fallbackHeight: 64,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today, 4PM',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '19°C',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image(image: AssetImage('images/WeatherIcon.png')),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 158,
                height: 36,
                child: FilledButton.tonal(
                    style: const ButtonStyle(
                        alignment: Alignment.center,
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        side: MaterialStatePropertyAll(
                          BorderSide(color: Colors.grey),
                        )),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          'Temperature',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image(image: AssetImage('images/temperature.png')),
                      ],
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Placeholder(
            fallbackHeight: 213,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(204, 225, 253, 1),
                    Color.fromRGBO(250, 251, 254, 1),
                  ],
                )),
            child: const Text(_weatherDescriprion),
          ),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }
}
