import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mq_library_app/app_screen/app_map_screen.dart';

void main() {
  testWidgets('CampusMapScreen UI and Functionality',
      (WidgetTester tester) async {
    // Build and inject the campus map screen
    await tester.pumpWidget(const MaterialApp(
      home: CampusMapScreen(),
    ));

    // Verify if the app bar title is rendered
    expect(find.text('Map'), findsOneWidget);

    // Verify if the image is rendered
    expect(find.byType(Image), findsOneWidget);

    // Verify if the gesture detector is rendered
    expect(find.byType(GestureDetector), findsOneWidget);

    // Simulate scaling the map (zooming)
    final TestGesture gesture =
        await tester.startGesture(tester.getCenter(find.byType(Image)));
    await gesture.moveBy(const Offset(0.0, -50.0));
    await gesture.up();
    await tester.pumpAndSettle();

    // Verify if the map scales properly
    expect(
        tester
            .widget<GestureDetector>(find.byType(GestureDetector))
            .onScaleUpdate,
        isNotNull);
  });
}
