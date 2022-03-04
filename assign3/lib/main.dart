import 'package:assign3/Cart.dart';
import 'package:assign3/dish.dart';
import 'package:assign3/tileWidgets.dart';
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
      title: 'Assignment 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dishes'),
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
  List<Dish> dishes = [
    Dish(name: "Burger", price: 375),
    Dish(name: "Pizza", price: 500),
    Dish(name: "Fries", price: 80),
    Dish(name: "Biryani", price: 120),
    Dish(name: "Mera sar", price: 2.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) => Tile(dish: dishes[index]),
          itemCount: dishes.length,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cart(
                dishes: dishes,
                onRemoved: (updatedDishes) {
                  dishes = updatedDishes;
                  setState(() {});
                },
              ),
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart_outlined),
        label: const Text('Cart'),
      ),
    );
  }
}
