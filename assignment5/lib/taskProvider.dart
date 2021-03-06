import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  CollectionReference taskList = FirebaseFirestore.instance.collection('Tasks');

  TaskProvider() {
    getTasks();
    notifyListeners();
  }

  List<Task> get tasks {
    return _tasks;
  }

  //get from DB
  void getTasks() async {
    _tasks = [];
    await FirebaseFirestore.instance
        .collection('Tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        addInOrder(Task.fromJson(doc.data() as Map<String, dynamic>));
      });
    });
    notifyListeners();
  }

  //add to DB
  Future<void> addTask(Task t) async {
    await taskList
        .add(t.toJson())
        .then((value) => print("Task Added"))
        .catchError((error) => print("Failed to add task: $error"));

    getTasks();
  }

  //add in order - list
  void addInOrder(Task t) {
    tasks.add(t);

    for (int i = tasks.length - 1; i > 0; i--) {
      if (t.isAbove(tasks[i - 1])) {
        //swap
        Task temp = tasks[i - 1];
        tasks[i - 1] = t;
        tasks[i] = temp;
      }
    }
    // notifyListeners();
  }

  Future<void> removeTask(Task task) async {
    await taskList.where("title", isEqualTo: task.title).get().then((value) {
      taskList.doc(value.docs[0].id).delete().then((value) {
        print("Task Deleted!");
        getTasks();
      });
    });
  }

  Future<void> editTask({
    required Task task,
    required String title,
    required String desc,
    required DateTime date,
  }) async {
    await taskList
        .where('title', isEqualTo: task.title)
        .where('description', isEqualTo: task.description)
        .where('dueDate', isEqualTo: task.dueDate)
        .get()
        .then((value) {
      taskList.doc(value.docs[0].id).update(
          {'title': title, 'description': desc, 'dueDate': date}).then((value) {
        print("Task Edited!");
        task.title = title;
        task.description = desc;
        task.dueDate = date;
        getTasks();
      });
    });
  }

  Future<void> markTask(Task task) async {
    //change in DB

    await taskList.where('title', isEqualTo: task.title).get().then((value) {
      taskList.doc(value.docs[0].id).update(
          {'isMarked': true, 'dateMarked': DateTime.now()}).then((value) async {
        task.isMarked = true;
        task.dateMarked = DateTime.now();
        getTasks();
        print("Task Marked as Done!");
      });
    });
  }

  Future<void> unmarkTask(Task task) async {
    //DB

    await taskList.where('title', isEqualTo: task.title).get().then((value) {
      taskList
          .doc(value.docs[0].id)
          .update({'isMarked': false, 'dateMarked': null}).then((value) async {
        task.isMarked = false;
        task.dateMarked = null;
        getTasks();
        print("Task unmarked!");
      });
    });
  }

  bool isTaskMarked(Task task) {
    return task.isMarked;
  }

  bool isTaskLate(Task task) {
    return task.dueDate.isBefore(DateTime.now()) &&
        task.dueDate.day != DateTime.now().day;
  }

  DateTime getDuedate(Task task) {
    return task.dueDate;
  }
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['isMarked'] = isMarked;
    data['dateMarked'] = dateMarked;
    return data;
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'].toDate(),
      isMarked: json['isMarked'],
      dateMarked:
          json['dateMarked'] != null ? json['dateMarked'].toDate() : null,
    );
  }
}
