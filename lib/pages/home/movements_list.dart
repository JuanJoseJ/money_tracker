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

  void showConfirmationDialog(BuildContext context) async {
    final provider = Provider.of<MainProvider>(context, listen: false);
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Are you sure you want to delete this register?"),
              actions: <Widget>[
                TextButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ACCEPT'),
                  onPressed: () {
                    provider.deleteMovement(movement);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showConfirmationDialog(context),
      child: ListTile(
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
        trailing: Text(movement.movementType == MovementType.income
            ? 'Income'
            : 'Expense'),
      ),
    );
  }
}
