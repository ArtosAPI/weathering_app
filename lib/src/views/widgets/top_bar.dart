import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import '/src/constants.dart';
import 'bottom_modal_drawer.dart';

class TopBar extends StatelessWidget {
  TopBar({
    super.key,
    required this.dayTime,
    required this.weather
  });
  
  final String dayTime;
  final List<Weather> weather;

  final String _todayDate =
      '${DateFormat('EEEE').format(DateTime.now())}, ${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayTime,
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
              fixedSize: MaterialStateProperty.all(const Size.square(40)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color.fromARGB(255, 184, 184, 184))),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return BottomModalDrawer(weather: weather,);
                },
              );
            }),
      ],
    );
  }
}
