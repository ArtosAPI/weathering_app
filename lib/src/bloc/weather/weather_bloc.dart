import 'package:artums/src/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {

    on<FetchLocation>((event, emit) async {
      await Geolocator.requestPermission();
      await Geolocator.getCurrentPosition(forceAndroidLocationManager: true).then((value) => emit(LocationFetched(value.latitude, value.longitude)));
    });

    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      final WeatherFactory wf = WeatherFactory(API_KEY);
      await wf.fiveDayForecastByLocation(event.latitude, event.longitude).then((value) => emit(WeatherFetched(value)));
    });
  }
}
