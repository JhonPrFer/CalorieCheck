import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// Usage: acessar a aba de exercícios
Future<void> acessarAAbaDeExercicios(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.fitness_center));
}
