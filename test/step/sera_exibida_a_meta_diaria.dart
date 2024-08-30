import 'package:flutter_test/flutter_test.dart';

/// Usage: será exibida a meta diaria
Future<void> seraExibidaAMetaDiaria(WidgetTester tester) async {
  expect(find.text('Diária'), findsOneWidget);
  expect(find.text('3000'), findsOneWidget);
}
