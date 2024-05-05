import 'package:flutter/material.dart';
import 'package:money_tracker/navigator.dart';
import 'package:money_tracker/scaffold_components/bottom_bar.dart';
import 'package:money_tracker/scaffold_components/top_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  MainScaffoldState createState() => MainScaffoldState();
}

class MainScaffoldState extends State {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        _navigatorKey.currentState!.pushNamed('/');
        break;
      case 1:
        _navigatorKey.currentState!.pushNamed('/business');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const MyTopBar(),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
      body: MyNavigator(navigatorKey: _navigatorKey),
    );
  }
}
