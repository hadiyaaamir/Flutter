import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                child: Text('About Me', style: TextStyle(color: Colors.white, fontSize: 20),),

              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                child: Text('Edit', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
