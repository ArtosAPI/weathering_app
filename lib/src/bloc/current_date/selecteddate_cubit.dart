import 'package:bloc/bloc.dart';

class SelecteddateCubit extends Cubit<DateTime> {
  SelecteddateCubit() : super(DateTime.now());

  void selectDate(DateTime selectedDate) => emit(selectedDate);
}
