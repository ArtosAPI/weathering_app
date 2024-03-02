import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AtmosCondition extends StatefulWidget {
  final double currWindSpeed;
  final String? currHumidity;
  final String currPressure;
  bool isDataFetched = false;

  AtmosCondition(
      {super.key,
      required this.currWindSpeed,
      required this.currHumidity,
      required this.currPressure});

  @override
  State<AtmosCondition> createState() => _AtmosConditionState();
}

class _AtmosConditionState extends State<AtmosCondition> {
  String currWindStrength = 'low';

  void windCondition() {
    switch (widget.currWindSpeed * 2.23) {
      case <= 18:
        setState(() {
          currWindStrength = 'low';
        });
      case > 18 && <= 46:
        setState(() {
          currWindStrength = 'medium';
        });
      case > 46:
        setState(() {
          currWindStrength = 'high';
        });
    }
    widget.isDataFetched = true;
  }

  @override
  void initState() {
    super.initState();

    windCondition();
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
                          text: widget.currWindSpeed.toString(),
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
                    text: widget.currHumidity,
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
                          text: widget.currPressure,
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
            )
    );
  }
}

// ignore: must_be_immutable
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
