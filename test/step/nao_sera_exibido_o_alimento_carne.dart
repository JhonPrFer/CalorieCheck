import 'package:flutter_test/flutter_test.dart';

/// Usage: não será exibido o alimento carne
Future<void> naoSeraExibidoOAlimentoCarne(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('carne'), findsNothing);
}
