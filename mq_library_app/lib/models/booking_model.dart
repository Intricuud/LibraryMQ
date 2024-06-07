import 'package:uuid/uuid.dart';

const uuid = Uuid();

class LibraryBooking {
  // Data model for the booking
  // Declare what is needed for the data
  LibraryBooking({
    required this.id,
    required this.roomText,
    required this.startDate,
    required this.endDate,
  });

  final String id;
  final String roomText;
  final DateTime startDate;
  final DateTime endDate;

  // create a booking from parsed JSON data
  factory LibraryBooking.fromJson(Map<String, dynamic> json) {
    return LibraryBooking(
      id: uuid.v4(),
      roomText: json['room'] as String,
      startDate: DateTime.parse(json['start'] as String),
      endDate: DateTime.parse(json['end'] as String),
    );
  }

  // Convert a LibraryBooking object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomText': roomText,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  // Method to sort bookings by date
  static List<LibraryBooking> sortByDate(List<LibraryBooking> bookings) {
    bookings.sort((a, b) => a.startDate.compareTo(b.startDate));
    return bookings;
  }
}
