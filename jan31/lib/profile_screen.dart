import 'package:flutter/material.dart';
import 'package:jan31/main.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;

  const ProfileScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile screen'),
        // automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text(widget.profile.name),
          Text(widget.profile.email),
        ],
      ),
    );
  }
}
