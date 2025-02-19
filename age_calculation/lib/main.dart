import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Age Calculation'),
      debugShowCheckedModeBanner: false,
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

  String? _calculatedAge;

  void _calculate() {
    DateTime? birthDate = DateTime.tryParse(_controller.text);
    if (birthDate != null) {
      Duration age = DateTime.now().difference(birthDate);

      int year = (age.inDays/365.0).floor();
      int days = age.inDays - (year*365);

      _calculatedAge = '$year Years $days days';
    }
    else {
      _calculatedAge = 'Enter a date with proper format';
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Calculated Age',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 15,),
            
            if (_calculatedAge != null) Text(
              _calculatedAge!,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 40,),
            TextFormField(
              controller: _controller,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your date of birth (yyyy-mm-dd)',
              ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () => _calculate(), 
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
