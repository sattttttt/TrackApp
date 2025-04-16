import 'dart:async';
import 'package:flutter/material.dart';

class NumberTypeScreen extends StatefulWidget {
  @override
  _NumberTypeScreenState createState() => _NumberTypeScreenState();
}

class _NumberTypeScreenState extends State<NumberTypeScreen> {
  final TextEditingController _numberController = TextEditingController();
  String _result = "";
  bool _isValid = true;

  bool _isPrime(int num) {
    if (num < 2) return false;
    for (int i = 2; i * i <= num; i++) {
      if (num % i == 0) return false;
    }
    return true;
  }

  void _analyzeNumber() {
    String input = _numberController.text;
    if (input.isEmpty) {
      setState(() {
        _result = "Enter numbers first!";
        _isValid = false;
      });
      return;
    }

    int? number = int.tryParse(input);
    if (number == null) {
      setState(() {
        _result = "Enter a valid number!";
        _isValid = false;
      });
      return;
    }

    List<String> properties = [];
    if (number > 0) {
      properties.add("Positive");
    } else if (number < 0) {
      properties.add("Negative");
    } else {
      properties.add("Nol");
    }

    if (number % 2 == 0) {
      properties.add("Even");
    } else {
      properties.add("Odd");
    }

    if (_isPrime(number)) {
      properties.add("Prime Numbers");
    }

    setState(() {
      _result = "Number $number is: ${properties.join(', ')}";
      _isValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Type"),
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
                // Rounded Text Input
                TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Number",
                    prefixIcon: const Icon(Icons.confirmation_number),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
                const SizedBox(height: 20),

                // Modern Button
                ElevatedButton.icon(
                  onPressed: _analyzeNumber,
                  icon: const Icon(Icons.search),
                  label: const Text("Check"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF4A90E2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Result Card
                if (_result.isNotEmpty)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _isValid ? Colors.white : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                              fontSize: 18,
                              color:
                                  _isValid ? Colors.black87 : Colors.red[900],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
