import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// To generate the file run:
// flutter pub run build_runner build
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

  @HiveField(7)
  DateTime movementDate;

  MoneyMovement({
    this.id,
    required this.icon,
    required this.name,
    required this.movementType,
    this.description,
    required this.amount,
    required this.monetaryUnit,
    required this.movementDate,
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