import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  List<String> _lapTimes = []; // List to store the lap times

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
        setState(() {});
      });
    }
  }

  void _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      // Store the lap time in the list when the stopwatch is stopped
      setState(() {
        _lapTimes.add(_formatTime(_stopwatch.elapsedMilliseconds));
      });
    }
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {
      _lapTimes.clear(); // Clear the lap times when reset
    });
  }

  double _calculateAngle() {
    final elapsed = _stopwatch.elapsedMilliseconds;
    final seconds = (elapsed / 1000) % 60;
    return (2 * pi * (seconds / 60)) - pi / 2;
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds ~/ 60000);
    int seconds = ((milliseconds ~/ 1000) % 60);
    int milliSeconds = ((milliseconds % 1000) ~/ 10);
    return '${minutes.toString().padLeft(2, '0')}:' +
        '${seconds.toString().padLeft(2, '0')}:' +
        '${milliSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final angle = _calculateAngle();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch"),
        backgroundColor: const Color(0xFF4A90E2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "STOPWATCH",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CustomPaint(
                painter: StopwatchPainter(angle),
                size: const Size(250, 250),
              ),
              const SizedBox(height: 24),
              Text(
                _formatTime(_stopwatch.elapsedMilliseconds),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: _startStopwatch,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Mulai"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _stopStopwatch,
                    icon: const Icon(Icons.pause),
                    label: const Text("Berhenti"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _resetStopwatch,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reset"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Display the lap times list below the stopwatch
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _lapTimes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: Colors.white.withOpacity(0.9),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        title: Text(
                          'Lap ${index + 1}: ${_lapTimes[index]}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.timer, color: Colors.blue.shade700),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StopwatchPainter extends CustomPainter {
  final double angle;
  StopwatchPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    final paintCircle =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final paintBorder =
        Paint()
          ..color = Colors.blue.shade800
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    final paintNeedle =
        Paint()
          ..color = Colors.red
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round;

    // Draw base circle and border
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);

    // Draw numbers (keliling)
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 5; i <= 60; i += 5) {
      double tickAngle = (2 * pi * (i / 60)) - pi / 2;
      final offset = Offset(
        center.dx + (radius - 20) * cos(tickAngle),
        center.dy + (radius - 20) * sin(tickAngle),
      );
      textPainter.text = TextSpan(
        text: "$i",
        style: const TextStyle(fontSize: 12, color: Colors.black87),
      );
      textPainter.layout();
      canvas.save();
      canvas.translate(
        offset.dx - textPainter.width / 2,
        offset.dy - textPainter.height / 2,
      );
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }

    // Draw needle
    final needleLength = radius - 30;
    final needleEnd = Offset(
      center.dx + needleLength * cos(angle),
      center.dy + needleLength * sin(angle),
    );
    canvas.drawLine(center, needleEnd, paintNeedle);
  }

  @override
  bool shouldRepaint(covariant StopwatchPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
