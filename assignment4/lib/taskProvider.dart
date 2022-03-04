import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [
    // Task(
    //   title: 'Test Task',
    //   description: 'This is a test',
    //   dueDate: DateTime(2022, 2, 27),
    // ),
    // Task(
    //   title: 'Test 2',
    //   description: 'Helloo',
    //   dueDate: DateTime(2022, 2, 23),
    // ),
  ];

  List<Task> get tasks => _tasks;

  //add in order
  void addTask({
    required String title,
    required String desc,
    required DateTime date,
    bool isMarked = false,
    DateTime? dateMarked,
  }) {
    Task t = Task(
      title: title,
      description: desc,
      dueDate: date,
      isMarked: isMarked,
      dateMarked: dateMarked,
    );

    tasks.add(t);

    for (int i = tasks.length - 1; i > 0; i--) {
      if (t.isAbove(tasks[i - 1])) {
        //swap
        Task temp = tasks[i - 1];
        tasks[i - 1] = t;
        tasks[i] = temp;
      }
    }

    notifyListeners();
  }

  void markTask(Task task) {
    task.isMarked = true;
    task.dateMarked = DateTime.now();
    // add again so its in order
    tasks.remove(task);
    addTask(
      title: task.title,
      desc: task.description,
      date: task.dueDate,
      isMarked: task.isMarked,
      dateMarked: task.dateMarked,
    );
    notifyListeners();
  }

  void unmarkTask(Task task) {
    task.isMarked = false;
    task.dateMarked = null;
    // add again so its in order
    tasks.remove(task);
    addTask(
      title: task.title,
      desc: task.description,
      date: task.dueDate,
      isMarked: task.isMarked,
      dateMarked: task.dateMarked,
    );
    notifyListeners();
  }

  bool isTaskMarked(Task task) {
    return task.isMarked;
  }

  bool isTaskLate(Task task) {
    return task.dueDate.isBefore(DateTime.now()) &&
        task.dueDate.day != DateTime.now().day;
  }

  // void printTasks() {
  //   for (int i = 0; i < tasks.length; i++) {
  //     print("task $i: " + tasks[i].isMarked.toString());

  //     if (tasks[i].isMarked) {
  //       print("date marked: " +
  //           tasks[i].dateMarked!.day.toString() +
  //           "/" +
  //           tasks[i].dateMarked!.month.toString() +
  //           "/" +
  //           tasks[i].dateMarked!.year.toString());
  //     }
  //   }
  // }
}

class Task {
  String title;
  String description;
  DateTime dueDate;
  bool isMarked;
  DateTime? dateMarked;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isMarked = false,
    this.dateMarked,
  });

  bool isAbove(Task t) {
    if (!isMarked && t.isMarked) return true;
    if (isMarked && !t.isMarked) return false;

    return dueDate.isBefore(t.dueDate);
  }
}
