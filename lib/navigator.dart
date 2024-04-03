import 'package:flutter/material.dart';
import 'package:money_tracker/pages/data_page.dart';
import 'package:money_tracker/pages/home_page.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({
    super.key,
    required GlobalKey<NavigatorState> navigatorKey,
  }) : _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => const HomePage();
            break;
          case '/business':
            builder = (BuildContext context) => const BusinessPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
