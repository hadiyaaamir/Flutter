import 'package:assignment2/saveScreen.dart';
import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key? key,
    this.name = "",
    this.email = "",
    this.avatarText = "",
  }) : super(key: key);

  final String name;
  final String email;
  final String avatarText;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(4),
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(widget.name),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(widget.email),
        ),
        leading: CircleAvatar(child: Text(widget.avatarText)),
        trailing: const Icon(Icons.arrow_right_alt),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SaveScreen(
                name: widget.name,
                email: widget.email,
              ),
            ),
          );
        });
  }
}
