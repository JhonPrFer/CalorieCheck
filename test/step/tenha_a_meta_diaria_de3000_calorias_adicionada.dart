import 'package:flutter_test/flutter_test.dart';

import 'acionar_a_opcao_de_adicionar_metas.dart';
import 'adicionar_a_meta_diaria_de3000_calorias.dart';

/// Usage: tenha a meta diaria de 3000 calorias adicionada
Future<void> tenhaAMetaDiariaDe3000CaloriasAdicionada(
    WidgetTester tester) async {
  await acionarAOpcaoDeAdicionarMetas(tester);
  await adicionarAMetaDiariaDe3000Calorias(tester);
}
