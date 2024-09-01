import 'package:flutter_test/flutter_test.dart';

/// Usage: não será exibido o exercicio musculação
Future<void> naoSeraExibidoOExercicioMusculacao(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('musculação'), findsNothing);
}
