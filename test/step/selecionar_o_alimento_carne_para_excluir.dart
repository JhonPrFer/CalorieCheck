import 'package:flutter_test/flutter_test.dart';

/// Usage: selecionar o alimento carne para excluir
Future<void> selecionarOAlimentoCarneParaExcluir(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.drag(find.text('carne'), const Offset(-500, 0));
}
