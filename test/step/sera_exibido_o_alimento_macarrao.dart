import 'package:flutter_test/flutter_test.dart';

/// Usage: será exibido o alimento macarrao
Future<void> seraExibidoOAlimentoMacarrao(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('macarrão'), findsOneWidget);
}
