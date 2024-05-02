import 'package:flutter/material.dart';
import 'package:money_tracker/provider.dart';
import 'package:money_tracker/util/icons.dart';
import 'package:money_tracker/util/movement.dart';
import 'package:provider/provider.dart';

void showAddMoneyMovementBottomSheet(BuildContext context) {
  final provider = Provider.of<MainProvider>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController nameController = TextEditingController();
      final TextEditingController amountController = TextEditingController();
      // final TextEditingController descriptionController = TextEditingController();

      String? nameErrorText;
      String? amountErrorText;

      String selectedCurrency = 'USD';
      final List<String> currencies = ['USD', 'EURO', 'COP'];
      MovementType selectedType = MovementType.income;

      IconData selectedIcon = Icons.home;
      List<IconData> iconsList = iconsListSample;

      bool validateForm() {
        bool isValid = true;

        if (nameController.text.isEmpty) {
          nameErrorText = "A name is required";
          isValid = false;
        } else {
          nameErrorText = null;
        }

        double? amount = double.tryParse(amountController.text);
        if (amount == null || amount < 0) {
          amountErrorText = "Enter a valid amount";
          isValid = false;
        } else {
          amountErrorText = null;
        }

        return isValid;
      }

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    errorText: nameErrorText,
                  ),
                ),
                DropdownButtonFormField<MovementType>(
                  decoration: const InputDecoration(
                    labelText: "Type",
                  ),
                  isExpanded: true,
                  value: selectedType,
                  onChanged: (MovementType? newValue) {
                    setState(() {
                      selectedType = newValue!;
                    });
                  },
                  items: MovementType.values.map((MovementType classType) {
                    return DropdownMenuItem<MovementType>(
                      value: classType,
                      child: Text(classType.toString().split('.').last),
                    );
                  }).toList(),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Description (Optional)",
                  ),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    errorText: amountErrorText,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedCurrency,
                        decoration: const InputDecoration(
                          labelText: "Currency",
                        ),
                        items: currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCurrency = newValue!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<IconData>(
                        value: selectedIcon,
                        decoration: const InputDecoration(
                          labelText: "Icon",
                        ),
                        items: iconsList
                            .map<DropdownMenuItem<IconData>>((IconData value) {
                          return DropdownMenuItem<IconData>(
                            value: value,
                            child: Icon(value),
                          );
                        }).toList(),
                        onChanged: (IconData? newValue) {
                          setState(() {
                            selectedIcon = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text("Add"),
                      onPressed: () {
                        if (validateForm()) {
                          // nameController.clear();
                          // amountController.clear();
                          // descriptionController.clear();

                          MoneyMovement newMovement = MoneyMovement(
                              icon: selectedIcon,
                              name: nameController.text,
                              movementType: selectedType,
                              amount: double.tryParse(amountController.text)!,
                              monetaryUnit: selectedCurrency);

                          provider.addMovement(newMovement);

                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
