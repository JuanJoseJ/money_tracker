import 'package:flutter/material.dart';
import 'package:money_tracker/util/movement.dart';

class MovementsList extends StatelessWidget {
  const MovementsList({
    super.key,
    required this.movements,
  });

  final List<MoneyMovement> movements;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movements.length,
      itemBuilder: (context, index) {
        return MoneyMovementTile(movement: movements[index]);
      },
    );
  }
}

class MoneyMovementTile extends StatelessWidget {
  final MoneyMovement movement;

  const MoneyMovementTile({Key? key, required this.movement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(movement.icon),
      title: Text(movement.name),
      subtitle: Text('${movement.monetaryUnit} ${movement.amount.toString()}'),
      trailing: Text(
          movement.movementType == MovementType.income ? 'Income' : 'Expense'),
    );
  }
}
