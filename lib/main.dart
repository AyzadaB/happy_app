import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/moments/logic/moment_cubit.dart';
import 'package:happy_app/core/features/splashScreen/splashScreen_page.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/features/tasks/data/task_repository.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(MomentModelAdapter());
  await Hive.deleteBoxFromDisk('tasksBox');
  await Hive.openBox<TaskModel>('tasksBox');
  await Hive.openBox<MomentModel>('momentsBox');
  final momentsBox = await Hive.openBox<MomentModel>('momentsBox');

  final repository = TasksRepository();
  await repository.addInitialTasks();

  runApp(MyApp(repository: repository, momentsBox: momentsBox));
}

class MyApp extends StatelessWidget {
  final TasksRepository repository;
  final Box<MomentModel> momentsBox;

  const MyApp({super.key, required this.repository, required this.momentsBox});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (_) => TaskCubit(repository: repository),
        ),
        BlocProvider(create: (_) => MomentCubit(box: momentsBox)),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
