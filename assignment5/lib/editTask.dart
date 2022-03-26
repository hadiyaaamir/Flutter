import 'package:assignment5/newTask.dart';
import 'package:assignment5/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  bool noTitle = false;
  bool noDesc = false;
  bool noDate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerTitle.text = widget.task.title;
    _controllerDesc.text = widget.task.description;
    _controllerDate.text = widget.task.dueDate.day.toString() +
        "/" +
        widget.task.dueDate.month.toString() +
        "/" +
        widget.task.dueDate.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = DateTime(
      widget.task.dueDate.year,
      widget.task.dueDate.month,
      widget.task.dueDate.day,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Task"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldd(
              controller: _controllerTitle,
              label: 'Title',
              notFilled: noTitle,
            ),
            TextFieldd(
              controller: _controllerDesc,
              label: 'Description',
              height: 5,
              notFilled: noDesc,
            ),
            DateTextField(
              controller: _controllerDate,
              notFilled: noDate,
            ),

            //button
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                width: 334,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    //check if all fields filled
                    _controllerTitle.text == ""
                        ? noTitle = true
                        : noTitle = false;
                    _controllerDesc.text == "" ? noDesc = true : noDesc = false;
                    _controllerDate.text == "" ? noDate = true : noDate = false;

                    //if all filled, add task and go back
                    if (!noTitle && !noDesc && !noDate) {
                      await context.read<TaskProvider>().editTask(
                            task: widget.task,
                            title: _controllerTitle.text,
                            desc: _controllerDesc.text,
                            date: selectedDate,
                          );
                      Navigator.pop(context);
                    }

                    setState(() {});
                  },
                  child: const Text('Confirm Changes'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
