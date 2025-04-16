import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stopwatch_screen.dart';
import 'number_type_screen.dart';
import 'tracking_lbs_screen.dart';
import 'time_conversion_screen.dart';
import 'recommendation_screen.dart';
import 'login_screen.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = "";
  String _currentTime = "";
  String _currentDate = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _startClock();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? "";
    });
  }

  void _startClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
        _currentDate = _getCurrentDate();
      });
    });
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('d MMMM yyyy').format(now);
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Widget buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurpleAccent, size: 40),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: const Color(0xFF7C4DFF)),
        onTap: onTap,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E44AD), Color(0xFF2980B9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with username, logout icon, time and date
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello, $_username!",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 3,
                            color: Colors.black26,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () => _logout(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Display the current time and date
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      _currentDate,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _currentTime,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Menu Cards
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    buildMenuCard("Stopwatch", Icons.timer, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StopwatchScreen(),
                        ),
                      );
                    }),
                    buildMenuCard(
                      "Number Type",
                      Icons.format_list_numbered,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NumberTypeScreen(),
                          ),
                        );
                      },
                    ),
                    buildMenuCard("Tracking LBS", Icons.location_on, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackingLBSScreen(),
                        ),
                      );
                    }),
                    buildMenuCard("Time Conversion", Icons.access_time, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeConversionScreen(),
                        ),
                      );
                    }),
                    buildMenuCard("Recommendation Sites", Icons.link, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecommendationScreen(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
