import 'package:flutter_test/flutter_test.dart';

/// Usage: confirmar a exclusão do alimento
Future<void> confirmarAExclusaoDoAlimento(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.text('Excluir'));
}
