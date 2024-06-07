import 'package:flutter/material.dart';
import 'package:mq_library_app/app_home_page.dart';
import 'package:mq_library_app/app_screen/app_account_screen.dart';
import 'package:mq_library_app/app_screen/app_book_screen.dart';
import 'package:mq_library_app/app_screen/app_home_screen.dart';
import 'package:mq_library_app/app_screen/app_map_screen.dart';
import 'package:mq_library_app/app_screen/app_myspace_screen.dart';

class LibraryMQ extends StatefulWidget {
  // The main file that control many of the functionality and also screen.
  const LibraryMQ({super.key});

  @override
  State<LibraryMQ> createState() => _LibraryMQState();
}

class _LibraryMQState extends State<LibraryMQ> {
  int _selectedIndex = 0;
  bool _isDarkMode = false; // Initially set to false for light mode

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookingScreen(),
    const CampusMapScreen(),
    const MySpaceScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Set the default theme
    _isDarkMode = false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Building the main app with bottom tabs navigation
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: MyHomePage(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        screens: _screens,
        toggleDarkMode: _toggleDarkMode,
      ),
    );
  }
}

// Theme Data for Light and Dark theme
final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.black,
  primaryColorLight: const Color(0xFF00B4D8),
  primaryColorDark: const Color(0xffCAF0F8),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xFF0077B6),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.white,
  primaryColorLight: Colors.grey[900],
  primaryColorDark: Colors.grey[800],
  appBarTheme: AppBarTheme(
    color: Colors.grey[900],
  ),
  scaffoldBackgroundColor: Colors.grey[850],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
);
