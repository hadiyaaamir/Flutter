import 'package:assignment4/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DateTime selectedDate = DateTime.now();

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  bool noTitle = false;
  bool noDesc = false;
  bool noDate = false;

  @override
  Widget build(BuildContext context) {
    selectedDate = DateTime.now();
    return Scaffold(
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
                  onPressed: () {
                    //check if all fields filled
                    _controllerTitle.text == ""
                        ? noTitle = true
                        : noTitle = false;
                    _controllerDesc.text == "" ? noDesc = true : noDesc = false;
                    _controllerDate.text == "" ? noDate = true : noDate = false;

                    //if all filled, add task and go back
                    if (!noTitle && !noDesc && !noDate) {
                      context.read<TaskProvider>().addTask(
                          title: _controllerTitle.text,
                          desc: _controllerDesc.text,
                          date: selectedDate);
                      Navigator.pop(context);
                    }

                    setState(() {});
                  },
                  child: const Text('Add Task'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTextField extends StatelessWidget {
  const DateTextField({
    Key? key,
    required this.controller,
    required this.notFilled,
  }) : super(key: key);

  final TextEditingController controller;
  final bool notFilled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          keyboardType: TextInputType.multiline,
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: notFilled
                  ? const BorderSide(color: Colors.red, width: 1)
                  : const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: notFilled
                  ? const BorderSide(color: Colors.red, width: 1)
                  : const BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: 'Due Date',
            suffixIcon: const Icon(Icons.calendar_month_rounded),
            filled: true,
            fillColor: Colors.white,
          ),
          onTap: () async {
            // print('Still tappable!');
            bool selected = await _selectDate(context);
            if (selected) {
              controller.text = selectedDate.day.toString() +
                  "/" +
                  selectedDate.month.toString() +
                  "/" +
                  selectedDate.year.toString();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 80),
    );
    if (selected != null) {
      selectedDate = selected;
      return true;
    }
    return false;
  }
}

class TextFieldd extends StatelessWidget {
  const TextFieldd({
    Key? key,
    required this.controller,
    this.height = 1,
    required this.label,
    required this.notFilled,
  }) : super(key: key);

  final TextEditingController controller;
  final int height;
  final String label;
  final bool notFilled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: height,
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: notFilled
                  ? const BorderSide(color: Colors.red, width: 1)
                  : const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: notFilled
                  ? const BorderSide(color: Colors.red, width: 1)
                  : const BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: label,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
