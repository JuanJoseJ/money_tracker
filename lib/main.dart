import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_tracker/main_scaffold.dart';
import 'package:money_tracker/pages/settings/settings_page.dart';
import 'package:money_tracker/provider.dart';
import 'package:money_tracker/util/movement.dart';
import 'package:provider/provider.dart';

void main() async {
// Ensure that all Flutter engine bindings are initialized. This is necessary if you're running
// initialization logic before running `runApp()`. It's particularly important when asynchronous
// operations like opening Hive boxes are involved, as these need the Flutter environment to be fully set up.
  WidgetsFlutterBinding.ensureInitialized();

// Initialize Hive for Flutter applications. This sets up the path where Hive will store its
// boxes, which is essential for storing data locally on the device. `initFlutter` configures
// Hive to use the default application directory provided by the Flutter framework.
  await Hive.initFlutter();

// Register a custom adapter for the MoneyMovement type with Hive. This adapter handles
// serializing and deserializing MoneyMovement objects so they can be stored in Hive's
// NoSQL database. Each custom type you store in Hive requires its own adapter.
  Hive.registerAdapter(MoneyMovementAdapter());

  Hive.registerAdapter(MovementTypeAdapter());

  Hive.registerAdapter(IconDataAdapter());

// Open a box to store MoneyMovement objects. In Hive, a 'box' is like a table in SQL or
// a collection in MongoDB. It's a container for storing multiple objects of the same type.
// Here, 'money_movements' is the name of the box. You must await this operation because
// opening a box involves I/O operations which are asynchronous.
  try {
    await Hive.openBox<MoneyMovement>('money_movements');
    // await Hive.box<MoneyMovement>('money_movements').clear();
  } catch (e) {
    print("Error opening or clearing the box: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _mainNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MaterialApp(
        title: 'Money Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        navigatorKey: _mainNavigatorKey,
        routes: <String, WidgetBuilder>{
          '/': (context) => const MainScaffold(),
          '/settings': (context) => SettingsPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
