import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cabia_mobile/main.dart';
import 'package:cabia_mobile/providers/theme_provider.dart';

void main() {
  testWidgets('shows the product catalog and settings entry', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(create: (_) => ThemeModel(), child: const MyApp()),
    );

    await tester.pumpAndSettle();

    expect(find.text('Aquaria Store'), findsOneWidget);
    expect(find.text('Search products'), findsOneWidget);
    expect(find.text('Aquarium'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Theme'), findsOneWidget);
  });
}
