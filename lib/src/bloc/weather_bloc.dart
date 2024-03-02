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
      await Geolocator.getCurrentPosition().then((value) => emit(LocationFetched(value.latitude, value.longitude)));
    });

    on<FetchWeather>((event, emit) async {
      final WeatherFactory wf = WeatherFactory(API_KEY);
      final List<Weather> weather =
          await wf.fiveDayForecastByLocation(event.latitude, event.longitude);
      emit(WeatherFetched(weather));
    });
  }
}
