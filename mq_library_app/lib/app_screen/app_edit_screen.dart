import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_library_app/app_library.dart';
import 'package:mq_library_app/data/booking_database.dart';
import 'package:mq_library_app/models/booking_model.dart';

class EditScreen extends StatefulWidget {
  final String bookingId;

  const EditScreen({super.key, required this.bookingId});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late LibraryBooking booking;
  TextEditingController roomController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    _loadBooking();
  }

  // Function for fetching the booking
  Future<void> _loadBooking() async {
    final loadedBooking = await BookingDatabase.getBooking(widget.bookingId);
    setState(() {
      booking = loadedBooking;
      roomController.text = booking.roomText;
      startDate = booking.startDate;
      endDate = booking.endDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(393, 156),
        child: Container(
          width: 393,
          height: 156,
          color: theme.appBarTheme.backgroundColor,
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              // Title for Edit Screen
              child: Text(
                'Edit Booking',
                key: Key("Edit Title"),
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
            leading: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: IconButton(
                color: theme.primaryColor,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 32,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 330,
          height: 519,
          decoration: ShapeDecoration(
            color: theme.primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the Text field where the user can make change to the name of the room
                TextField(
                  controller: roomController,
                  decoration: InputDecoration(
                    labelText: 'Room',
                    labelStyle: theme.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Here user can change their date for starting date
                  // the data is also conveniently pre-filled for the user
                  children: [
                    Text(
                      'Select New Start Date:',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      key: Key("StartDateButton"),
                      onPressed: () => _selectStartDate(context),
                      child: Text(startDate != null
                          ? DateFormat('dd/MM/yyyy HH:mm').format(startDate!)
                          : 'Select New Start Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Here user can change their date for ending date
                // the data is also conveniently pre-filled for the user
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select New End Date:',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      key: Key("EndDateButton"),
                      onPressed: () => _selectEndDate(context),
                      child: Text(endDate != null
                          ? DateFormat('dd/MM/yyyy HH:mm').format(endDate!)
                          : 'Select New End Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Button for Cancel which will pop the user back to myspace
                    ElevatedButton(
                      key: Key("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    // Button for Update which will invoke the _updateBooking
                    ElevatedButton(
                      key: Key("Update"),
                      onPressed: _updateBooking,
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function for supporting the selection of the start date
  void _selectStartDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(startDate ?? DateTime.now()),
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
  }

  // Function for supporting the selection of the end date
  void _selectEndDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(endDate ?? DateTime.now()),
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
  }

  // This function will update the booking when the user pressed update
  void _updateBooking() async {
    final newRoom = roomController.text;

    if (newRoom.isNotEmpty && startDate != null && endDate != null) {
      final updatedBooking = LibraryBooking(
        id: booking.id,
        roomText: newRoom,
        startDate: startDate!,
        endDate: endDate!,
      );

      await BookingDatabase.updateBooking(updatedBooking);

      // Navigate back to the home page with the necessary parameters
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LibraryMQ()
            // No action required for toggleDarkMode
            ),
      );
    } else {
      print('Please fill in all fields.');
    }
  }
}
