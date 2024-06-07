import 'package:flutter/material.dart';

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key});

  @override
  _CampusMapScreenState createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  // Setting up 
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor, // Use background color from the theme
      appBar: PreferredSize(
        preferredSize: const Size(393, 156),
        child: Container(
          width: 393,
          height: 156,
          color: theme.appBarTheme
              .backgroundColor, // Use app bar background color from the theme
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              // Title Widget for Map
              child: Text(
                'Map',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor, // Use text color from the theme
                ),
              ),
            ),
            backgroundColor: theme.appBarTheme
                .backgroundColor, // Use app bar background color from the theme
            elevation: 0, // Remove elevation
            iconTheme: theme.iconTheme, // Use icon theme from the theme
          ),
        ),
      ),
      // Using GestureDetector to detect motion for zooming
      body: GestureDetector(
        onScaleStart: (details) {
          _previousScale = _scale;
        },
        onScaleUpdate: (details) {
          setState(() {
            _scale = _previousScale * details.scale;
            // Limit zooming to a certain range
            _scale = _scale.clamp(1.0, 4.0);
          });
        },
        child: Center(
          child: Stack(
            children: [
              Transform.scale(
                scale: _scale,
                // Image for macquarie campus
                child: Image.asset(
                  'assets/mq-campus-map.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
