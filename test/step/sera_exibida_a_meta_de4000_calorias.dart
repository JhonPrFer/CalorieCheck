import 'package:flutter_test/flutter_test.dart';

/// Usage: será exibida a meta de 4000 calorias
Future<void> seraExibidaAMetaDe4000Calorias(WidgetTester tester) async {
  expect(find.text('4000'), findsOneWidget);
}
