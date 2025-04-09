import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ithera/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures proper initialization
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Fullscreen mode (no status bar)
  runApp(const MyApp()); // Entry point
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // First page
      home:  SplashScreen(),
    );
  }
}
