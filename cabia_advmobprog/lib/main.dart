import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: const MyApp(),
    ),
  );
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // Light theme of the application.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      // Dark theme of the application.
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),

      // Selects the app-wide theme managed by Provider.
      themeMode:
          themeModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

/// Counter screen that demonstrates ephemeral state.
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Stores and manages the local counter state.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// Increases the counter using setState.
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// Opens the separate theme settings screen.
  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

        // Opens the second screen required by the activity.
        actions: [
          IconButton(
            onPressed: _openSettings,
            tooltip: 'Theme Settings',
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}