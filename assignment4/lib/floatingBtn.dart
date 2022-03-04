import 'package:assignment4/newTask.dart';
import 'package:assignment4/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingBtn extends StatelessWidget {
  const FloatingBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = context.watch<TaskProvider>().tasks;

    return Visibility(
      visible: tasks.isNotEmpty,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NewTask()),
          );
        },
      ),
    );
  }
}
