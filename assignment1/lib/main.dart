import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Assignment 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  String userid = "";
  String password = "";

  String buttonText = 'Login';

  bool isPressed = false;

  Widget button() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (buttonText == 'Login') {
            buttonText = 'Reset';
          } else {
            _controller1.clear();
            _controller2.clear();
            buttonText = 'Login';
          }
        });
      },
      child: Text(buttonText),
    );
  }

  List<Widget> getWidgets() {
    setState(() {});
    if (buttonText == 'Login') {
      return <Widget>[
        SizedBox(
          width: 300,
          child: TextField(
              controller: _controller1,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                labelText: 'User ID',
              )),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextField(
              obscureText: true,
              controller: _controller2,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                labelText: 'Password',
              )),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: 300,
          height: 50,
          child: button(),
        ),
      ];
    }

    return <Widget>[
      const SizedBox(height: 20),
      SizedBox(
        width: 300,
        child: Text(
          _controller1.text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      const SizedBox(height: 35),
      SizedBox(
        width: 300,
        child: Text(
          _controller2.text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      const SizedBox(height: 90),
      SizedBox(
        width: 300,
        height: 50,
        child: button(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getWidgets(),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
