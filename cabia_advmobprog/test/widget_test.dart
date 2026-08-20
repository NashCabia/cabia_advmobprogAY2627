import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cabia_mobile/main.dart';
import 'package:cabia_mobile/providers/cart_provider.dart';
import 'package:cabia_mobile/providers/theme_provider.dart';

void main() {
  testWidgets('shows the authentication splash screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeModel()),
          ChangeNotifierProvider(create: (_) => CartModel()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('Aquaria Store'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
  });
}
