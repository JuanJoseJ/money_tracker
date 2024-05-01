import 'package:flutter/foundation.dart';
import 'package:money_tracker/util/movement.dart';

class MainProvider extends ChangeNotifier {
  List<MoneyMovement> _movements = mockMoneyMovements;
  List<MoneyMovement> get movements => _movements;
  void updateMovements(List<MoneyMovement> newMovements) {
    _movements = newMovements;
    notifyListeners();
  }
}
