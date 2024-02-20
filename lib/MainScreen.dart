import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'widgets/atmos_condition.dart';
import 'widgets/top_bar.dart';
import 'widgets/week_weather.dart';

const TextStyle defTextStyle = TextStyle(
  fontFamily: 'Rubik',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(body: MainPage()));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _dayTime = 'Good morning';

  String _currCityName = '';
  String _currTemp = '';
  String _currWeather = '';
  String _currWindSpeed = '0';
  String _currHumidity = '';
  String _currPressure = '';

  final WeatherFactory wf = WeatherFactory('b2c5701873d4ef4129e96535c72d9c25');
  List<Weather> _weekW = List.empty(growable: true);

  Future fetchWeatherData() async {
    Weather w;
    List<Weather> weekW;

    LocationPermission locationPermission =
        await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition();

    w = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    weekW = await wf.fiveDayForecastByLocation(
        position.latitude, position.longitude);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      _weekW = weekW;

      _currCityName = placemarks[0].locality.toString();
      _currTemp = '${w.temperature!.celsius!.toStringAsFixed(0)}°C';

      _currWeather = w.weatherDescription!;
      _currWeather = _currWeather[0].toUpperCase() +
          _currWeather.replaceFirst(_currWeather[0], '');

      _currWindSpeed = w.windSpeed!.toString();
      _currHumidity = '${w.humidity!}%';
      _currPressure = w.pressure!.toString();
    });
  }

  void dayTime() {
    switch (DateTime.now().hour) {
      case >= 6 && < 12:
        setState(() {
          _dayTime = 'Good morning ';
        });
      case >= 12 && < 18:
        setState(() {
          _dayTime = 'Good day';
        });

      case >= 18 && < 23:
        setState(() {
          _dayTime = 'Good evening';
        });

      case >= 23 || < 5:
        setState(() {
          _dayTime = 'Good night';
        });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    dayTime();
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
              child: TopBar(dayTime: _dayTime),
            ),
            const Gap(45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(children: [
                Text(
                  _currCityName,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  _currTemp,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 96,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                Text(
                  _currWeather,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(40),
                AtmosCondition(
                  currWindSpeed: double.parse(_currWindSpeed),
                  currHumidity: _currHumidity,
                  currPressure: _currPressure,
                ),
                const Gap(25),
                WeekWeather(weekWeather: _weekW),
              ]),
            ),
          ]),
        ]));
  }
}
