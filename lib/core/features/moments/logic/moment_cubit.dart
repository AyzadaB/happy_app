import 'package:bloc/bloc.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:hive/hive.dart';

part 'moment_state.dart';

class MomentCubit extends Cubit<MomentState> {
  final Box<MomentModel> box;

  MomentCubit({required this.box}) : super(MomentInitial()) {
    loadMoments();
  }

  void loadMoments() {
    final moments = box.values.toList();
    emit(MomentLoaded(moments));
  }

  Future<void> addMoment(MomentModel moment) async {
    await box.put(moment.id, moment);
    loadMoments();
  }

  Future<void> deleteMoment(String id) async {
    await box.delete(id);
    loadMoments();
  }
}
