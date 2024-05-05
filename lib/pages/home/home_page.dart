import 'package:flutter/material.dart';
import 'package:money_tracker/pages/home/add_form.dart';
import 'package:money_tracker/pages/home/movements_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MovementsList(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Movement',
        shape: const CircleBorder(),
        onPressed: () => showAddMoneyMovementBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
