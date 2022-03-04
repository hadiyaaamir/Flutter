import 'package:assign3/dish.dart';
import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key? key,
    required this.dish,
  }) : super(key: key);

  final Dish dish;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Card(
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 25, right: 25),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(widget.dish.name),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Text("Rs. " + widget.dish.price.toString()),
            ),
            leading:
                CircleAvatar(child: Text(widget.dish.name.substring(0, 1))),
            trailing: InkWell(
              onTap: () {
                // setState(() {});
                widget.dish.isAdded = !widget.dish.isAdded;
                // print(isAdded);
                setState(() {});
              },
              child: widget.dish.isAdded
                  ? const Icon(Icons.remove_circle, color: Colors.grey)
                  : const Icon(Icons.add_circle, color: Colors.blue),
            ),
          ),
        ));
  }
}
