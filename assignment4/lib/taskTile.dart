import 'package:assignment4/taskDetail.dart';
import 'package:assignment4/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatefulWidget {
  TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  Task task;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool isLate;

  @override
  Widget build(BuildContext context) {
    isLate = context.watch<TaskProvider>().isTaskLate(widget.task);

    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.only(
            left: 30,
            right: isLate && !widget.task.isMarked
                ? 11 //less padding if red banner
                : 20,
            bottom: 2,
            top: 2),

        //task title
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(widget.task.title),
        ),

        //task description
        subtitle: Text('Due on ' +
            widget.task.dueDate.day.toString() +
            "/" +
            widget.task.dueDate.month.toString() +
            "/" +
            widget.task.dueDate.year.toString()),

        //icon + red line
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),

              //marking icons
              child: widget.task.isMarked
                  ? InkWell(
                      child:
                          const Icon(Icons.check_circle, color: Colors.green),
                      onTap: () {
                        context.read<TaskProvider>().unmarkTask(widget.task);
                      },
                    )
                  : InkWell(
                      child: const Icon(Icons.circle_outlined),
                      onTap: () {
                        context.read<TaskProvider>().markTask(widget.task);
                      },
                    ),
            ),

            //late task - red line/container. Only show if not already marked as done
            Visibility(
              visible: isLate && !widget.task.isMarked,
              child: Container(
                color: Colors.red,
                width: 10,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskDetail(task: widget.task),
            ),
          );
        },
      ),
    );
  }
}
