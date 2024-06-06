import 'package:artums/src/bloc/char_data/char_data_cubit.dart';
import 'package:artums/src/bloc/current_date/selecteddate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/weather.dart';
import '/src/constants.dart';

class BottomModalDrawer extends StatelessWidget {
  const BottomModalDrawer({super.key, required this.weather});
  final List<Weather> weather;

  String weatherConditionEmoji(int? weatherCondCode) {
    if (weatherCondCode != null) {
      switch (weatherCondCode) {
        case >= 200 && < 300:
          return weatherConditionEmojis[7];
        case >= 300 && < 400:
          return weatherConditionEmojis[1];
        case >= 500 && < 600:
          return weatherConditionEmojis[1];
        case >= 600 && < 700:
          return weatherConditionEmojis[5];
        case >= 700 && < 800:
          return weatherConditionEmojis[4];
        case == 800:
          return weatherConditionEmojis[6];
        case == 801:
          return weatherConditionEmojis[3];
        case >= 802:
          return weatherConditionEmojis[4];

        default:
          return weatherConditionEmojis[6];
      }
    } else {
      return weatherConditionEmojis[6];
    }
  }

  int selectedDateWeather(int day, int hour) {
    day -= DateTime.now().day - 1;

    switch (day) {
      case 1:
        return 0 + (hour ~/ 3);
      case 2:
        return 7 + (hour ~/ 3);
      case 3:
        return 15 + (hour ~/ 3);
      case 4:
        return 23 + (hour ~/ 3);
      case 5:
        return 31 + (hour ~/ 3);
      case 6:
        return 39;

      default:
        return 0 + (hour ~/ 3);
    }
  }

  Widget chartType(CharDataShown currentCharDataShown) {
    if (currentCharDataShown == CharDataShown.temperature) {
      return TemperatureChart(
        weather: weather,
      );
    } else if (currentCharDataShown == CharDataShown.pressure) {
      return PressureChart(weather: weather);
    } else if (currentCharDataShown == CharDataShown.windSpeed) {
      return WindChart(weather: weather);
    } else {
      return TemperatureChart(
        weather: weather,
      );
    }
  }

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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SelecteddateCubit()),
            BlocProvider(create: (context) => CharDataCubit())
          ],
          child: BlocBuilder<SelecteddateCubit, DateTime>(
            builder: (context, currentDate) {
              Weather curWeather = weather[
                  selectedDateWeather(currentDate.day, currentDate.hour)];
              return BlocBuilder<CharDataCubit, CharDataShown>(
                builder: (context, currentCharDataShown) {
                  return ListView(children: [
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
                    const Gap(16),
                    SfCalendar(
                      timeSlotViewSettings: const TimeSlotViewSettings(
                          timeInterval: Duration(minutes: 240)),
                      view: CalendarView.week,
                      initialDisplayDate: DateTime.now(),
                      firstDayOfWeek: DateTime.now().weekday,
                      viewNavigationMode: ViewNavigationMode.none,
                      onSelectionChanged: (value) {
                        DateTime date = value.date!;
                        context.read<SelecteddateCubit>().selectDate(date);
                      },
                    ),
                    const Divider(),
                    //Future plans may be? :)
                    // const Gap(16),
                    // Container(
                    //   padding: const EdgeInsets.all(12),
                    //   decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(12)),
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topCenter,
                    //         end: Alignment.bottomCenter,
                    //         colors: [
                    //           Color.fromRGBO(204, 225, 253, 1),
                    //           Color.fromRGBO(177, 195, 219, 1),
                    //         ],
                    //       )),
                    //   child: Text(
                    //       '${curWeather.weatherDescription!} with a mild temperature drop. The high will be around 25°C and the low will be around 19°C. A slight chance of rain is expected in the afternoon'),
                    // ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${DateFormat('EEEE').format(currentDate)}, ${DateFormat('j').format(currentDate)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${curWeather.temperature!.celsius!.toStringAsFixed(0)}°C',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  weatherConditionEmoji(
                                      curWeather.weatherConditionCode),
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 158,
                          height: 36,
                          child: Container(
                            constraints:
                                const BoxConstraints(maxHeight: 100, maxWidth: 200),
                            decoration: BoxDecoration(border: Border.all()),
                            child: PopupMenuButton(
                              initialValue: currentCharDataShown,
                              onSelected: (CharDataShown value) {
                                context
                                    .read<CharDataCubit>()
                                    .changeCharData(value);
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                    value: CharDataShown.temperature,
                                    child: Text('Temperature')),
                                PopupMenuItem(
                                    value: CharDataShown.pressure,
                                    child: Text('Pressure')),
                                PopupMenuItem(
                                    value: CharDataShown.windSpeed,
                                    child: Text('Wind Speed')),
                              ],
                              tooltip: '',
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.menu),
                                    Gap(5),
                                    Text('Choose state'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(16),
                    chartType(currentCharDataShown),
                  ]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({super.key, required this.weather});
  final List<Weather> weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(),
          primaryXAxis: const CategoryAxis(),
          series: [
            LineSeries<Weather, String>(
                dataSource: [
                  weather[0],
                  weather[8],
                  weather[16],
                  weather[24],
                  weather[32],
                ],
                xValueMapper: (value, _) => DateFormat.E().format(value.date!),
                yValueMapper: (value, _) {
                  return value.temperature!.celsius;
                })
          ]),
    );
  }
}

class PressureChart extends StatelessWidget {
  const PressureChart({super.key, required this.weather});
  final List<Weather> weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(),
          primaryXAxis: const CategoryAxis(),
          series: [
            LineSeries<Weather, String>(
                dataSource: [
                  weather[0],
                  weather[8],
                  weather[16],
                  weather[24],
                  weather[32],
                ],
                xValueMapper: (value, _) => DateFormat.E().format(value.date!),
                yValueMapper: (value, _) {
                  return value.pressure;
                })
          ]),
    );
  }
}

class WindChart extends StatelessWidget {
  const WindChart({super.key, required this.weather});
  final List<Weather> weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(),
          primaryXAxis: const CategoryAxis(),
          series: [
            LineSeries<Weather, String>(
                dataSource: [
                  weather[0],
                  weather[8],
                  weather[16],
                  weather[24],
                  weather[32],
                ],
                xValueMapper: (value, _) => DateFormat.E().format(value.date!),
                yValueMapper: (value, _) {
                  return value.windSpeed;
                })
          ]),
    );
  }
}
