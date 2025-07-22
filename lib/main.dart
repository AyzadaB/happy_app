import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_app/core/features/splashScreen/splashScreen_page.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/features/tasks/data/task_repository.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Обязательно
  await Hive.initFlutter(); // ✅ Только после этого
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.deleteBoxFromDisk('tasksBox');
  await Hive.openBox<TaskModel>('tasksBox');

  final repository = TasksRepository();
  await repository.addInitialTasks();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TasksRepository repository;

  const MyApp({super.key, required this.repository});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(repository: repository),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
