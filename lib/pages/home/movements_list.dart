import 'package:flutter/material.dart';
import 'package:money_tracker/provider.dart';
import 'package:money_tracker/util/movement.dart';
import 'package:provider/provider.dart';

class MovementsList extends StatelessWidget {
  const MovementsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<MoneyMovement> movements =
        Provider.of<MainProvider>(context).movements;
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${movement.monetaryUnit} ${movement.amount.toString()}'),
          Text(
              '${movement.movementDate!.day}/${movement.movementDate!.month}/${movement.movementDate!.year}'),
        ],
      ),
      trailing: Text(
          movement.movementType == MovementType.income ? 'Income' : 'Expense'),
    );
  }
}
