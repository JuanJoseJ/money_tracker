import 'package:flutter/material.dart';
import 'package:money_tracker/pages/graphs/data_page.dart';
import 'package:money_tracker/pages/home/home_page.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => HomePage();
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
