import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const api_key = 'b2c5701873d4ef4129e96535c72d9c25';

const List<IconData> weatherIcons = [
  FluentIcons.weather_rain_20_filled,
  FluentIcons.weather_snow_20_filled,
  FluentIcons.weather_drizzle_20_filled,
  FluentIcons.weather_duststorm_20_filled,
  FluentIcons.weather_fog_20_filled,
  FluentIcons.weather_cloudy_20_filled,
  FluentIcons.weather_partly_cloudy_day_16_filled,
  FluentIcons.weather_sunny_20_filled,
  FluentIcons.weather_rain_snow_20_filled,
  FluentIcons.weather_thunderstorm_20_filled,
];

enum WeatherConditions{
  rain,
  snow,
  drizzle,
  duststorm,
  fog,
  cloudy,
  partlyCloudy,
  sunny,
  rainSnow,
  thunderstorm,
}

const TextStyle defTextStyle = TextStyle(
  fontFamily: 'Rubik',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const List<String> weatherConditionEmojis = ['🌦', '🌧', '⛈', '⛅️', '☁️', '🌨', '☀️', '🌩'];