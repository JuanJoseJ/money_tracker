import 'package:flutter/material.dart';
import 'package:money_tracker/provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SwitchListTile(
          title: Text('Dark Theme'),
          value: provider.themeData.brightness == Brightness.dark,
          onChanged: (value) {
            ThemeData newTheme = value
                ? ThemeData.dark(useMaterial3: true)
                : ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepOrange),
                    useMaterial3: true,
                  );
            provider.setThemeData(newTheme);
          },
        ),
      ),
    );
  }
}
