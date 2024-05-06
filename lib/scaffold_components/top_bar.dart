import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/provider.dart';
import 'package:provider/provider.dart';

class MyTopBar extends StatefulWidget implements PreferredSizeWidget {
  const MyTopBar({
    super.key,
  });

  @override
  State<MyTopBar> createState() => _MyTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyTopBarState extends State<MyTopBar> {
  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);
    DateTime selectedDate = provider.selectedDate;

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
        provider.updateSelectedDate(picked);
      }
    }

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                DateTime newDate =
                    selectedDate.subtract(const Duration(hours: 24));
                provider.updateSelectedDate(newDate);
              }),
          Expanded(
              child: GestureDetector(
                onTap: () => selectDate(context),
                child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                Text(DateFormat("dd-MMMM-yyyy").format(selectedDate)),
                          ],
                        ),
              )),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                DateTime newDate = selectedDate.add(const Duration(hours: 24));
                DateTime now = DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day);
                if (newDate.isBefore(now) || newDate.isAtSameMomentAs(now)) {
                  provider.updateSelectedDate(newDate);
                }
              }),
        ],
      ),
    );
  }
}
