import 'dart:io';
import 'package:hive/hive.dart';

part 'moment_model.g.dart'; // Этот файл будет сгенерирован

@HiveType(typeId: 1)
class MomentModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String tag;

  @HiveField(4)
  final String? imageFilePath; // Хранит путь к файлу изображения

  @HiveField(5)
  final String? imageAssetPath; // Путь к ассету, если используется

  MomentModel({
    required this.id,
    required this.name,
    required this.date,
    required this.tag,
    this.imageFilePath,
    this.imageAssetPath,
  }) : assert(
         imageFilePath != null || imageAssetPath != null,
         'Должен быть задан хотя бы один путь к изображению',
       );

  // Геттер для удобного получения файла из пути
  File? get imageFile => imageFilePath != null ? File(imageFilePath!) : null;
}
