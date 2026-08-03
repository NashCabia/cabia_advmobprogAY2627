import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Manages the app-wide light and dark theme state.
class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  /// Returns whether dark mode is currently enabled.
  bool get isDarkMode => _isDarkMode;

  /// Updates the theme and notifies all listening widgets.
  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}

/// Displays the theme toggle on a separate screen.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
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