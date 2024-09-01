import 'package:CalorieCheck/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Usage: que eu acesse o app
Future<void> queEuAcesseOApp(WidgetTester tester) async {
  //Inicializar o app
  await tester.pumpWidget(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  await tester.pumpAndSettle();
}
