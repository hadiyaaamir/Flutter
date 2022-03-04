import 'package:assign3/dish.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({
    Key? key,
    required this.dishes,
    required this.onRemoved,
  }) : super(key: key);

  List<Dish> dishes;
  Function(List<Dish>) onRemoved;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Dish> dishes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dishes = widget.dishes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (dishes[index].isAdded) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 25, right: 25),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(dishes[index].name),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Text("Rs. " + dishes[index].price.toString()),
                    ),
                    leading: CircleAvatar(
                        child: Text(dishes[index].name.substring(0, 1))),
                    trailing: InkWell(
                      onTap: () async {
                        bool confirm = await dialogBox();

                        if (confirm) {
                          dishes[index].isAdded = !dishes[index].isAdded;
                          widget.onRemoved(dishes);
                          setState(() {});
                        }
                      },
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }
            //can't return null so return a sizedbox of no height (essentially nothing?)
            return const SizedBox(height: 0);
          },
          itemCount: dishes.length,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
        ),
      ),
    );
  }

  Future<bool> dialogBox() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(25),
        title: const Text('Remove Item'),
        content: const Text(
            'Are you sure you want to remove this item from your Cart?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
