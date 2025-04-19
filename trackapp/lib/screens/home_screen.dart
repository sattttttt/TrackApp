import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'tracking_lbs_screen.dart';
import 'recommendation_screen.dart';
import 'stopwatch_screen.dart';
import 'number_type_screen.dart';
import 'time_conversion_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String _username = "";
  String _currentTime = "";
  String _currentDate = "";
  Timer? _clockTimer;
  Timer? _inactivityTimer;
  final int _sessionTimeout = 180; // 3 menit dalam detik

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadUsername();
    _startClock();
    _resetInactivityTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _clockTimer?.cancel();
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkSession();
    }
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? "User";
    });
  }

  void _startClock() {
    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
        _currentDate = _getCurrentDate();
      });
    });
  }

  void _resetInactivityTimer() async {
    _inactivityTimer?.cancel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastActivity", DateTime.now().toString());
    _inactivityTimer = Timer(Duration(seconds: _sessionTimeout), _logout);
  }

  Future<void> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastActivityStr = prefs.getString("lastActivity");

    if (lastActivityStr == null) {
      _logout();
      return;
    }

    DateTime lastActivity = DateTime.parse(lastActivityStr);
    if (DateTime.now().difference(lastActivity).inSeconds > _sessionTimeout) {
      _logout();
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  String _getCurrentDate() {
    return DateFormat('d MMMM yyyy').format(DateTime.now());
  }

  Widget _buildMenuCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF7C4DFF), size: 40),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF7C4DFF)),
        onTap: () {
          _resetInactivityTimer();
          onTap();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _resetInactivityTimer,
        onPanUpdate: (_) => _resetInactivityTimer(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E44AD), Color(0xFF2980B9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello, $_username!",
                        style: TextStyle(
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
                        icon: Icon(Icons.logout, color: Colors.white),
                        onPressed: _logout,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Time Display
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        _currentDate,
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _currentTime,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildMenuCard("Stopwatch", Icons.timer, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StopwatchScreen(),
                          ),
                        );
                      }),
                      _buildMenuCard(
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
                      _buildMenuCard("Tracking LBS", Icons.location_on, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingLBSScreen(),
                          ),
                        );
                      }),
                      _buildMenuCard("Time Conversion", Icons.access_time, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimeConversionScreen(),
                          ),
                        );
                      }),
                      _buildMenuCard("Recommendation Sites", Icons.link, () {
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
      ),
    );
  }
}
