import 'package:bloc/bloc.dart';
import '/src/models/models.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      
    });
  }
}

sealed class WeatherEvent{}

class GetWeatherc extends WeatherEvent{
  final Weather weather;
}

class GetLocation extends WeatherEvent{
  final Location location;

  GetLocation(this.location);
}

sealed class WeatherState{}

