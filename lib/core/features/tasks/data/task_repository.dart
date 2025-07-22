import 'package:happy_app/core/features/tasks/data/tasks_data.dart';
import 'package:hive/hive.dart';
import 'models/task_model.dart';

class TasksRepository {
  final Box<TaskModel> box = Hive.box<TaskModel>('tasksBox');

  List<TaskModel> getActive() =>
      box.values.where((task) => !task.isCompleted).toList();

  List<TaskModel> getCompleted() =>
      box.values.where((task) => task.isCompleted).toList();

  Future<void> addTask(TaskModel task) async {
    await box.add(task);
  }

  Future<void> updateTask(int index, TaskModel updatedTask) async {
    await box.putAt(index, updatedTask);
  }

  Future<void> deleteTask(int index) async {
    await box.deleteAt(index);
  }

  Future<void> addInitialTasks() async {
    if (box.isEmpty) {
      final allTasks = <TaskModel>[];

      for (var card in cardsData) {
        allTasks.add(
          TaskModel(
            image: card['image']!,
            title: card['title']!,
            desc: card['desc']!,
            isCompleted: false,
          ),
        );
      }

      // for (var card in completedData) {
      //   allTasks.add(
      //     TaskModel(
      //       image: card['image']!,
      //       title: card['title']!,
      //       desc: card['desc']!,
      //       isCompleted: true,
      //       completedAt: card['completedAt'],
      //     ),
      //   );
      // }

      for (var task in allTasks) {
        await box.add(task);
      }
    }
  }
}
