import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

const TextStyle defTextStyle = TextStyle(
  fontFamily: 'Rubik',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

final String _todayDate =
    '${DateFormat('EEEE').format(DateTime.now())}, ${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(body: MainPage()));
  }
}

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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _wishes = 'Good morning';

  String _currCityName = '';
  String _currTemp = '';
  String _currWeather = '';
  String _currWindSpeed = '';
  String _currHumidity = '';
  String _currPressure = '';

  final WeatherFactory wf = WeatherFactory('b2c5701873d4ef4129e96535c72d9c25');
  Weather? w;

  Future<void> fetchWeatherData() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    Weather w = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    setState(() {
      //TODO: get a city name to display!
      _currCityName = '';
      _currTemp = w.temperature!.celsius!.toStringAsFixed(1);
      _currWeather = w.weatherDescription!;
      _currWindSpeed = w.windSpeed!.toString();
      _currHumidity = w.humidity!.toString();
      _currPressure = w.pressure!.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    switch (DateTime.now().hour) {
      case >= 6 && < 12:
        _wishes = 'Good morning ';
      case >= 12 && < 18:
        _wishes = 'Good day';
      case >= 18 && < 23:
        _wishes = 'Good evening';
      case >= 23 || < 5:
        _wishes = 'Good night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(201, 213, 229, 1), Colors.white])),
      child: Stack(children: [
        Positioned(top: 55, child: Image.asset('images/sky.png')),
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'images/sun.png',
            height: 525,
          ),
        ),
        ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _wishes,
                      style: defTextStyle,
                    ),
                    const Gap(3),
                    Text(
                      _todayDate,
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                IconButton.outlined(
                    icon: const Icon(Icons.menu,
                        color: Color.fromARGB(255, 184, 184, 184)),
                    iconSize: 24,
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(const Size.square(40)),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Color.fromARGB(255, 184, 184, 184))),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const BottomModalDrawer();
                        },
                      );
                    }),
              ],
            ),
          ),
          Container(
            child: Column(children: [Text(_currPressure)]),
          )
        ]),
      ]),
    );
  }
}
