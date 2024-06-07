import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomTabs({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ??
        Colors.black; // Provide a default color if text color is null
    final selectedColor =
        theme.primaryColor; // Customize this color for selected tab text

    // Bottom tabs navigation with icon, label and navigation
    return Container(
      height: 94,
      color: theme.appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TabItem(
            title: 'Home',
            icon: Icons.home,
            isSelected: selectedIndex == 0,
            onTap: () {
              onItemTapped(0);
            },
            textColor: textColor,
            selectedColor: selectedColor,
          ),
          _TabItem(
            title: 'Book',
            icon: Icons.book,
            isSelected: selectedIndex == 1,
            onTap: () {
              onItemTapped(1);
            },
            textColor: textColor,
            selectedColor: selectedColor,
          ),
          _TabItem(
            title: 'Map',
            icon: Icons.map,
            isSelected: selectedIndex == 2,
            onTap: () {
              onItemTapped(2);
            },
            textColor: textColor,
            selectedColor: selectedColor,
          ),
          _TabItem(
            title: 'MySpace',
            icon: Icons.space_dashboard,
            isSelected: selectedIndex == 3,
            onTap: () {
              onItemTapped(3);
            },
            textColor: textColor,
            selectedColor: selectedColor,
          ),
          _TabItem(
            title: 'Account',
            icon: Icons.account_circle,
            isSelected: selectedIndex == 4,
            onTap: () {
              onItemTapped(4);
            },
            textColor: textColor,
            selectedColor: selectedColor,
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  // class for automatically creating the tabs using inkwell
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color textColor;
  final Color selectedColor;

  const _TabItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.textColor,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: isSelected ? selectedColor : textColor,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isSelected ? selectedColor : textColor,
            ),
          ),
        ],
      ),
    );
  }
}
