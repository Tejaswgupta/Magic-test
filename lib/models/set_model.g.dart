// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetModelAdapter extends TypeAdapter<SetModel> {
  @override
  final int typeId = 1;

  @override
  SetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SetModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SetModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.workoutType)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.reps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
