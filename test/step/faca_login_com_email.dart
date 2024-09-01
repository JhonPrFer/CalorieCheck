import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: faça login com email
Future<void> facaLoginComEmail(WidgetTester tester) async {
  // Clicar no botão de login com email
  await tester.tap(find.byIcon(Icons.email));
}
