// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MomentModelAdapter extends TypeAdapter<MomentModel> {
  @override
  final int typeId = 1;

  @override
  MomentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MomentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      date: fields[2] as DateTime,
      tag: fields[3] as String,
      imageFilePath: fields[4] as String?,
      imageAssetPath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MomentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.imageFilePath)
      ..writeByte(5)
      ..write(obj.imageAssetPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MomentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
