import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mq_library_app/app_library.dart';
import 'package:mq_library_app/app_screen/app_home_screen.dart';

class MockDatabaseFactory extends Mock implements DatabaseFactory {}

void main() {
  // Initialize sqflite ffi database factory before running the tests
  sqfliteFfiInit();

  // Set databaseFactory to databaseFactoryFfi
  databaseFactory = databaseFactoryFfi;

  testWidgets('Booking Test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MaterialApp(
      home: LibraryMQ(),
    ));

    // Verify if the app bar title is rendered
    expect(find.text('LibraryMQ'), findsOneWidget);

    // Verify if the current booking section is rendered
    expect(find.text('Current Booking:'), findsOneWidget);

    // Tap the bottom tab navigation to book
    await tester.tap(find.text("Book"));
    await tester.pumpAndSettle();

    // Tap the drop down button
    await tester.tap(find.byKey(Key("RoomDropDown")));
    await tester.pumpAndSettle(); // Wait for the drop-down menu to appear

    // Choose the Library Floor G D134 as the entry
    await tester.tap(find.text('Library Floor G D134').last);
    await tester.pumpAndSettle(); // Wait for the selection to be processed

    // Check if the selection has reflected correctly
    expect(find.text('Library Floor G D134'), findsOneWidget);

    // Select the default starting date
    await tester.tap(find.byKey(Key("StartDateButton")));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    // Select the default ending date
    await tester.tap(find.byKey(Key("EndDateButton")));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(); 

    // Check and find for book button
    expect(find.byKey(Key("BookButton")), findsOneWidget);

    // Tap on book button to complete the booking step
    await tester.tap(find.byKey(Key("BookButton")));
    await tester.pumpAndSettle();
  });
}
