// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyMovementAdapter extends TypeAdapter<MoneyMovement> {
  @override
  final int typeId = 0;

  @override
  MoneyMovement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyMovement(
      id: fields[0] as int?,
      icon: fields[1] as IconData,
      name: fields[2] as String,
      movementType: fields[3] as MovementType,
      description: fields[4] as String?,
      amount: fields[5] as double,
      monetaryUnit: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyMovement obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.movementType)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.monetaryUnit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyMovementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MovementTypeAdapter extends TypeAdapter<MovementType> {
  @override
  final int typeId = 1;

  @override
  MovementType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MovementType.income;
      case 1:
        return MovementType.expense;
      default:
        return MovementType.income;
    }
  }

  @override
  void write(BinaryWriter writer, MovementType obj) {
    switch (obj) {
      case MovementType.income:
        writer.writeByte(0);
        break;
      case MovementType.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovementTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
