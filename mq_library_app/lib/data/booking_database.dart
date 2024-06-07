import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mq_library_app/models/booking_model.dart';

class BookingDatabase {
  // Declaring Database instance
  static Database? _database;
  static const String dbName = 'library_bookings.db';
  static const String bookingTable = 'bookings';

  // Singleton pattern to ensure only one instance of the database is created
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> initDatabase() async {
    // Get the directory path for storing the database
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, dbName);

    // Open/create the database at a given path
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // Create the bookings table
      await db.execute('''
        CREATE TABLE $bookingTable (
          id TEXT PRIMARY KEY,
          roomText TEXT,
          startDate TEXT,
          endDate TEXT
        )
      ''');
    });
  }

  // Insert a booking into the database
  static Future<int> insertBooking(LibraryBooking booking) async {
    final db = await database;
    return await db.insert(bookingTable, booking.toMap());
  }

  // Get all bookings from the database
  static Future<List<LibraryBooking>> getBookings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(bookingTable);
    return List.generate(maps.length, (i) {
      return LibraryBooking(
        id: maps[i]['id'],
        roomText: maps[i]['roomText'],
        startDate: DateTime.parse(maps[i]['startDate']),
        endDate: DateTime.parse(maps[i]['endDate']),
      );
    });
  }

  // Getter method that takes in the BookingID and return the Library Booking Object
  static Future<LibraryBooking> getBooking(String bookingId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      bookingTable,
      where: 'id = ?',
      whereArgs: [bookingId],
    );
    if (maps.isNotEmpty) {
      return LibraryBooking(
        id: maps[0]['id'],
        roomText: maps[0]['roomText'],
        startDate: DateTime.parse(maps[0]['startDate']),
        endDate: DateTime.parse(maps[0]['endDate']),
      );
    } else {
      throw Exception("Booking not found");
    }
  }

  // Delete a booking from the database
  static Future<int> deleteBooking(String id) async {
    final db = await database;
    return await db.delete(bookingTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateBooking(LibraryBooking booking) async {
    final db = await database;
    return await db.update(
      bookingTable,
      booking.toMap(),
      where: 'id = ?',
      whereArgs: [booking.id],
    );
  }
}
