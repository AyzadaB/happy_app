import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:happy_app/main.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/features/tasks/data/task_repository.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>('tasksBox');
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final testRepository = TasksRepository();

    await tester.pumpWidget(MyApp(repository: testRepository));

    // Здесь твои тесты
  });
}
