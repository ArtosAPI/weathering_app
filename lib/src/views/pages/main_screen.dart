import 'package:artums/src/bloc/weather/weather_bloc.dart';
import 'package:artums/src/views/pages/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  String currentDayTime() {
    switch (DateTime.now().hour) {
      case >= 6 && < 12:
        return 'Good morning ';
      case >= 12 && < 18:
        return 'Good day';
      case >= 18 && < 23:
        return 'Good evening';
      case >= 23 || < 5:
        return 'Good night';

      default:
        return 'Good day';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherBloc()..add(FetchLocation()),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is LocationFetched) {
              context
                  .read<WeatherBloc>()
                  .add(FetchWeather(state.latitude, state.longitude));
            } else if (state is WeatherFetched) {
              final weather = state.weather;
              return Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromRGBO(201, 213, 229, 1),
                        Colors.white
                      ])),
                  child: Stack(children: [
                    Positioned(
                        top: 55, child: Image.asset('assets/images/sky.png')),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/sun.png',
                        height: 525,
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () {
                        context.read<WeatherBloc>().add(FetchLocation());
                        return Future.delayed(const Duration(seconds: 0));
                      },
                      child: ListView(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 20, right: 20),
                          child: TopBar(
                            dayTime: currentDayTime(),
                            weather: weather,
                          ),
                        ),
                        const Gap(45),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(children: [
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
                            ]))
                      ]),
                    )
                  ]));
            } else if (state is LocationFetchError) {
              return RefreshIndicator(
                onRefresh: () {
                  context.read<WeatherBloc>().add(FetchLocation());
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: ListView(
                  children: [const LoadingScreen(), Text(state.errorMessage, textAlign: TextAlign.center,)],
                ),
              );
            }
            return const LoadingScreen();
          },
        ));
  }
}
