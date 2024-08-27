import 'package:flutter_test/flutter_test.dart';

/// Usage: será exibido o alimento carne
Future<void> seraExibidoOAlimentoCarne(WidgetTester tester) async {
  expect(find.text('carne'), findsOneWidget);
  expect(find.text('200'), findsOneWidget);
}
