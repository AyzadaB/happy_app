import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_nav_state.dart'; 

class MainNavCubit extends Cubit<MainNavState> {
  MainNavCubit() : super(const MainNavState(0)); 

  void updateIndex(int newIndex) {
    if (newIndex != state.currentIndex) {
      emit(MainNavState(newIndex));
    }
  }
}
