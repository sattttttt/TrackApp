import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final TextEditingController _yearController = TextEditingController();
  String _result = "";
  bool _isValid = true;

  void _convertTime() {
    String input = _yearController.text;
    if (input.isEmpty) {
      setState(() {
        _result = "Masukkan tahun terlebih dahulu!";
        _isValid = false;
      });
      return;
    }

    int? years = int.tryParse(input);
    if (years == null || years < 0) {
      setState(() {
        _result = "Masukkan angka yang valid!";
        _isValid = false;
      });
      return;
    }

    int days = years * 365;
    int hours = days * 24;
    int minutes = hours * 60;
    int seconds = minutes * 60;

    setState(() {
      _result = "$years tahun = $hours jam, $minutes menit, $seconds detik";
      _isValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Converstion"),
        backgroundColor: const Color(0xFF8E44AD),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E44AD), Color(0xFF2980B9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Masukkan tahun",
                    prefixIcon: const Icon(Icons.date_range),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _convertTime,
                  icon: const Icon(Icons.access_time),
                  label: const Text("Konversi"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_result.isNotEmpty)
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: _isValid ? Colors.white : Colors.red.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            _isValid ? Icons.check_circle : Icons.error,
                            color: _isValid ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _result,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    _isValid ? Colors.black87 : Colors.red[900],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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
