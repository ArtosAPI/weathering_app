import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: MainPage()));
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

    // await googleSignIn.signIn();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    debugPrint(placemarks[0].locality);
    setState(() {
      //TODO: get a city name to display!

      _currCityName = placemarks[0].locality.toString();
      _currTemp = '${w.temperature!.celsius!.toStringAsFixed(0)}°C';

      _currWeather = w.weatherDescription!;
      _currWeather = _currWeather[0].toUpperCase() +
          _currWeather.replaceFirst(_currWeather[0], '');

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
            const Gap(45),
            Column(children: [
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
                currWindSpeed: _currWindSpeed,
                currHumidity: _currHumidity,
                currPressure: _currPressure,
              ),

            ]),
          ]),
        ]));
  }
}

class AtmosCondition extends StatelessWidget {
  String currWindSpeed;
  String currHumidity;
  String currPressure;
  AtmosCondition(
      {super.key,
      required this.currWindSpeed,
      required this.currHumidity,
      required this.currPressure});
  String? currWindStrength;

  Future<void> humidityCondition() async{
    switch (double.parse(currWindSpeed) * 2.23) {
      case <= 18:
        currWindStrength = 'low';
      case > 18 && <= 46:
        currWindStrength = 'medium';
      case > 46:
        currWindStrength = 'high';
      default:
        currWindStrength = 'low';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AtmosData(
            icon: Icons.sunny,
            headline: 'Wind',
            value: RichText(
                text: TextSpan(
                    text: currWindSpeed,
                    style: const TextStyle(
                        color: Color.fromRGBO(73, 74, 75, 1),
                        fontFamily: 'Rubik',
                        fontSize: 25),
                    children: [
                  TextSpan(
                    text: currWindStrength,
                    style: const TextStyle(
                        color: Color.fromRGBO(73, 74, 75, 1),
                        fontFamily: 'Rubik',
                        fontSize: 12),
                  )
                ])),
          ),
          AtmosData(
            icon: Icons.sunny,
            headline: 'Humidity',
            value: RichText(
                text: TextSpan(
              text: '$currHumidity%',
              style: const TextStyle(
                  color: Color.fromRGBO(73, 74, 75, 1),
                  fontFamily: 'Rubik',
                  fontSize: 25),
            )),
          ),
          AtmosData(
            icon: Icons.sunny,
            headline: 'Pressure',
            value: RichText(
                text: TextSpan(
                    text: currPressure,
                    style: const TextStyle(
                        color: Color.fromRGBO(73, 74, 75, 1),
                        fontFamily: 'Rubik',
                        fontSize: 25),
                    children: const [
                  TextSpan(
                    text: 'pas',
                    style: TextStyle(
                        color: Color.fromRGBO(73, 74, 75, 1),
                        fontFamily: 'Rubik',
                        fontSize: 12),
                  )
                ])),
          )
        ],
      ),
    );
  }
}

class AtmosData extends StatelessWidget {
  IconData icon;
  String headline;
  RichText value;

  final Color _mainColor = const Color.fromRGBO(142, 142, 142, 1);

  AtmosData(
      {super.key,
      required this.icon,
      required this.headline,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: _mainColor,
          size: 14,
        ),
        Text(
          headline,
          style:
              TextStyle(color: _mainColor, fontFamily: 'Rubik', fontSize: 14),
        ),
        value
      ],
    );
  }
}

class weekWeather extends StatelessWidget {
  const weekWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      width: 400,
      decoration: BoxDecoration(color: const Color.fromRGBO(255, 255, 255, 0.81), borderRadius: BorderRadius.circular(24)),
      child: Placeholder(),
    );
  }
}