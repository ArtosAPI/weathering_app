import 'package:bloc/bloc.dart';

part 'char_data_state.dart';

class CharDataCubit extends Cubit<CharDataShown> {
  CharDataCubit() : super(CharDataShown.pressure);

  void changeCharData(CharDataShown value) => emit(value);
}
