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

  testWidgets('HomeScreen UI', (WidgetTester tester) async {
    // Build the app and inject the Main widget
    await tester.pumpWidget(const MaterialApp(
      home: LibraryMQ(),
    ));

    // Verify if the app bar title is rendered
    expect(find.text('LibraryMQ'), findsOneWidget);

    // Verify if the refresh indicator is rendered
    expect(find.byType(RefreshIndicator), findsOneWidget);

    // Verify if the current booking section is rendered
    expect(find.text('Current Booking:'), findsOneWidget);
  });
}
