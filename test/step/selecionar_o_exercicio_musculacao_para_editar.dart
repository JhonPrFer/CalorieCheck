import 'package:flutter_test/flutter_test.dart';

/// Usage: selecionar o exercicio musculação para editar
Future<void> selecionarOExercicioMusculacaoParaEditar(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.drag(find.text('musculação'), const Offset(500.0, 0.0));
}
