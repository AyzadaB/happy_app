import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_cubit.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_state.dart';
import 'package:happy_app/core/features/tasks/widgets/active_card.dart';
import 'package:happy_app/core/features/tasks/widgets/completed_cards.dart';
import 'package:happy_app/core/theme/app_colors.dart';
import 'package:happy_app/core/theme/app_theme.dart';
import 'package:hive/hive.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _CardSwitcherExampleState();
}

class _CardSwitcherExampleState extends State<TasksPage> {
  bool isActive = true;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          final tasks = isActive ? state.activeTasks : state.completedTasks;
          return Scaffold(
            backgroundColor: AppColors.backLevel1,
            appBar: AppBar(
              title: Text("Tasks", style: AppTextStyles.titleBold),
              centerTitle: true,
              backgroundColor: AppColors.backLevel1,
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _textButton(
                      isActiveState: isActive,
                      label: 'Aсtive',
                      onPressed: () {
                        if (!isActive) {
                          setState(() {
                            isActive = true;
                          });
                        }
                      },
                    ),
                    _textButton(
                      isActiveState: !isActive,
                      label: 'Completed',
                      onPressed: () {
                        if (isActive) {
                          setState(() {
                            isActive = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: tasks.isEmpty
                      ? isActive
                            ? Center(
                                child: Text(
                                  'No active tasks',
                                  style: AppTextStyles.footnote,
                                ),
                              )
                            : state.activeTasks.isEmpty &&
                                  state.completedTasks.isNotEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/congratulation.png',
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Congratulations, you have completed all the tasks!',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.titleBold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  'No completed tasks yet',
                                  style: AppTextStyles.footnote,
                                ),
                              )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          scrollDirection: Axis.vertical,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];

                            if (isActive) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ActiveCards(
                                  imagePath: task.image,
                                  title: task.title,
                                  description: task.desc,
                                  task: task,
                                  onPressed: (task) async {
                                    final confirm = await _showTaskDialog(
                                      context,
                                    ); // Показываем окно подтверждения

                                    if (confirm ?? false) {
                                      final box = Hive.box<TaskModel>(
                                        'tasksBox',
                                      );
                                      final index = box.values.toList().indexOf(
                                        task,
                                      ); // Получаем индекс задачи

                                      // Обновляем задачу: ставим флаг выполнения и дату
                                      final updatedTask = task.copyWith(
                                        isCompleted: true,
                                        completedAt: DateTime.now()
                                            .millisecondsSinceEpoch,
                                      );

                                      // Обновляем в Hive и через Cubit
                                      context.read<TaskCubit>().updateTask(
                                        index,
                                        updatedTask,
                                      );
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CompletedCards(
                                  imagePath: task.image,
                                  completedAt: task.completedAt,
                                  title: task.title,
                                  description: task.desc,
                                  task: task,
                                ),
                              );
                            }
                          },
                        ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<bool?> _showTaskDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Color.fromARGB(255, 197, 185, 185),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: 270,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Complete the task',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Divider(
                  endIndent: 0,
                  indent: 0,
                  thickness: 0.1,
                  color: Color(0xff3C3C43),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'Cancel',
                        style: AppTextStyles.ratingButton,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Confirm',
                        style: AppTextStyles.ratingButton,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _textButton({
  required bool isActiveState,
  required String label,
  required VoidCallback onPressed,
}) {
  return Container(
    width: 150,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: isActiveState ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: isActiveState ? AppColors.primary : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
