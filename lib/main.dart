import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/ui/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

/// A StatelessWidget class to hold basic details and routes of my application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Household Executives',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF1A60CD),
      ),
      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => Splash(),
      },
    );
  }
}
