import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:happy_app/main.dart';
import 'package:happy_app/core/features/tasks/data/models/task_model.dart';
import 'package:happy_app/core/features/tasks/data/task_repository.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/quote/data/quote_model.dart';

void main() {
  late Box<TaskModel> tasksBox;
  late Box<MomentModel> momentsBox;
  late Box<QuoteModel> quoteBox;
  late Box<dynamic> appSettingsBox;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    // Регистрируем адаптеры
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(MomentModelAdapter());
    Hive.registerAdapter(QuoteModelAdapter());

    // Открываем боксы
    tasksBox = await Hive.openBox<TaskModel>('tasksBox');
    momentsBox = await Hive.openBox<MomentModel>('momentsBox');
    quoteBox = await Hive.openBox<QuoteModel>('quoteBox');
    appSettingsBox = await Hive.openBox<dynamic>('appSettings');
  });

  tearDownAll(() async {
    await tasksBox.close();
    await momentsBox.close();
    await quoteBox.close();
    await appSettingsBox.close();
  });

  testWidgets('App loads and displays', (WidgetTester tester) async {
    final testRepository = TasksRepository();

    await tester.pumpWidget(
      MyApp(
        repository: testRepository,
        momentsBox: momentsBox,
        quoteBox: quoteBox,
        appSettingsBox: appSettingsBox,
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
