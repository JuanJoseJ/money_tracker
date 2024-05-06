import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:money_tracker/util/movement.dart';

class MainProvider extends ChangeNotifier {
  Box<MoneyMovement>? _box;
  List<MoneyMovement> _movements = [];

  MainProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox<MoneyMovement>('money_movements');
    _movements = _box!.values.toList();
    notifyListeners();
  }

  List<MoneyMovement> get movements => _movements;

  Future<void> addMovement(MoneyMovement movement) async {
    var key = await _box!.add(movement);
    print("KEY ${key}");
    movement.id = key; 
    _movements.add(movement);
    notifyListeners();
  }

  Future<void> updateMovement(MoneyMovement movement) async {
    if (movement.id == null) {
      return;
    }
    await _box!.put(movement.id, movement);
    int index = _movements.indexWhere((m) => m.id == movement.id);
    if (index != -1) {
      _movements[index] = movement;
      notifyListeners();
    }
  }

  Future<void> deleteMovement(MoneyMovement movement) async {
    if (movement.id == null) {
      print("ID NULL. MOVEMNT: ${movement}");
      return;
    }
    await _box!.delete(movement.id);
    _movements.removeWhere((m) => m.id == movement.id);
    print("DELETE MOVEMENT");
    notifyListeners();
  }

  @override
  void dispose() {
    _box!.close();
    super.dispose();
  }
}
