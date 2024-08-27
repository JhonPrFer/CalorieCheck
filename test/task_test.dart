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

void main() {
  group('''Gerenciar alimentos consumidos''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await queEuAcesseOApp(tester);
      await facaLoginComEmail(tester);
    }

    testWidgets('''Adicionar nova refeição''', (tester) async {
      await bddSetUp(tester);
      await acionarAOpcaoDeAdicionarAlimento(tester);
      await adicionarOAlimentoCarneCom200Calorias(tester);
      await seraExibidoOAlimentoCarne(tester);
    });
    testWidgets('''Editar refeição adicionada''', (tester) async {
      await bddSetUp(tester);
      await tenhaOAlimentoCarneAdicionado(tester);
      await selecionarOAlimentoCarneParaEditar(tester);
      await editarONomeParaMacarrao(tester);
      await seraExibidoOAlimentoMacarrao(tester);
      await naoSeraExibidoOAlimentoCarne(tester);
    });
    testWidgets('''Excluir refeição adicionada''', (tester) async {
      await bddSetUp(tester);
      await tenhaOAlimentoCarneAdicionado(tester);
      await selecionarOAlimentoCarneParaExcluir(tester);
      await confirmarAExclusaoDoAlimento(tester);
      await naoSeraExibidoOAlimentoCarne(tester);
    });
  });
}
