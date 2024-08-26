// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/a_list_with_the_registered_exercises_is_shown.dart';
import './step/a_list_with_the_registered_foods_is_shown.dart';
import './step/a_meal_named_with_a_calorie_count_of_is_already_registered.dart';
import './step/burns_kcal.dart';
import './step/displays_both_instances_of_with_a_calorie_count_of_in_the_meal_list.dart';
import './step/has100_kcal.dart';
import './step/i_add_a_food_with_calories.dart';
import './step/i_am_on_the_meal_registration_screen_of_the_caloriecheck_app.dart';
import './step/i_attempt_to_register_meal.dart';
import './step/i_attempt_to_register_meal_with_calorie_count.dart';
import './step/i_cancel_the_editing.dart';
import './step/i_click.dart';
import './step/i_click_on_and_click_trash_icon.dart';
import './step/i_click_on_the_button.dart';
import './step/i_dont_see_in_the_list.dart';
import './step/i_have_not_set_a_daily_calorie_goal.dart';
import './step/i_have_registered_calories_in_the_last7_days.dart';
import './step/i_have_set_a_daily_calorie_goal_of.dart';
import './step/i_havent_registered_calories_in_a_previous_day.dart';
import './step/i_navigate_to_the_home_page.dart';
import './step/i_open_the_tab.dart';
import './step/i_register_another_meal_with_the_name_and_a_calorie_count_of.dart';
import './step/i_see.dart';
import './step/i_see_a_message.dart';
import './step/i_see_with_calories_in_the_list.dart';
import './step/i_set_the_daily_calorie_goal_to.dart';
import './step/i_should_see.dart';
import './step/i_should_see_a_comparison_of_the_consumed_calories_and_the_planned_calories_in_the_report.dart';
import './step/i_start_editing_the_food_with_calories_to_with_calories.dart';
import './step/i_try_to_edit_the_food_with_calories_to_with_calories.dart';
import './step/is_displayed_on_the_list_top.dart';
import './step/is_shown_a_list_with_in_it.dart';
import './step/my_daily_calorie_goal_should_be_displayed_on_the_home_page.dart';
import './step/my_daily_calorie_goal_should_be_set_to.dart';
import './step/my_list_of_exercises_has_some_item_registered.dart';
import './step/my_list_of_exercises_is_empty.dart';
import './step/my_list_of_food_has_some_item_registered.dart';
import './step/my_list_of_foods_is_empty.dart';
import './step/no_error_message_appear.dart';
import './step/no_internet_connection.dart';
import './step/show.dart';
import './step/shows_a_message_saying.dart';
import './step/the_app_doesnt_register_meal_on_the_list.dart';
import './step/the_app_is_running.dart';
import './step/the_app_registers_the_meal_successfully.dart';
import './step/the_button_should_not_be_visible.dart';
import './step/the_calories_total_is0_kcal.dart';
import './step/the_calories_total_is_kcal.dart';
import './step/the_days_i_have_registered_calories_should_show_the_total_number_given.dart';
import './step/the_exercise_is_added_to_the_list.dart';
import './step/the_food_is_added_to_the_list.dart';
import './step/the_meal_is_in_the_list.dart';
import './step/the_next_message_is_displayed.dart';
import './step/the_page_should_display_a_button_labeled.dart';
import './step/the_page_should_display_my_daily_calorie_goal_as.dart';
import './step/the_total_of_calories_is_kal.dart';
import './step/the_total_of_calories_is_kcal.dart';
import './step/this_day_should_show_text.dart';

void main() {
  group('''See lists of foods, exercises and calories''', () {
    testWidgets('''See list of foods success''', (tester) async {
      await theAppIsRunning(tester);
      await myListOfFoodHasSomeItemRegistered(tester);
      await theTotalOfCaloriesIsKcal(tester, '2000');
      await iClickOnTheButton(tester, 'list of foods');
      await aListWithTheRegisteredFoodsIsShown(tester);
      await theFoodIsAddedToTheList(tester, 'Feijão');
      await has100Kcal(tester, 'Feijão');
      await isDisplayedOnTheListTop(tester, 'Feijão');
      await theCaloriesTotalIsKcal(tester, '2100');
    });
    testWidgets('''See list of exercises success''', (tester) async {
      await theAppIsRunning(tester);
      await myListOfExercisesHasSomeItemRegistered(tester);
      await theTotalOfCaloriesIsKal(tester, '2100');
      await iClickOnTheButton(tester, 'list of exercises');
      await aListWithTheRegisteredExercisesIsShown(tester);
      await theExerciseIsAddedToTheList(tester, 'Polichinelo');
      await burnsKcal(tester, 'Polichinelo', '600');
      await isDisplayedOnTheListTop(tester, 'Polichinelo');
      await theCaloriesTotalIsKcal(tester, '1500');
    });
    testWidgets('''See list of foods fail''', (tester) async {
      await theAppIsRunning(tester);
      await myListOfFoodsIsEmpty(tester);
      await iClickOnTheButton(tester, 'Lista de alimentos');
      await theNextMessageIsDisplayed(tester, 'A lista está vazia');
      await theCaloriesTotalIs0Kcal(tester);
    });
    testWidgets('''See list of exercises fail''', (tester) async {
      await theAppIsRunning(tester);
      await myListOfExercisesIsEmpty(tester);
      await iClickOnTheButton(tester, 'Lista de Exercícios');
      await theNextMessageIsDisplayed(tester, 'A lista está vazia');
      await theCaloriesTotalIsKcal(tester, '0');
    });
  });
  group('''Register meals and their calories''', () {
    testWidgets('''Register meal with blank name''', (tester) async {
      await iAmOnTheMealRegistrationScreenOfTheCaloriecheckApp(tester);
      await iAttemptToRegisterMeal(tester, ' ');
      await theAppDoesntRegisterMealOnTheList(tester, ' ');
      await showsAMessageSaying(
          tester, 'Nome da refeição não pode estar em branco');
    });
    testWidgets('''Register meal with blank calorie count''', (tester) async {
      await iAmOnTheMealRegistrationScreenOfTheCaloriecheckApp(tester);
      await iAttemptToRegisterMealWithCalorieCount(tester, 'feijoada', ' ');
      await theAppDoesntRegisterMealOnTheList(tester, 'feijoada');
      await showsAMessageSaying(
          tester, 'Quantidade de calorias não pode estar em branco');
    });
    testWidgets('''Register negative calorie count''', (tester) async {
      await iAmOnTheMealRegistrationScreenOfTheCaloriecheckApp(tester);
      await iAttemptToRegisterMealWithCalorieCount(tester, 'feijoada', '-3');
      await theAppDoesntRegisterMealOnTheList(tester, 'feijoada');
      await showsAMessageSaying(
          tester, 'A quantia de calorias deve ser um número positivo');
    });
    testWidgets('''Register meals with the same name and value''',
        (tester) async {
      await iAmOnTheMealRegistrationScreenOfTheCaloriecheckApp(tester);
      await aMealNamedWithACalorieCountOfIsAlreadyRegistered(
          tester, 'feijoada', '100');
      await iRegisterAnotherMealWithTheNameAndACalorieCountOf(
          tester, 'feijoada', '100');
      await theAppRegistersTheMealSuccessfully(tester);
      await displaysBothInstancesOfWithACalorieCountOfInTheMealList(
          tester, 'feijoada', '100');
    });
  });
  group('''Calorie Goal Management''', () {
    testWidgets('''Create a daily calorie goal''', (tester) async {
      await theAppIsRunning(tester);
      await iHaveNotSetADailyCalorieGoal(tester);
      await iNavigateToTheHomePage(tester);
      await thePageShouldDisplayAButtonLabeled(
          tester, 'Criar Meta de Calorias');
      await iClickOnTheButton(tester, 'Criar Meta de Calorias');
      await iSetTheDailyCalorieGoalTo(tester, '2500 calorias');
      await myDailyCalorieGoalShouldBeSetTo(tester, '2500 calorias');
      await myDailyCalorieGoalShouldBeDisplayedOnTheHomePage(tester);
    });
    testWidgets('''Daily calorie goal is already set''', (tester) async {
      await theAppIsRunning(tester);
      await iHaveSetADailyCalorieGoalOf(tester, '2500 calorias');
      await iNavigateToTheHomePage(tester);
      await thePageShouldDisplayMyDailyCalorieGoalAs(tester, '2500 calorias');
      await theButtonShouldNotBeVisible(tester, 'Criar Meta de Calorias');
    });
  });
  group('''Weekly report''', () {
    testWidgets('''Functional report''', (tester) async {
      await theAppIsRunning(tester);
      await iHaveRegisteredCaloriesInTheLast7Days(tester);
      await iOpenTheTab(tester, 'report');
      await theDaysIHaveRegisteredCaloriesShouldShowTheTotalNumberGiven(tester);
      await iShouldSeeAComparisonOfTheConsumedCaloriesAndThePlannedCaloriesInTheReport(
          tester);
    });
    testWidgets('''Empty days''', (tester) async {
      await theAppIsRunning(tester);
      await iOpenTheTab(tester, 'report');
      await iHaventRegisteredCaloriesInAPreviousDay(tester);
      await thisDayShouldShowText(tester, '0 calories');
    });
  });
  group('''Edit list items''', () {
    testWidgets('''Edit an entry and cancel the edit''', (tester) async {
      await theAppIsRunning(tester);
      await iAddAFoodWithCalories(tester, 'Maçã', '100');
      await iStartEditingTheFoodWithCaloriesToWithCalories(
          tester, 'Maçã', '100', 'Banana', '90');
      await iCancelTheEditing(tester);
      await iSeeWithCaloriesInTheList(tester, 'Maçã', '100');
    });
    testWidgets('''Prevent editing an entry to an empty value''',
        (tester) async {
      await theAppIsRunning(tester);
      await iAddAFoodWithCalories(tester, 'Maçã', '100');
      await iTryToEditTheFoodWithCaloriesToWithCalories(
          tester, 'Maçã', '100', '', '');
      await iSeeAMessage(tester,
          'Nome da comida e a quantidade de calorias não pode ser vazia.');
      await iSeeWithCaloriesInTheList(tester, 'Maçã', '100');
    });
  });
  group('''Remove item confirmed''', () {
    testWidgets('''remove item from list''', (tester) async {
      await theAppIsRunning(tester);
      await theMealIsInTheList(tester, 'arroz');
      await iClickOnAndClickTrashIcon(tester, 'arroz');
      await iSee(tester, 'confirma deleção?');
      await iClickOnTheButton(tester, 'yes');
      await iDontSeeInTheList(tester, 'arroz');
    });
  });
  group('''Remove item not confirmed''', () {
    testWidgets('''remove item from list''', (tester) async {
      await theAppIsRunning(tester);
      await theMealIsInTheList(tester, 'arroz');
      await iClickOnAndClickTrashIcon(tester, 'arroz');
      await iShouldSee(tester, 'confirma deleção?');
      await iClickOnTheButton(tester, 'no');
      await isShownAListWithInIt(tester, 'arroz');
    });
  });
  group('''Offline app''', () {
    testWidgets('''see app offline''', (tester) async {
      await theAppIsRunning(tester);
      await noInternetConnection(tester);
      await show(tester, 'sem conexão com a internet');
      await iClick(tester, 'ok');
      await noErrorMessageAppear(tester);
    });
  });
}
