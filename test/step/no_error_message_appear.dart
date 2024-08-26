import 'package:flutter_test/flutter_test.dart';

/// Usage: no error message appear
Future<void> noErrorMessageAppear(WidgetTester tester) async {
  throw UnimplementedError();
}
