import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskappandroid/main.dart';
import 'package:taskappandroid/provider.dart';

class edit extends StatefulWidget {
  final int index;
  const edit({Key? key, required this.index}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  @override
  DateTime selectedDate = DateTime.now();

  static get index => null;
  @override
  Widget build(BuildContext context) {
    List<Task> tasklist = context.watch<ListProvider>().list;
    Task old = tasklist[widget.index];

    final TextEditingController nameController = TextEditingController()
      ..text = context.read<ListProvider>().getname(tasklist[widget.index]);
    final TextEditingController descController = TextEditingController()
      ..text = context.read<ListProvider>().getdesc(tasklist[widget.index]);
    final TextEditingController dateController = TextEditingController()
      ..text = context
          .read<ListProvider>()
          .getdue(tasklist[widget.index])
          .toString();
    bool namefilled = true;
    bool descfilled = true;
    bool datefilled = true;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Task'),
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

                    context.read<ListProvider>().edittask(old, t);

                    Navigator.of(context).pop(true);
                  }
                },
                child: Text("Save Task"),
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
