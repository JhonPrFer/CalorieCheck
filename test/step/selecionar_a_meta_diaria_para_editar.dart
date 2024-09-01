import 'package:flutter_test/flutter_test.dart';

/// Usage: selecionar a meta diaria para editar
Future<void> selecionarAMetaDiariaParaEditar(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.drag(find.text('Diária'), const Offset(500.0, 0.0));
}
