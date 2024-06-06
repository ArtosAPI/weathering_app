part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class LocationFetched extends WeatherState {
  LocationFetched(this.latitude, this.longitude);
  final double latitude, longitude;
}

class LocationFetchError extends WeatherState {
  LocationFetchError(this.errorMessage);
  final String errorMessage;

  void openSetting() async {
    await Geolocator.openLocationSettings();
  }
}

class WeatherFetched extends WeatherState {
  WeatherFetched(this.weather);
  final List<Weather> weather;
}

class WeatherLoading extends WeatherState {}

class WeatherFetchError extends WeatherState {}
