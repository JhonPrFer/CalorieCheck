import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: acessar a aba de metas
Future<void> acessarAAbaDeMetas(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.flag));
}
