import 'package:flutter_test/flutter_test.dart';

import 'acessar_a_aba_de_metas.dart';

/// Usage: a meta será atualizada exibindo as calorias consumidas
Future<void> aMetaSeraAtualizadaExibindoAsCaloriasConsumidas(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  await acessarAAbaDeMetas(tester);

  await tester.pumpAndSettle();
  expect(find.text('1000/3000 kcal'), findsOneWidget);
}
