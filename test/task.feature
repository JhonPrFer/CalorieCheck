Feature: See lists of foods, exercises and calories

	Scenario: See list success

    Given the app is running 
      And the user’s list have some item registered

    When I click on the button with the list name 
    Then the list {"day 13/08"} should open
      And I should see the list items

    When I add {"Apple"} to the list 
    Then it’s displayed on the list top  

    When a new food is added to the list
    Then the calories total is increased

    When a new exercise is added to the list
    Then the calories total is decreased

  Scenario: See list fail
 
    Given the app is running and the user’s lists are empty
    When the user click on the button with the list name 
	  Then the message {"A lista está vazia "} is displayed


Feature: Register meals and their calories

  Scenario: Register meal or calorie with blank name or calorie count
    Given I am on the meal registration screen of the CalorieCheck app
    When I attempt to register {"Apple"} with a blank name or calorie count
    Then the list remains empty after registration attempt
      And shows a message saying {"Nome e quantia de calorias não podem estar em branco"}

  Scenario: Register negative calorie count
    Given I am on the meal registration screen of the CalorieCheck app
    When I enter a negative calorie count of { '-3'}
    Then the app prevents the meal from being registered
      And shows a message saying "A quantia de calorias deve ser um número positivo"

  Scenario: Register meals with the same name and value
    Given I am on the meal registration screen of the CalorieCheck app
      And a meal named {"feijoada"} with a calorie count of {'100'} is already registered
    When I register another meal with the name {"feijoada"} and a calorie count of {'100'}
    Then the app registers the meal successfully
      And displays both instances of {"feijoada"} with a calorie count of {'100'} in the meal list


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
    When I open the {"report"} tab
    Then the days I have registered calories should show the total number given
      And I should see a comparison of the consumed calories and the planned calories in the report

  Scenario: Empty days
    Given the app is running
    When I open the {"report"} tab and I haven’t registered calories in a previous day
    Then this day should show {"0 calories"} text


Feature: Weekly Calorie Report

  Scenario: I view a weekly calorie report
    Given the app is running
   	 And I have consumed calories over the past week
    When I navigate to the weekly calorie report page
    Then I should see a report showing my daily calorie consumption for the past 7 days
    	And any data from 8 days ago or earlier should not be shown
    	And even if I did not register my calorie intake on some days, the report should still display the registered data for the last 7 days
    	And the report should compare my planned daily calorie goals with the calories I consumed

  Scenario: I view a weekly calorie report with missing data
    Given the app is running
   	 And I have not registered calories every day in the past week
    When I navigate to the weekly calorie report page
    Then I should see the report for the past 7 days showing only the days with registered calorie intake
   	 And the report should display the comparison between my planned calories and the consumed calories for those days

Feature: Remove items

	Scenario: remove item from list
    Given the app is running
      And I add a item {"arroz"}
    When i click on {"arroz"} and click trash icon 
    Then show {"confirma deleção?"} 
      And i click {"yes"}
    Then I don't see {"arroz"} 
      And i click {"no"} 
    Then show list

Feature: Offline app
  Scenario: see app offline
    Given the app is running
    When no internet connection
    Then show {"sem conexão com a internet"} 
      And i click {"ok"}
    Then no error message appear
