import 'package:flutter/material.dart';
import 'package:mq_library_app/app_screen/app_login_screen.dart';
import 'package:mq_library_app/auth/firebase_auth.dart';
import 'package:mq_library_app/data/booking_database.dart';
import 'package:mq_library_app/data/user_database.dart';
import 'package:mq_library_app/models/booking_model.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the theme data

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
              // Text Title for Account Screen
              child: Text(
                'Account',
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
        // The main container for storing all the user's information like
        // profile picture, name, email and user's booking number
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
            // This is the persistent data for implementing user detail upon log in
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: UserDatabase.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                } else {
                  final users = snapshot.data!;
                  // If the user exist we will display the profile picture of the user.
                  if (users.isNotEmpty) {
                    final user = users.first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // Profile picture of the user
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/profile_image.jpg'),
                        ),
                        const SizedBox(height: 20),
                        // The name of the user
                        Text(
                          'Name: ${user['name']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        // The email of the user
                        Text(
                          'Email: ${user['email']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        // Fetching data from the booking database
                        // To find out how many booking the user currently have
                        FutureBuilder<List<LibraryBooking>>(
                          future: BookingDatabase.getBookings(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final bookings = snapshot.data!;
                              final bookingCount = bookings.length;
                              return Column(
                                // Displaying the amount of booking the user have
                                children: [
                                  Text(
                                    'Number of Bookings: $bookingCount',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // User pressed log out and get redirected to the login screen
                                      _auth.signout();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    // if the user data cannot be fetch at all then display User data not found
                    return const Center(child: Text('User data not found'));
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
