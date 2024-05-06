import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      final TextEditingController dateController = TextEditingController();
      // final TextEditingController descriptionController = TextEditingController();

      String? nameErrorText;
      String? amountErrorText;
      String? dateErrorText;

      String selectedCurrency = 'USD';
      final List<String> currencies = ['USD', 'EURO', 'COP'];
      MovementType selectedType = MovementType.income;

      IconData selectedIcon = Icons.home;
      List<IconData> iconsList = iconsListSample;

      DateTime selectedDate = provider.selectedDate;

      dateController.text = dateController.text =
          DateFormat('dd-MM-yyyy').format(selectedDate).toString();

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

        if (dateController.text.isEmpty) {
          nameErrorText = "A date is required";
          isValid = false;
        } else {
          nameErrorText = null;
        }

        return isValid;
      }

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          Future<void> selectDate(BuildContext context) async {
            DateTime initialDate = selectedDate;
            DateTime firstDate =
                initialDate.subtract(const Duration(days: 9999));

            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: DateTime.now(),
            );

            if (picked != null && picked != initialDate) {
              dateController.text =
                  DateFormat('dd-MM-yyyy').format(picked).toString();
              setState(
                () {
                  selectedDate = picked;
                },
              );
            }
          }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<MovementType>(
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
                        items:
                            MovementType.values.map((MovementType classType) {
                          return DropdownMenuItem<MovementType>(
                            value: classType,
                            child: Text(classType.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: "Date",
                          errorText: dateErrorText,
                        ),
                        onTap: () => selectDate(context),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        readOnly: true,
                      ),
                    )),
                  ],
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
                              monetaryUnit: selectedCurrency,
                              movementDate: selectedDate);

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
