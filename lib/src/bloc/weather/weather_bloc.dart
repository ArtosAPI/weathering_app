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
      final permission = await Geolocator.checkPermission();
      final locationService = await Geolocator.isLocationServiceEnabled();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(LocationFetchError(
            'Denied location, enable it via settings and then refresh the app.'));
        await Future.delayed(const Duration(seconds: 3));
        await Geolocator.openLocationSettings();
      } else if (!locationService) {
        emit(LocationFetchError(
            'Location is turned off, enable it via settings in the panel and then refresh the app.'));
      } else {
        try {
          await Geolocator.getCurrentPosition(forceAndroidLocationManager: true)
              .then((value) =>
                  emit(LocationFetched(value.latitude, value.longitude)));
        } catch (e) {
          emit(LocationFetchError(e.toString()));
        }
      }
    });

    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      final WeatherFactory wf = WeatherFactory(api_key);
      await wf
          .fiveDayForecastByLocation(event.latitude, event.longitude)
          .then((value) => emit(WeatherFetched(value)));
    });
  }
}
