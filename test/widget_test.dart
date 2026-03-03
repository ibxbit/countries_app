import 'package:flutter_test/flutter_test.dart';
import 'package:countries_app/main.dart';

void main() {
  testWidgets('App should load', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
