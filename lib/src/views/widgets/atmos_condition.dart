import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class AtmosCondition extends StatelessWidget {
  const AtmosCondition(
      {super.key,
      required this.currWindSpeed,
      required this.currHumidity,
      required this.currPressure});

  final double currWindSpeed;
  final String? currHumidity;
  final String currPressure;

  String windCondition() {
    switch (currWindSpeed * 2.23) {
      case <= 18:
        return 'low';
      case > 18 && <= 46:
        return 'medium';
      case > 46:
        return 'high';

      default:
        return 'low';
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
              icon: Icons.wind_power,
              headline: 'Wind',
              value: RichText(
                  text: TextSpan(
                      text: currWindSpeed.toString(),
                      style: const TextStyle(
                          color: Color.fromRGBO(73, 74, 75, 1),
                          fontFamily: 'Rubik',
                          fontSize: 25),
                      children: [
                    TextSpan(
                      text: windCondition(),
                      style: const TextStyle(
                          color: Color.fromRGBO(73, 74, 75, 1),
                          fontFamily: 'Rubik',
                          fontSize: 12),
                    )
                  ])),
            ),
            AtmosData(
              icon: FluentIcons.weather_fog_20_filled,
              headline: 'Humidity',
              value: RichText(
                  text: TextSpan(
                text: currHumidity,
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
        ));
  }
}

class AtmosData extends StatelessWidget {
  final IconData icon;
  final String headline;
  final RichText value;

  final Color _mainColor = const Color.fromRGBO(142, 142, 142, 1);

  const AtmosData(
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
