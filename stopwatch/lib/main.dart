import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Stopwatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _elapsedTime = 0;

  Timer? _timer;

  void _start() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1), 
      (timer) {
        setState(() => _elapsedTime++);
      },
    );
  }

  void _stop() {
    _timer?.cancel();
  }

  void _reset() {
    _timer?.cancel();

    setState(() => _elapsedTime=0);
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Elapsed Time',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${Duration(seconds: _elapsedTime).inMinutes} min '
                '${_elapsedTime - (Duration(seconds: _elapsedTime).inMinutes * 60)} sec',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () => _start(), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Start'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _stop, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Stop'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _reset, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
