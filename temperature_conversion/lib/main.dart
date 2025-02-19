import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Temperature Conversion'),
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

  final TextEditingController _controller = TextEditingController();

  final List<String> _units = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];

  String? _inputUnit;
  String? _outputUnit;

  String? _result;

  void _convert() {
    double input = double.parse(_controller.text);

    if (_inputUnit == 'Celsius') { 
      if (_outputUnit == 'Fahrenheit') {
        double calc = (input * 9/5) + 32;
        _result = '${calc.toStringAsFixed(2)}° F';
      }
      else if (_outputUnit == 'Kelvin') {
        double calc = input + 273.15;
        _result = '${calc.toStringAsFixed(2)} K';
      }
      else {
        _result = '$input° C';
      }
    }

    else if (_inputUnit == 'Fahrenheit') {
      if (_outputUnit == 'Celsius') {
        double calc = (input - 32) * (5/9);
        _result = '${calc.toStringAsFixed(2)}° C';
      }
      else if (_outputUnit == 'Kelvin') {
        double calc = (input - 32) * (5/9) + 273.15;
        _result = '${calc.toStringAsFixed(2)} K';
      }
      else {
        _result = '$input° F';
      }
    }

    else if (_inputUnit == 'Kelvin') {
      if (_outputUnit == 'Celsius') {
        double calc = input - 273.15;
        _result = '${calc.toStringAsFixed(2)}° C';
      }
      else if (_outputUnit == 'Fahrenheit') {
        double calc = (input - 273.15) * (9/5) + 32;
        _result = '${calc.toStringAsFixed(2)}° F';
      }
      else {
        _result = '$input K';
      }
    }
    else {
      _result = 'Please select input unit properly';
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Result',
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            if (_result != null) Text(
              _result!,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40,),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the temperature value',
              ),
            ),

            const SizedBox(height: 15,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Input Unit',
              ),
              items: _units.map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              ).toList(), 
              onChanged: (value) => _inputUnit = value,
            ),

            const SizedBox(height: 15,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Output Unit',
              ),
              items: _units.map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              ).toList(), 
              onChanged: (value) => _outputUnit = value,
            ),

            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () => _convert(), 
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
