// lib/core/features/moments/data/moment_model.dart
import 'dart:io';

class MomentModel {
  final String id;
  final String name;
  final DateTime date;
  final String tag;
  final File? imageFile; // Эми бул null болушу мүмкүн
  final String? imageAssetPath; // Жаңы талаа: assets жолу

  MomentModel({
    required this.id,
    required this.name,
    required this.date,
    required this.tag,
    this.imageFile, // Optional
    this.imageAssetPath, // Optional
  }) : assert(imageFile != null || imageAssetPath != null,
            'Either imageFile or imageAssetPath must be provided'); // Жок дегенде бири болушу керек

  // Hive үчүн toMap/fromMap же toJson/fromJson методдорун кийин кошосуз
  // азырынча, бул жерде бир мисал:
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'tag': tag,
      'imageFilePath': imageFile?.path, // File path for local storage
      'imageAssetPath': imageAssetPath, // Asset path for bundled assets
    };
  }

  factory MomentModel.fromMap(Map<String, dynamic> map) {
    return MomentModel(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      tag: map['tag'],
      imageFile: map['imageFilePath'] != null ? File(map['imageFilePath']) : null,
      imageAssetPath: map['imageAssetPath'],
    );
  }
}