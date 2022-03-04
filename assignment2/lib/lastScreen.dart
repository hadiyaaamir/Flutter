import 'package:flutter/material.dart';

class LastScreen extends StatelessWidget {
  LastScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            NiceText(text: name),
            const SizedBox(height: 35),
            NiceText(text: email),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

class NiceText extends StatelessWidget {
  const NiceText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
