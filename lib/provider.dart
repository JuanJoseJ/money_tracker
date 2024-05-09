import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_tracker/util/movement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  Box<MoneyMovement>? _box;
  List<MoneyMovement> _movements = [];

  MainProvider(this._themeData) {
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

  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime get selectedDate => _selectedDate;
  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  ThemeData _themeData;

  ThemeData get themeData => _themeData;

  setThemeData(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', themeData.brightness == Brightness.dark);
  }

  Future<void> loadThemeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    _themeData = isDarkTheme ? ThemeData.dark(useMaterial3: true) : _themeData;
    notifyListeners();
  }

  @override
  void dispose() {
    _box!.close();
    super.dispose();
  }
}
