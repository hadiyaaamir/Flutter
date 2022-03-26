import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Text(
              'About Me',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phone Number'),
                Text('0000000000'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email'),
                Text('gsajbhas@gmail.com'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Address'),
                Text('mhj ahbs jag'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
