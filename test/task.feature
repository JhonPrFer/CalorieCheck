Feature: See lists of foods, exercises and calories

	Scenario: See list of foods success

    Given the app is running
      And my list of food has some item registered
      And the total of calories is {"2000"} kcal

    When I click on the button {"list of foods"}
      And a list with the registered foods is shown
      And the food {"Feijão"}  is added to the list
      And {"Feijão"} has 100 kcal
    Then {"Feijão"} is displayed on the list top 
      And the calories total is {"2100"} Kcal


	Scenario: See list of exercises success

    Given the app is running
      And my list of exercises has some item registered
      And the total of calories is {"2100"} kal

    When I click on the button {"list of exercises"}
      And a list with the registered exercises is shown
      And the exercise {"Polichinelo"}  is added to the list
      And {"Polichinelo"} burns {"600"} kcal
    Then {"Polichinelo"} is displayed on the list top 
      And the calories total is {"1500"} Kcal

  Scenario: See list of foods fail
 
    Given the app is running
      And my list of foods is empty

    When I click on the button {"Lista de alimentos"}
    Then the next message is displayed: {"A lista está vazia"}
      And the calories total is 0 kcal

  Scenario: See list of exercises fail
 
    Given the app is running
      And my list of exercises is empty

    When I click on the button {"Lista de Exercícios"}
    Then the next message is displayed: {"A lista está vazia"}
      And the calories total is {"0"} Kcal


Feature: Register meals and their calories

  Scenario: Register meal with blank name
    Given I am on the meal registration screen of the CalorieCheck app
    When I attempt to register meal {" "}
    Then the app doesn"t register meal {" "} on the list
      And shows a message saying {"Nome da refeição não pode estar em branco"}

  Scenario: Register meal with blank calorie count
    Given I am on the meal registration screen of the CalorieCheck app
    When I attempt to register meal {"feijoada"} with calorie count {" "}
    Then the app doesn"t register meal {"feijoada"} on the list
      And shows a message saying {"Quantidade de calorias não pode estar em branco"}

  Scenario: Register negative calorie count
    Given I am on the meal registration screen of the CalorieCheck app
    When I attempt to register meal {"feijoada"} with calorie count {"-3"}
    Then the app doesn"t register meal {"feijoada"} on the list
      And shows a message saying {"A quantia de calorias deve ser um número positivo"}

  Scenario: Register meals with the same name and value
    Given I am on the meal registration screen of the CalorieCheck app
      And a meal named {"feijoada"} with a calorie count of {"100"} is already registered
    When I register another meal with the name {"feijoada"} and a calorie count of {"100"}
    Then the app registers the meal successfully
      And displays both instances of {"feijoada"} with a calorie count of {"100"} in the meal list

  
Feature: Calorie Goal Management

  Scenario: Create a daily calorie goal
    Given the app is running
    	And I have not set a daily calorie goal
    When I navigate to the home page
    Then the page should display a button labeled {“Criar Meta de Calorias"}
    When I click on the {"Criar Meta de Calorias"} button
      And I set the daily calorie goal to {"2500 calorias"}
    Then my daily calorie goal should be set to {"2500 calorias"}
   	  And my daily calorie goal should be displayed on the home page

  Scenario: Daily calorie goal is already set
    Given the app is running
   	  And I have set a daily calorie goal of {"2500 calorias"}
    When I navigate to the home page
    Then the page should display my daily calorie goal as {"2500 calorias"}
   	  And the {"Criar Meta de Calorias"} button should not be visible

Feature: Weekly report

  Scenario: Functional report
    Given the app is running
      And I have registered calories in the last 7 days
    When I open the {“report”} tab
    Then the days I have registered calories should show the total number given
      And I should see a comparison of the consumed calories and the planned calories in the report

  Scenario: Empty days
  Given the app is running
  When I open the {“report”} tab 
    And I haven’t registered calories in a previous day
  Then this day should show {“0 calories”} text

Feature: Edit list items

  Scenario: Edit an entry and cancel the edit
    Given the app is running
      And I add a food {"Maçã"} with calories {"100"}
    When I start editing the food {"Maçã"} with calories {"100"} to {"Banana"} with calories {"90"}
      And I cancel the editing
    Then I see {"Maçã"} with calories {"100"} in the list

  Scenario: Prevent editing an entry to an empty value
    Given the app is running
      And I add a food {"Maçã"} with calories {"100"}
    When I try to edit the food {"Maçã"} with calories {"100"} to {""} with calories {""}
    Then I see a message {"Nome da comida e a quantidade de calorias não pode ser vazia."}
      And I see {"Maçã"} with calories {"100"} in the list

Feature: Remove item confirmed

  Scenario: remove item from list
    Given the app is running
      And the meal {'arroz'} is in the list
    When I click on {"arroz"} and click trash icon 
    Then I see {"confirma deleção?"} 
      And I click on the {"yes"} button
      And I don't see {"arroz"} in the list

  Feature: Remove item not confirmed

    Scenario: remove item from list
    Given the app is running
      And the meal {'arroz'} is in the list
    When I click on {"arroz"} and click trash icon 
    Then I should see {"confirma deleção?"} 
      And I click on the {“no”} button
      And is shown a list with {“arroz”} in it

  Feature: Offline app
    Scenario: see app offline
      Given the app is running
      When no internet connection
      Then show {"sem conexão com a internet"} 
        And I click {"ok"}
      Then no error message appear