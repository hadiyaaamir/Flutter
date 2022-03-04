import 'package:flutter/material.dart';
import 'package:jan31/stateManagement/counterProvider.dart';
import 'package:provider/provider.dart';

class CounterPageWProvider extends StatelessWidget {
  const CounterPageWProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management'),
      ),
      body: Center(
        child: Column(
          children: [
            const Count(),
            ElevatedButton(
              onPressed: () {
                context.read<CounterProvider>().increment();
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.watch<CounterProvider>().count.toString());
  }
}
