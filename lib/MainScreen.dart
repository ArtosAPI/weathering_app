import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

const TextStyle defTextStyle = TextStyle(
  fontFamily: 'Rubik',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffKey = GlobalKey();
  String _goodWHAT = "Good Evening";

  @override
  void initState() {
    switch (DateTime.now().hour) {
      case >= 6 && < 12:
        _goodWHAT = 'Good morning ';
      case >= 12 && < 18:
        _goodWHAT = 'Good day';
      case >= 18 && < 23:
        _goodWHAT = 'Good evening';
      case >= 23 || < 5:
        _goodWHAT = 'Good night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      appBar: TopBar(
        goodWHAT: _goodWHAT,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(218, 226, 237, 1), Colors.white])),
      ),
    );
  }
}

//App bar widget
class TopBar extends StatefulWidget implements PreferredSizeWidget {
  TopBar({
    super.key,
    this.goodWHAT = "Good Evening",
    this.preferredSize = const Size.fromHeight(100), //needed
  });
  String goodWHAT = "";

  @override
  final Size preferredSize; //needed

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String todayDate =
      '${DateFormat('EEEE').format(DateTime.now())}, ${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())}';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: null,
      elevation: 0,
      leadingWidth: 180,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(201, 213, 229, 1), Color.fromRGBO(218, 226, 237, 1)],
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 30, top: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.goodWHAT,
              style: defTextStyle,
            ),
            Text(
              todayDate,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      actions: [
        Column(children: [
          const Gap(18),
          IconButton.outlined(
              icon: const Icon(Icons.menu,
                  color: Color.fromARGB(255, 184, 184, 184)),
              iconSize: 24,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size.square(40)),
                side: MaterialStateProperty.all(const BorderSide(
                    color: Color.fromARGB(255, 184, 184, 184))),
              ),
              onPressed: () {
                // BottomModalDrawer(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const BottomModalDrawer();
                  },
                );
              }),
        ]),
        const Gap(30),
      ],
    );
  }
}

class BottomModalDrawer extends StatelessWidget {
  const BottomModalDrawer({super.key});
  static const TextStyle _defNormalTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w400,
  );
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
