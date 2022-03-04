import 'package:flutter/material.dart';
import 'package:jan31/counter2.dart';
import 'package:jan31/profile_screen.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const MyOwnWidget(
                      title: 'Aik title', middle: 'Beech', trailing: 'khatam'),
                  const MyOwnWidget(
                      title: 'Thing1', middle: 'Thing2', trailing: 'Thing3'),
                  ElevatedButton(
                    onPressed: () async {
                      _counter++;
                      setState(() {});
                      // isLoading = !isLoading;
                      // setState(() {});
                      // await Future.delayed(const Duration(seconds: 2));
                      // isLoading = !isLoading;
                      // setState(() {});
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool isLogout = false;

                      isLogout = await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Do you want to log out?'),
                          content: const Text(
                              'This will log you out from the application'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Logout'),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var profile = Profile(name: "Hadiya", email: "hadiya@gmail.com");

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CounterTwo(
                counter: _counter,
                onCounterUpdated: (value) {
                  _counter = value;
                  setState(() {});
                },
              ),
            ),
          );

          setState(() {
            _counter++;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Profile {
  final String name;
  final String email;

  // Profile(this.name, this.email);

  //using named parameters
  Profile({
    required this.name,
    required this.email,
  });
}

class MyOwnWidget extends StatefulWidget {
  const MyOwnWidget(
      {Key? key, this.title = "", this.middle = "", this.trailing = ""})
      : super(key: key);

  final String title;
  final String middle;
  final String trailing;

  @override
  State<MyOwnWidget> createState() => _MyOwnWidgetState();
}

class _MyOwnWidgetState extends State<MyOwnWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Text(widget.middle),
        Text(widget.trailing),
      ],
    );
  }
}
