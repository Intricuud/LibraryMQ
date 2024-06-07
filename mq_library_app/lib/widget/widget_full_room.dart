import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_library_app/app_screen/app_edit_screen.dart';
import 'package:mq_library_app/models/booking_model.dart';

class FullLibraryRoom extends StatelessWidget {
  final LibraryBooking bookingnum;

  const FullLibraryRoom({super.key, required this.bookingnum});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 330,
      height: 400,
      child: Stack(
        children: [
          Container(
            width: 330,
            height: 400,
            decoration: BoxDecoration(
              color: theme.primaryColorDark,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 330,
              height: 218,
              // Displaying image for the library
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/study_room.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 36,
            top: 251,
            child: SizedBox(
              width: 260,
              height: 24,
              // Displaying the room name
              child: Text(
                'Room: ${bookingnum.roomText}',
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            left: 36,
            top: 294,
            child: SizedBox(
              width: 184,
              height: 36,
              // Displaying the date
              child: Text(
                'Date: ${DateFormat('dd MMMM yyyy').format(bookingnum.startDate)}',
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            left: 36,
            top: 334,
            child: SizedBox(
              width: 204,
              height: 28,
              // Displaying the time
              child: Text(
                'Time: ${DateFormat('HH:mm').format(bookingnum.startDate)} - ${DateFormat('HH:mm').format(bookingnum.endDate)}',
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: IconButton(
              key: const Key("EditButton"),
              onPressed: () {
                // Button for Editing the booking
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(bookingId: bookingnum.id),
                  ),
                );
              },
              icon: Icon(Icons.edit, color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
