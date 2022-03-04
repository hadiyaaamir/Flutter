import 'package:assignment2/tileWidgets.dart';
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
      title: 'Assignment 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Assignment 2'),
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
  List<Person> people = [
    Person(name: "Hadiya Aamir", email: "hadiya@gmail.com", avatarText: "HA"),
    Person(name: "Jaweria Asif", email: "jaw@gmail.com", avatarText: "JA"),
    Person(
        name: "Manahil Jawaid", email: "manahil@gmail.com", avatarText: "MJ"),
    Person(name: "Faiza Nadeem", email: "faiza@gmail.com", avatarText: "FN"),
    Person(name: "Maheen Sabahat", email: "maheen@gmail.com", avatarText: "MS"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => Tile(
          name: people[index].name,
          email: people[index].email,
          avatarText: people[index].avatarText,
        ),
        itemCount: people.length,
      ),
    );
  }
}

class Person {
  final String name;
  final String email;
  final String avatarText;

  Person({
    required this.name,
    required this.email,
    required this.avatarText,
  });
}
