import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_library_app/data/booking_database.dart';
import 'package:mq_library_app/models/booking_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Variables to store selected room, start date, and end date
  String? selectedRoom;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(393, 156),
        child: Container(
          width: 393,
          height: 156,
          color: theme.appBarTheme.backgroundColor,
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              // The title of the screen book
              child: Text(
                'Book',
                key: const Key('Title'),
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor,
                ),
              ),
            ),
            backgroundColor: theme.appBarTheme.backgroundColor,
            elevation: 0,
            iconTheme: theme.iconTheme,
          ),
        ),
      ),
      body: Center(
        // Added SingleChildScrollView to prevent overflowing vertically
        child: SingleChildScrollView(
          child: Container(
            width: 330,
            height: 519,
            decoration: ShapeDecoration(
              color: theme.primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text for selecting room
                  Text(
                    'Select Room:',
                    style: TextStyle(
                        fontSize: 16, color: theme.textTheme.bodyLarge?.color),
                  ),
                  SizedBox(
                    // Drop down menu for each different room
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DropdownButton<String>(
                        key: const Key("RoomDropDown"),
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Library Floor G D134',
                            child: Text('Library Floor G D134'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Library Floor 1 B116',
                            child: Text('Library Floor 1 B116'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Library Floor 2 A202',
                            child: Text('Library Floor 2 A202'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Library Floor 3 C32',
                            child: Text('Library Floor 3 C32'),
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedRoom = value;
                          });
                        },
                        value: selectedRoom,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select Start Date and Time:',
                    style: TextStyle(
                        fontSize: 16, color: theme.textTheme.bodyLarge?.color),
                  ),
                  // User can pick date and time here for the starting date
                  ElevatedButton(
                    key: Key("StartDateButton"),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            startDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text(
                      startDate != null
                          ? '${startDate!.day}/${startDate!.month}/${startDate!.year} ${startDate!.hour}:${startDate!.minute}'
                          : 'Select Start Date and Time',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select End Date and Time:',
                    style: TextStyle(
                        fontSize: 16, color: theme.textTheme.bodyLarge?.color),
                  ),
                  // User can pick date and time here for the ending date
                  ElevatedButton(
                    key: Key("EndDateButton"),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            endDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text(endDate != null
                        ? '${endDate!.day}/${endDate!.month}/${endDate!.year} ${endDate!.hour}:${endDate!.minute}'
                        : 'Select End Date and Time'),
                  ),
                  // Text button for book
                  // When user pressed book the application
                  // will create a new instance of LibraryBooking and add it
                  // into the Database
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Validate and save booking
                      if (selectedRoom != null &&
                          startDate != null &&
                          endDate != null) {
                        final booking = LibraryBooking(
                          id: uuid.v4(),
                          roomText: selectedRoom!,
                          startDate: startDate!,
                          endDate: endDate!,
                        );
                        await BookingDatabase.insertBooking(
                            booking); // Insert booking into the database
                        setState(() {
                          // Clear fields after booking is saved
                          selectedRoom = null;
                          startDate = null;
                          endDate = null;
                        });
                      } else {
                        // Show error message or handle invalid input
                        Text('Please select room, start date, and end date.');
                      }
                    },
                    child: const Text('Book'),
                    key: Key("BookButton"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
