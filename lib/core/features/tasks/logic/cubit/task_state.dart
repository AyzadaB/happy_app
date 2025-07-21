import 'package:equatable/equatable.dart';
import '../../data/models/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> activeTasks;
  final List<TaskModel> completedTasks;

  const TaskLoaded({required this.activeTasks, required this.completedTasks});

  @override
  List<Object> get props => [activeTasks, completedTasks];
}
