import 'package:flutter_test/flutter_test.dart';

/// Usage: não será exibida a meta de 3000 calorias
Future<void> naoSeraExibidaAMetaDe3000Calorias(WidgetTester tester) async {
  expect(find.text('3000'), findsNothing);
}
