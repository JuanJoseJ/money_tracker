import 'package:flutter/material.dart';
import 'package:money_tracker/pages/graphs/data_page.dart';
import 'package:money_tracker/pages/home/home_page.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  // The use of a navigator in the body of the scaffold allows us to set a method
  // to navigate down this point, separate to the one used in the material app. A
  // navigatorKey is defined directly in the scaffold so that it can be used inside
  // the bottom bar navigation, which is not directly under the navigator widget.

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => HomePage();
            break;
          case '/graphs':
            builder = (BuildContext context) => GraphsPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
