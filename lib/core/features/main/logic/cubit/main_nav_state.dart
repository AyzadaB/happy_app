part of 'main_nav_cubit.dart';

class MainNavState extends Equatable {
  final int currentIndex;

  const MainNavState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
