import 'package:flutter_test/flutter_test.dart';

/// Usage: será exibido o exercicio musculação
Future<void> seraExibidoOExercicioMusculacao(WidgetTester tester) async {
  expect(find.text('musculação'), findsOneWidget);
  expect(find.text('200'), findsOneWidget);
}
