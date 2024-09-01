Feature: Gerenciar alimentos consumidos

  Background:
  Given que eu acesse o app
  And faça login com email

	Scenario: Validar adição de refeição consumida
  And acionar a opção de adicionar alimento
  When adicionar o alimento carne com 200 calorias
  Then será exibido o alimento carne

  Scenario: Validar edição de refeição adicionada
  And tenha o alimento carne adicionado
  And selecionar o alimento carne para editar 
  When editar o nome para macarrao
  Then será exibido o alimento macarrao
  And não será exibido o alimento carne

  Scenario: Validar exclusão de refeição adicionada
  And tenha o alimento carne adicionado
  And selecionar o alimento carne para excluir 
  When confirmar a exclusão do alimento
  Then não será exibido o alimento carne

Feature: Gerenciar exercícios realizados

  Scenario: Validar a adição de exercícios realizados
  And acessar a aba de exercícios
  And acionar a opção de adicionar exercícios
  When adicionar o exercicio musculação com 200 calorias
  Then será exibido o exercicio musculação

  Scenario: Validar edição de exercicio adicionado
  And acessar a aba de exercícios
  And tenha o exercicio musculação adicionado
  And selecionar o exercicio musculação para editar 
  When editar o nome para corrida
  Then será exibido o exercicio corrida
  And não será exibido o exercicio musculação

  Scenario: Validar exclusão de exercicio adicionado
  And acessar a aba de exercícios
  And tenha o exercicio musculação adicionado
  And selecionar o exercicio musculação para excluir 
  When confirmar a exclusão do exercicio
  Then não será exibido o exercicio musculação

Feature: Gerenciar metas de consumo de calorias

  Scenario: Validar criação de meta de consumo de calorias
  And acessar a aba de metas
  And acionar a opção de adicionar metas
  When adicionar a meta diaria de 3000 calorias
  Then será exibida a meta diaria

  Scenario: Validar edição de meta criada
  And acessar a aba de metas
  And tenha a meta diaria de 3000 calorias adicionada
  And selecionar a meta diaria para editar 
  When editar a quantidade de calorias para 4000
  Then será exibida a meta de 4000 calorias

  Scenario: Validar exclusão de meta adicionada
  And acessar a aba de metas
  And tenha a meta diaria de 3000 calorias adicionada
  And selecionar a meta diaria para excluir 
  When confirmar a exclusão da meta
  Then não será exibida a meta de 3000 calorias

  Scenario: Validar atualização da meta criada
  And acessar a aba de metas
  And tenha a meta diaria de 3000 calorias adicionada
  When adicionar uma refeição de 1000 calorias
  Then a meta será atualizada exibindo as calorias consumidas