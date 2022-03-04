import 'package:flutter/material.dart';

class CounterTwo extends StatefulWidget {
  CounterTwo({
    Key? key,
    required this.counter,
    required this.onCounterUpdated,
  }) : super(key: key);

  int counter;
  final Function(int) onCounterUpdated;

  @override
  _CounterTwoState createState() => _CounterTwoState();
}

class _CounterTwoState extends State<CounterTwo> {
  int myCounter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCounter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CounterTwo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(myCounter.toString()),
            ElevatedButton(
              onPressed: () {
                myCounter++;
                setState(() {});
                widget.onCounterUpdated(myCounter);
              },
              child: const Text('Reassign counter'),
            ),
            Hello(
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Hello extends StatelessWidget {
  final VoidCallback onTap;
  const Hello({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: const Text('Hello'),
        ),
        const Text('Google'),
        const Text('Facebook'),
      ],
    );
  }
}
