import 'package:hive/hive.dart';

part 'task_model.g.dart'; // ✅ именно в ОДИНАРНЫХ кавычках

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String image;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final int? completedAt;

  TaskModel({
    required this.image,
    required this.title,
    required this.desc,
    this.isCompleted = false,
    this.completedAt,
  });

  TaskModel copyWith({
    String? image,
    String? title,
    String? desc,
    bool? isCompleted,
    int? completedAt,
  }) {
    return TaskModel(
      image: image ?? this.image,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

final allTasks = Hive.box<TaskModel>('tasksBox');
final completed = allTasks.values.where((t) => t.isCompleted).toList();
final active = allTasks.values.where((t) => !t.isCompleted).toList();
