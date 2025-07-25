import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_app/core/features/main/logic/cubit/main_nav_cubit.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/moments/logic/moment_cubit.dart';
import 'package:happy_app/core/features/quote/data/quote_model.dart';
import 'package:happy_app/core/features/quote/logic/quote_cubit.dart';
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
  Hive.registerAdapter(QuoteModelAdapter());
  await Hive.openBox<TaskModel>('tasksBox');
  await Hive.openBox<MomentModel>('momentsBox');
  final momentsBox = await Hive.openBox<MomentModel>('momentsBox');
  final quoteBox = await Hive.openBox<QuoteModel>('quoteBox');
  final appSettingsBox = await Hive.openBox<dynamic>('appSettings');

  final repository = TasksRepository();
  await repository.addInitialTasks();

  runApp(
    MyApp(
      repository: repository,
      momentsBox: momentsBox,
      quoteBox: quoteBox,
      appSettingsBox: appSettingsBox,
    ),
  );
}

class MyApp extends StatelessWidget {
  final TasksRepository repository;
  final Box<MomentModel> momentsBox;
  final Box<QuoteModel> quoteBox;
  final Box<dynamic> appSettingsBox;

  const MyApp({
    super.key,
    required this.repository,
    required this.momentsBox,
    required this.quoteBox,
    required this.appSettingsBox,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (_) => TaskCubit(repository: repository),
        ),
        BlocProvider(create: (_) => MomentCubit(box: momentsBox)),
        BlocProvider<QuoteCubit>(
          create: (context) => QuoteCubit(quoteBox, appSettingsBox),
        ),
        BlocProvider<MainNavCubit>(create: (context) => MainNavCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
