import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:happy_app/main.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/features/tasks/data/task_repository.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';

void main() {
  late Box<TaskModel> tasksBox;
  late Box<MomentModel> momentsBox;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();

    // Регистрируем адаптеры
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(MomentModelAdapter());

    // Открываем боксы
    tasksBox = await Hive.openBox<TaskModel>('tasksBox');
    momentsBox = await Hive.openBox<MomentModel>('momentsBox');
  });

  tearDownAll(() async {
    await tasksBox.close();
    await momentsBox.close();
  });

  testWidgets('App loads and displays', (WidgetTester tester) async {
    final testRepository = TasksRepository();

    await tester.pumpWidget(
      MyApp(repository: testRepository, momentsBox: momentsBox),
    );

    // Здесь можно написать свои проверки
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
