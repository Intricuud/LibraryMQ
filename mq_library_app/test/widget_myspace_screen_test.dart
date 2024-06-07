import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mq_library_app/app_screen/app_myspace_screen.dart';
import 'package:mq_library_app/models/booking_model.dart';
import 'package:mq_library_app/widget/widget_full_room.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('MySpaceScreen UI', (WidgetTester tester) async {
    // Build our MySpaceScreen widget.
    await tester.pumpWidget(const MaterialApp(home: MySpaceScreen()));

    // Verify that the CircularProgressIndicator is shown while data is loading.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Verify if the app bar title is rendered
    expect(find.text('My Space'), findsOneWidget);

    // Simulate the FutureBuilder's behavior by providing the data.
    await tester.pump();
    final futureBuilderFinder = find.byKey(const Key("bookingbuilder"));
    expect(futureBuilderFinder, findsOneWidget);
    await tester.pump();
  });
}
