import 'package:flutter_test/flutter_test.dart';
import 'acionar_a_opcao_de_adicionar_exercicios.dart';
import 'adicionar_o_exercicio_musculacao_com200_calorias.dart';

/// Usage: tenha o exercicio musculação adicionado
Future<void> tenhaOExercicioMusculacaoAdicionado(WidgetTester tester) async {
  await acionarAOpcaoDeAdicionarExercicios(tester);
  await adicionarOExercicioMusculacaoCom200Calorias(tester);
}
