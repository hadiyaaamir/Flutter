import 'package:flutter/material.dart';
import 'package:mid/friendsProvider.dart';
import 'package:provider/src/provider.dart';

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
//  List<String> names = ['HA', 'WB', 'HH'];

  @override
  Widget build(BuildContext context) {
    List<String> names = context.watch<FriendsProvider>().friends;

    return Expanded(
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//
              children: const [
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                  child: Text(
                    'FRIENDS',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                  child: Text('Edit', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: names.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            child: Text(
                              names[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      child: const CircleAvatar(
                        child: Icon(Icons.add),
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                      ),
                      onTap: () async {
                        await _displayDialog(context);
                        context
                            .read<FriendsProvider>()
                            .addFriend(_controller.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController _controller = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Insert initials of new friend'),
            content: TextField(
              controller: _controller,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter the initials"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
