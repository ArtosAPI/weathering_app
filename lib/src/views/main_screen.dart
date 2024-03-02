import 'package:artums/src/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'widgets/widgets.dart';

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

  //TODO: implement in bloc
  void currentDayTime() {
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

    currentDayTime();
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocProvider(
                create: (context) => WeatherBloc()..add(FetchLocation()),
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is LocationFetched) {
                      context
                          .read<WeatherBloc>()
                          .add(FetchWeather(state.latitude, state.longitude));
                    } else if (state is WeatherFetched) {
                      final weather = state.weather;
                      return Column(children: [
                        Text(
                          weather[0].areaName!,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${weather[0].temperature!.celsius!.round()}°C',
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 96,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        Text(
                          weather[0].weatherDescription!,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(40),
                        AtmosCondition(
                          currWindSpeed: weather[0].windSpeed!,
                          currHumidity: '${weather[0].humidity}%',
                          currPressure: weather[0].pressure.toString(),
                        ),
                        const Gap(25),
                        WeekWeather(weekWeather: weather),
                      ]);
                    }
                    return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()));
                  },
                ),
              ),
            ),
          ]),
        ]));
  }
}
