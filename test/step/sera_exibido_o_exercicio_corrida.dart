import 'package:flutter_test/flutter_test.dart';

/// Usage: será exibido o exercicio corrida
Future<void> seraExibidoOExercicioCorrida(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('corrida'), findsOneWidget);
}
