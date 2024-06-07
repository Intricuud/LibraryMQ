import 'package:flutter/material.dart';
import 'package:mq_library_app/data/booking_database.dart'; // Import your database helper class
import 'package:mq_library_app/models/booking_model.dart';
import 'package:mq_library_app/widget/widget_full_room.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

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
              // Title for My Space
              child: Text(
                'My Space',
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
      body: FutureBuilder<List<LibraryBooking>>(
        key: const Key("bookingbuilder"),
        future: BookingDatabase.getBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final bookings = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: 53.5),
                SingleChildScrollView(
                  key: const Key("BookingScrolling"),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    key: const Key("BookingView"),
                    // Generate The Full booking view 
                    children: [
                      for (var booking in bookings)
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: FullLibraryRoom(bookingnum: booking),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
