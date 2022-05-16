import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskappandroid/main.dart';
import 'package:taskappandroid/provider.dart';

class createTask extends StatefulWidget {
  const createTask({Key? key}) : super(key: key);

  @override
  _createTaskState createState() => _createTaskState();
}

class _createTaskState extends State<createTask> {
  final _formKey = new GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool namefilled = true;
  bool descfilled = true;
  bool datefilled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Task'),
        ),
        body: Center(
            child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: namefilled
                        ? const BorderSide(color: Colors.black, width: 1)
                        : const BorderSide(color: Colors.red, width: 1),
                  ),
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: descfilled
                        ? const BorderSide(color: Colors.black, width: 1)
                        : const BorderSide(color: Colors.red, width: 1),
                  ),
                  hintText: 'Description',
                ),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: datefilled
                        ? const BorderSide(color: Colors.black, width: 1)
                        : const BorderSide(color: Colors.red, width: 1),
                  ),
                  hintText: 'Due Date',
                ),
                onTap: () async {
                  await _selectDate(context);

                  dateController.text = selectedDate.year.toString() +
                      '-' +
                      selectedDate.month.toString() +
                      '-' +
                      selectedDate.day.toString();
                },
              ),
              //TextFormField(
              // controller: nameController,
              //decoration: const InputDecoration(
              //icon: Icon(Icons.person),
              //hintText: 'What do people call you?',
              //labelText: 'Name *',
              //),
              //validator: (String? value) {
              //return (value != null) ? 'This is a required field.' : null;
              //},
              //),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty) namefilled = false;
                  if (descController.text.isEmpty) descfilled = false;
                  if (dateController.text.isEmpty) datefilled = false;
                  setState(() {});
                  if (!nameController.text.isEmpty &&
                      !descController.text.isEmpty &&
                      !dateController.text.isEmpty) {
                    Task t = new Task(
                        name: nameController.text,
                        desc: descController.text,
                        due: selectedDate,
                        isDone: false,
                        doneOn: null);

                    context.read<ListProvider>().addnewtask(t);
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text("Add Task"),
              ),
            ],
          ),
        )));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
