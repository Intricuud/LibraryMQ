import 'package:flutter/material.dart';
import 'package:mq_library_app/data/booking_database.dart';
import 'package:mq_library_app/models/booking_model.dart';
import 'package:mq_library_app/widget/widget_library_room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<LibraryBooking> bookings;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshBookings();
  }
  // Reset the database and fetched the book
  Future<void> refreshBookings() async {
    setState(() {
      bookings = [];
    });

    final fetchedBookings = await BookingDatabase.getBookings();
    setState(() {
      bookings = fetchedBookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refreshBookings,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: theme.appBarTheme.backgroundColor,
                width: 393,
                height: 156,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, top: 74),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Title Text for the Screen
                        Text(
                          "LibraryMQ",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Lato',
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 40),
                        // Macquarie Logo
                        Image.asset(
                          'assets/macq_logo.png',
                          width: 169,
                          height: 51,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 53.5),
              Padding(
                padding: const EdgeInsets.only(left: 31.5, right: 31.5),
                // Container for the booking list
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColorLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 330,
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Booking:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Lato',
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "You have booking for:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Lato',
                                color: theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          // Scrolling container to prevent horizontal overflow
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              children: [
                                // Generate for each booking in the database
                                for (var booking in bookings)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Dismissible(
                                      key:
                                          UniqueKey(), // UniqueKey for Dismissible
                                      onDismissed: (direction) async {
                                        await BookingDatabase.deleteBooking(
                                            booking.id);
                                        refreshBookings();
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 20.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: LibraryRoom(
                                          key: const Key("Booking"),
                                          bookingnum: booking),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
