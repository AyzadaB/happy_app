part of 'moment_cubit.dart';

abstract class MomentState {}

class MomentInitial extends MomentState {}

class MomentLoaded extends MomentState {
  final List<MomentModel> moments;
  MomentLoaded(this.moments);
}
