import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';

const TextStyle _defTextStyle = TextStyle(
    color: Color.fromRGBO(142, 142, 142, 1), fontFamily: 'Rubik', fontSize: 14);

class WeekWeather extends StatelessWidget {
  final List<Weather> weekWeather;

  const WeekWeather({super.key, required this.weekWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 600,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.81),
          borderRadius: BorderRadius.circular(24)),
      child: weekWeather.isNotEmpty
          ? Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Next days',
                      style: _defTextStyle,
                    )),
                DailyForecast(
                  dayWeather: weekWeather[0],
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class DailyForecast extends StatelessWidget {
  final Weather dayWeather;

  const DailyForecast({super.key, required this.dayWeather});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundColor: Color.fromRGBO(210, 226, 246, 1),
          child: Icon(Icons.cloud, size: 48, ),
        ),
        const Gap(12),
        Text(
          '${DateFormat('EEEE').format(dayWeather.date!)}, ${dayWeather.date!.day} ${DateFormat('MMMM').format(dayWeather.date!)}',
          style: _defTextStyle,
        ),
      ],
    );
  }
}
