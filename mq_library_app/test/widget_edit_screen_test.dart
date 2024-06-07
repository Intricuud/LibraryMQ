import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mq_library_app/app_screen/app_edit_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {

  sqfliteFfiInit();

  // Set databaseFactory to databaseFactoryFfi
  databaseFactory = databaseFactoryFfi;

  testWidgets('Edit Screen UI and Functionality',
      (WidgetTester tester) async {
    // Build our EditScreen widget.
    await tester.pumpWidget(const MaterialApp(home: EditScreen(bookingId: '1')));

    // Verify that the necessary UI elements are present.
    expect(find.text('Edit Booking'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(4));

    // Find the text box and type Room 1
    await tester.tap(find.byType(TextField));
    await tester
        .pump(); 
    await tester.enterText(find.byType(TextField), 'Room 1');

    // Picked the start date
    await tester.tap(find.byKey(const Key("StartDateButton")));
    await tester.pumpAndSettle(); 

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    // Picked the end date
    await tester.tap(find.byKey(const Key("EndDateButton")));
    await tester.pumpAndSettle(); 

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 
    // Tap the "Cancel" button
    await tester.tap(find.byKey(const Key("Cancel")));
    await tester.pumpAndSettle(); 
  });
}
