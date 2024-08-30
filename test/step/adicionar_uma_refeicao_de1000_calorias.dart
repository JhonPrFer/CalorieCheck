import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'acionar_a_opcao_de_adicionar_alimento.dart';

/// Usage: adicionar uma refeição de 1000 calorias
Future<void> adicionarUmaRefeicaoDe1000Calorias(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.fastfood));

  await tester.pumpAndSettle();
  await acionarAOpcaoDeAdicionarAlimento(tester);

  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, 'mac');
  await tester.enterText(find.byType(TextField).last, '1000');
  await tester.tap(find.text('Salvar'));
}
