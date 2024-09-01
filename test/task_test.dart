// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/que_eu_acesse_o_app.dart';
import './step/faca_login_com_email.dart';
import './step/acionar_a_opcao_de_adicionar_alimento.dart';
import './step/adicionar_o_alimento_carne_com200_calorias.dart';
import './step/sera_exibido_o_alimento_carne.dart';
import './step/tenha_o_alimento_carne_adicionado.dart';
import './step/selecionar_o_alimento_carne_para_editar.dart';
import './step/editar_o_nome_para_macarrao.dart';
import './step/sera_exibido_o_alimento_macarrao.dart';
import './step/nao_sera_exibido_o_alimento_carne.dart';
import './step/selecionar_o_alimento_carne_para_excluir.dart';
import './step/confirmar_a_exclusao_do_alimento.dart';
import './step/acessar_a_aba_de_exercicios.dart';
import './step/acionar_a_opcao_de_adicionar_exercicios.dart';
import './step/adicionar_o_exercicio_musculacao_com200_calorias.dart';
import './step/sera_exibido_o_exercicio_musculacao.dart';
import './step/tenha_o_exercicio_musculacao_adicionado.dart';
import './step/selecionar_o_exercicio_musculacao_para_editar.dart';
import './step/editar_o_nome_para_corrida.dart';
import './step/sera_exibido_o_exercicio_corrida.dart';
import './step/nao_sera_exibido_o_exercicio_musculacao.dart';
import './step/selecionar_o_exercicio_musculacao_para_excluir.dart';
import './step/confirmar_a_exclusao_do_exercicio.dart';
import './step/acessar_a_aba_de_metas.dart';
import './step/acionar_a_opcao_de_adicionar_metas.dart';
import './step/adicionar_a_meta_diaria_de3000_calorias.dart';
import './step/sera_exibida_a_meta_diaria.dart';
import './step/tenha_a_meta_diaria_de3000_calorias_adicionada.dart';
import './step/selecionar_a_meta_diaria_para_editar.dart';
import './step/editar_a_quantidade_de_calorias_para4000.dart';
import './step/sera_exibida_a_meta_de4000_calorias.dart';
import './step/selecionar_a_meta_diaria_para_excluir.dart';
import './step/confirmar_a_exclusao_da_meta.dart';
import './step/nao_sera_exibida_a_meta_de3000_calorias.dart';
import './step/adicionar_uma_refeicao_de1000_calorias.dart';
import './step/a_meta_sera_atualizada_exibindo_as_calorias_consumidas.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await queEuAcesseOApp(tester);
    await facaLoginComEmail(tester);
  }

  group('''Gerenciar alimentos consumidos''', () {
    testWidgets('''Validar adição de refeição consumida''', (tester) async {
      await bddSetUp(tester);
      await acionarAOpcaoDeAdicionarAlimento(tester);
      await adicionarOAlimentoCarneCom200Calorias(tester);
      await seraExibidoOAlimentoCarne(tester);
    });
    testWidgets('''Validar edição de refeição adicionada''', (tester) async {
      await bddSetUp(tester);
      await tenhaOAlimentoCarneAdicionado(tester);
      await selecionarOAlimentoCarneParaEditar(tester);
      await editarONomeParaMacarrao(tester);
      await seraExibidoOAlimentoMacarrao(tester);
      await naoSeraExibidoOAlimentoCarne(tester);
    });
    testWidgets('''Validar exclusão de refeição adicionada''', (tester) async {
      await bddSetUp(tester);
      await tenhaOAlimentoCarneAdicionado(tester);
      await selecionarOAlimentoCarneParaExcluir(tester);
      await confirmarAExclusaoDoAlimento(tester);
      await naoSeraExibidoOAlimentoCarne(tester);
    });
  });
  group('''Gerenciar exercícios realizados''', () {
    testWidgets('''Validar a adição de exercícios realizados''',
        (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeExercicios(tester);
      await acionarAOpcaoDeAdicionarExercicios(tester);
      await adicionarOExercicioMusculacaoCom200Calorias(tester);
      await seraExibidoOExercicioMusculacao(tester);
    });
    testWidgets('''Validar edição de exercicio adicionado''', (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeExercicios(tester);
      await tenhaOExercicioMusculacaoAdicionado(tester);
      await selecionarOExercicioMusculacaoParaEditar(tester);
      await editarONomeParaCorrida(tester);
      await seraExibidoOExercicioCorrida(tester);
      await naoSeraExibidoOExercicioMusculacao(tester);
    });
    testWidgets('''Validar exclusão de exercicio adicionado''', (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeExercicios(tester);
      await tenhaOExercicioMusculacaoAdicionado(tester);
      await selecionarOExercicioMusculacaoParaExcluir(tester);
      await confirmarAExclusaoDoExercicio(tester);
      await naoSeraExibidoOExercicioMusculacao(tester);
    });
  });
  group('''Gerenciar metas de consumo de calorias''', () {
    testWidgets('''Validar criação de meta de consumo de calorias''',
        (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeMetas(tester);
      await acionarAOpcaoDeAdicionarMetas(tester);
      await adicionarAMetaDiariaDe3000Calorias(tester);
      await seraExibidaAMetaDiaria(tester);
    });
    testWidgets('''Validar edição de meta criada''', (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeMetas(tester);
      await tenhaAMetaDiariaDe3000CaloriasAdicionada(tester);
      await selecionarAMetaDiariaParaEditar(tester);
      await editarAQuantidadeDeCaloriasPara4000(tester);
      await seraExibidaAMetaDe4000Calorias(tester);
    });
    testWidgets('''Validar exclusão de meta adicionada''', (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeMetas(tester);
      await tenhaAMetaDiariaDe3000CaloriasAdicionada(tester);
      await selecionarAMetaDiariaParaExcluir(tester);
      await confirmarAExclusaoDaMeta(tester);
      await naoSeraExibidaAMetaDe3000Calorias(tester);
    });
    testWidgets('''Validar atualização da meta criada''', (tester) async {
      await bddSetUp(tester);
      await acessarAAbaDeMetas(tester);
      await tenhaAMetaDiariaDe3000CaloriasAdicionada(tester);
      await adicionarUmaRefeicaoDe1000Calorias(tester);
      await aMetaSeraAtualizadaExibindoAsCaloriasConsumidas(tester);
    });
  });
}
