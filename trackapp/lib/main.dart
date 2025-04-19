import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: _checkSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data == true ? HomeScreen() : LoginScreen();
        },
      ),
    );
  }

  Future<bool> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    
    if (isLoggedIn) {
      String? lastActivityStr = prefs.getString("lastActivity");
      if (lastActivityStr == null) return false;
      
      DateTime lastActivity = DateTime.parse(lastActivityStr);
      DateTime currentTime = DateTime.now();
      Duration difference = currentTime.difference(lastActivity);
      
      if (difference.inMinutes >= 5) {
        await prefs.clear();
        return false;
      }
    }
    return isLoggedIn;
  }
}