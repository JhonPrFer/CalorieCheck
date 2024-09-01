import 'package:flutter_test/flutter_test.dart';

/// Usage: confirmar a exclusão da meta
Future<void> confirmarAExclusaoDaMeta(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.text('Excluir'));
}
