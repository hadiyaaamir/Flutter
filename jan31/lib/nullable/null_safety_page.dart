import 'package:flutter/material.dart';

class NullSafteyPage extends StatefulWidget {
  const NullSafteyPage({Key? key}) : super(key: key);

  @override
  _NullSafteyPageState createState() => _NullSafteyPageState();
}

class myClass {
  String? name;
  myClass({this.name});
}

class _NullSafteyPageState extends State<NullSafteyPage> {
  @override
  Widget build(BuildContext context) {
    String? a = "Hello";
    a = null;

    myClass c = myClass(name: null);

    return Container();
  }
}
