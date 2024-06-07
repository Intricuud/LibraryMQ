import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_library_app/models/booking_model.dart';

class LibraryRoom extends StatelessWidget {
  final LibraryBooking bookingnum;

  const LibraryRoom({Key? key, required this.bookingnum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const TextStyle latoTextStyle = TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 295,
      height: 90,
      child: Padding(
        // Widget for creating a booking detail in homescreen
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Room: ${bookingnum.roomText}",
              style: latoTextStyle.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: 10),
            Text(
              "Date: ${DateFormat('dd MMM yyyy').format(bookingnum.startDate)} - ${DateFormat('HH:mm').format(bookingnum.startDate)} - ${DateFormat('HH:mm').format(bookingnum.endDate)}",
              style: latoTextStyle.copyWith(color: theme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
