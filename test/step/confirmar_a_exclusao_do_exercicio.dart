import 'package:flutter_test/flutter_test.dart';

/// Usage: confirmar a exclusão do exercicio
Future<void> confirmarAExclusaoDoExercicio(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.text('Excluir'));
}
