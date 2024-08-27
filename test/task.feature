Feature: Gerenciar alimentos consumidos

  Background:
  Given que eu acesse o app
  And faça login com email

	Scenario: Adicionar nova refeição
  And acionar a opção de adicionar alimento
  When adicionar o alimento carne com 200 calorias
  Then será exibido o alimento carne

  Scenario: Editar refeição adicionada
  And tenha o alimento carne adicionado
  And selecionar o alimento carne para editar 
  When editar o nome para macarrao
  Then será exibido o alimento macarrao
  And não será exibido o alimento carne

  Scenario: Excluir refeição adicionada
  And tenha o alimento carne adicionado
  And selecionar o alimento carne para excluir 
  When confirmar a exclusão do alimento
  Then não será exibido o alimento carne