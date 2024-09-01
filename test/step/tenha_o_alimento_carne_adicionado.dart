import 'package:flutter_test/flutter_test.dart';

import 'acionar_a_opcao_de_adicionar_alimento.dart';
import 'adicionar_o_alimento_carne_com200_calorias.dart';

/// Usage: tenha o alimento carne adicionado
Future<void> tenhaOAlimentoCarneAdicionado(WidgetTester tester) async {
  await acionarAOpcaoDeAdicionarAlimento(tester);
  await adicionarOAlimentoCarneCom200Calorias(tester);
}
