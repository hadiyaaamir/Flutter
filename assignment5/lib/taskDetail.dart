import 'package:assignment5/dialog.dart';
import 'package:assignment5/editTask.dart';
import 'package:assignment5/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  late bool isMarked;
  late bool isLate;

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = context.watch<TaskProvider>().tasks;

    isMarked = context.read<TaskProvider>().isTaskMarked(widget.task);
    DateTime dueDate = context.read<TaskProvider>().getDuedate(widget.task);

    isLate =
        dueDate.isBefore(DateTime.now()) && dueDate.day != DateTime.now().day;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //title
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            //description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                widget.task.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            //due date
            Padding(
              padding: const EdgeInsets.only(top: 45, bottom: 10),
              child: Text(
                "Due Date: " +
                    dueDate.day.toString() +
                    "/" +
                    dueDate.month.toString() +
                    "/" +
                    dueDate.year.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),

            //due date passed
            if (isLate && !isMarked) ...[
              const Text(
                "Due Date has passed!",
                style: TextStyle(color: Colors.red),
              ),
            ],

            const SizedBox(height: 100),

            //if marked, show text
            isMarked
                ? Text(
                    "You marked this task as done\n on " +
                        widget.task.dateMarked!.day.toString() +
                        "/" +
                        widget.task.dateMarked!.month.toString() +
                        "/" +
                        widget.task.dateMarked!.year.toString(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  )

                //button if NOT marked
                : SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: const Text("Mark as done"),
                      onPressed: () {
                        context.read<TaskProvider>().markTask(widget.task);
                      },
                    ),
                  ),

            //delete button
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: 250,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text("Delete task"),
                  onPressed: () async {
                    bool confirm = await dialogBox(context);

                    if (confirm) {
                      context.read<TaskProvider>().removeTask(widget.task);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      //edit floating button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTask(task: widget.task),
            ),
          );
        },
      ),
    );
  }
}
