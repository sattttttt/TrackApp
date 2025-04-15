import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/members_screen.dart';
import '../screens/help_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';

class BottomNav extends StatelessWidget {
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Members"),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
      ],
      onTap: (index) {
        if (index == 0) {
          _navigate(context, HomeScreen());
        } else if (index == 1) {
          _navigate(context, MembersScreen());
        } else if (index == 2) {
          _navigate(context, HelpScreen());
        }
      },
    );
  }
}
