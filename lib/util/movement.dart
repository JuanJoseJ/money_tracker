import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'movement.g.dart';

@HiveType(typeId: 0)
class MoneyMovement {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final IconData icon;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final MovementType movementType;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final double amount;

  @HiveField(6)
  final String monetaryUnit;

  MoneyMovement({
    this.id,
    required this.icon,
    required this.name,
    required this.movementType,
    this.description,
    required this.amount,
    required this.monetaryUnit,
  });
}

@HiveType(typeId: 1)
enum MovementType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final typeId = 3;

  @override
  IconData read(BinaryReader reader) {
    return IconData(reader.readInt(), fontFamily: 'MaterialIcons');
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    writer.writeInt(obj.codePoint);
  }
}
