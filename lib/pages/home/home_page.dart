import 'package:flutter/material.dart';
import 'package:money_tracker/pages/home/add_form.dart';
import 'package:money_tracker/pages/home/movements_list.dart';
import 'package:money_tracker/provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MainProvider>(context);

    return Scaffold(
      body: MovementsList(movements: provider.movements),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Movement',
        shape: const CircleBorder(),
        onPressed: () => showAddMoneyMovementBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

