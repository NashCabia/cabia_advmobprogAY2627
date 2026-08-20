import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cabia_mobile/providers/theme_provider.dart';

// Enhancement 3: settings screen hosts the theme toggle for dark/light mode.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Settings')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text(
            'This theme setting affects the entire application.',
          ),
          value: themeModel.isDarkMode,
          onChanged: themeModel.toggleTheme,
        ),
      ),
    );
  }
}
