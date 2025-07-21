import 'package:bloc/bloc.dart';
import '../../data/models/task_model.dart';
import '../../data/task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TasksRepository repository;

  TaskCubit({required this.repository}) : super(TaskInitial()) {
    loadTasks();
  }

  void loadTasks() {
    final active = repository.getActive();
    final completed = repository.getCompleted();
    emit(TaskLoaded(activeTasks: active, completedTasks: completed));
  }

  Future<void> addTask(TaskModel task) async {
    await repository.addTask(task);
    loadTasks();
  }

  Future<void> toggleTask(int index, TaskModel task) async {
    final updated = TaskModel(
      image: task.image,
      title: task.title,
      desc: task.desc,
      isCompleted: !task.isCompleted,
    );
    await repository.updateTask(index, updated);
    loadTasks();
  }

  Future<void> deleteTask(int index) async {
    await repository.deleteTask(index);
    loadTasks();
  }

  void updateTask(int index, TaskModel updatedTask) async {
    await repository.updateTask(index, updatedTask);
    loadTasks(); // обновит состояние
  }
}
