import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cabia_mobile/main.dart';
import 'package:cabia_mobile/settings.dart';

void main() {
  testWidgets('counter increments', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: const MyApp(),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.text('Increment'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
