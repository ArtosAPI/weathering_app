part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class FetchLocation extends WeatherEvent
{
  FetchLocation();
}

class FetchWeather extends WeatherEvent
{
  FetchWeather(this.latitude, this.longitude);
  final double latitude, longitude;
}