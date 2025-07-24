import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_nav_state.dart'; // navigation_state.dart файлын бул жерге импорттоңуз

class MainNavCubit extends Cubit<MainNavState> {
  MainNavCubit() : super(const MainNavState(0)); // Баштапкы индекс 0

  void updateIndex(int newIndex) {
    if (newIndex != state.currentIndex) {
      emit(MainNavState(newIndex));
    }
  }
}
