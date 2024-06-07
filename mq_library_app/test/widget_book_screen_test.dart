import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mq_library_app/app_screen/app_book_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('BookingScreen Functionality and UI',
      (WidgetTester tester) async {
    // Build our BookingScreen widget.
    await tester.pumpWidget(MaterialApp(home: BookingScreen()));

    // Find the "Book" button.
    final bookButton = find.byKey(Key('BookButton'));
    expect(bookButton, findsOneWidget);

    // Verify that initially, no booking is made.
    expect(find.text('Select Room:'), findsOneWidget);
    expect(find.text('Select Start Date and Time:'), findsOneWidget);
    expect(find.text('Select End Date and Time:'), findsOneWidget);

    // Tap on the "Book" button.
    await tester.tap(bookButton);
    await tester.pump();

    
  });
}
