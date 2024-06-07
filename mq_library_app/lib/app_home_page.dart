import 'package:flutter/material.dart';
import 'package:mq_library_app/widget/widget_bottom_tabs.dart';

class MyHomePage extends StatelessWidget {
  // The main file that implements functionality to the theme and bottom tab navigation
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Widget> screens;
  final Function toggleDarkMode;

  const MyHomePage({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.screens,
    required this.toggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: screens[selectedIndex],
      bottomNavigationBar: BottomTabs(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
      // Button for toggling between light and dark theme
      floatingActionButton: FloatingActionButton(
          key: const Key("ThemeChanger"),
          onPressed: () => toggleDarkMode(),
          backgroundColor: Theme.of(context).primaryColorDark,
          foregroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.lightbulb)),
    );
  }
}
