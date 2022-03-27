import 'package:assignment5/newTask.dart';
import 'package:assignment5/taskProvider.dart';
import 'package:assignment5/taskTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = context.watch<TaskProvider>().tasks;

    if (tasks.isEmpty) {
      return const emptyTasksView();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => TaskTile(task: tasks[index]),
      itemCount: tasks.length,
    );
  }
}

class emptyTasksView extends StatelessWidget {
  const emptyTasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 32),
            child: Text(
              'You have no pending tasks',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NewTask()),
                );
              },
              child: const Text('Add a new Task'),
            ),
          ),
        ],
      ),
    );
  }
}
