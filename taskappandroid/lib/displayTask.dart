import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskappandroid/editTask.dart';
import 'package:taskappandroid/main.dart';
import 'package:taskappandroid/provider.dart';

class displayTask extends StatefulWidget {
  final int i;
  const displayTask({Key? key, required this.i}) : super(key: key);

  @override
  _displayTaskState createState() => _displayTaskState();
}

class _displayTaskState extends State<displayTask> {
  @override
  Widget build(BuildContext context) {
    List<Task> tasklist = context.watch<ListProvider>().list;
    return Scaffold(
      appBar: AppBar(
        title: Text(tasklist[widget.i].name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tasklist[widget.i].name),
            Text(tasklist[widget.i].desc),
            Text(tasklist[widget.i].due.year.toString() +
                '-' +
                tasklist[widget.i].due.month.toString() +
                '-' +
                tasklist[widget.i].due.day.toString()),
            (!tasklist[widget.i].isDone)
                ? ElevatedButton(
                    onPressed: () {
                      context
                          .read<ListProvider>()
                          .setisdone(true, tasklist[widget.i]);
                      context
                          .read<ListProvider>()
                          .setdoneon(DateTime.now(), tasklist[widget.i]);
                      setState(() {});
                    },
                    child: Text('Mark as done'),
                  )
                : Text(
                    'You marked this task as done on ' +
                        tasklist[widget.i].doneOn!.year.toString() +
                        '-' +
                        tasklist[widget.i].doneOn!.month.toString() +
                        '-' +
                        tasklist[widget.i].doneOn!.day.toString(),
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
            if (tasklist[widget.i].due.isBefore(DateTime.now()) &&
                !tasklist[widget.i].isDone)
              Text(
                'Due Date has passed!',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ElevatedButton(
              onPressed: () {
                var index = widget.i;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => edit(index: index),
                  ),
                );
                context
                    .read<ListProvider>()
                    .setdoneon(DateTime.now(), tasklist[widget.i]);
                setState(() {});
              },
              child: Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool del = false;
                del = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Do you want to delete?'),
                          content:
                              Text('This will remove the item from your cart'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('No')),
                          ],
                        ));
                if (del) {
                  context.read<ListProvider>().deletetask(tasklist[widget.i]);
                  setState(() {});
                }
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
