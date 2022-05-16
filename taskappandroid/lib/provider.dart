import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskappandroid/main.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasklist = [];
  ListProvider() {
    createList();
  }
  createList() {
    tasklist = [];
    FirebaseFirestore.instance
        .collection('tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        tasklist.add(Task.fromJson(doc.data() as Map<String, dynamic>));
        notifyListeners();
      });
    });
  }

  List<Task> get list => tasklist;
  int get count => tasklist.length;
  String getname(Task t) => t.name;
  String getdesc(Task t) => t.desc;
  bool getisDone(Task t) => t.isDone;
  DateTime getdue(Task t) => t.due;
  getdoneOn(Task t) async => t.doneOn;

  Future<void> edittask(Task old, Task t) {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    return FirebaseFirestore.instance
        .collection('tasks')
        .where('title', isEqualTo: old.name)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        batch.update(doc.reference, {
          'title': t.name,
          'desc': t.desc,
          'due': t.due,
        });
      });
      notifyListeners();
      createList();
      return batch.commit();
    });
  }

  void setname(String name, Task t) {
    t.name = name;
    notifyListeners();
  }

  void setdesc(String des, Task t) {
    t.desc = des;
    notifyListeners();
  }

  void setisdone(bool done, Task t) {
    t.isDone = done;
    Task temp = t;
    // deletetask(t);
    // addnewtask(temp);
    WriteBatch batch = FirebaseFirestore.instance.batch();
    FirebaseFirestore.instance
        .collection('tasks')
        .where('title', isEqualTo: t.name)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        batch.update(doc.reference, {
          'isDone': done,
        });
      });
      notifyListeners();
      return batch.commit();
    });

    notifyListeners();
  }

  void setdue(DateTime due, Task t) {
    t.due = due;
    notifyListeners();
  }

  void setdoneon(DateTime doneon, Task t) {
    t.doneOn = doneon;
    WriteBatch batch = FirebaseFirestore.instance.batch();
    FirebaseFirestore.instance
        .collection('tasks')
        .where('title', isEqualTo: t.name)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        batch.update(doc.reference, {
          'doneOn': doneon,
        });
      });
      return batch.commit();
    });
    notifyListeners();
  }

  void addnewtask(Task t) {
    tasklist.add(t);
    addTask(t);

    for (int i = tasklist.length - 1; i > 0; i--) {
      if (t.due.isBefore(tasklist[i - 1].due)) {
        Task temp = tasklist[i - 1];
        tasklist[i - 1] = t;
        tasklist[i] = temp;
      }
    }
    for (int i = tasklist.length - 1; i > 0; i--) {
      if (!(t.isDone) && (tasklist[i - 1].isDone)) {
        Task temp = tasklist[i - 1];
        tasklist[i - 1] = t;
        tasklist[i] = temp;
      }
    }

    notifyListeners();
  }

  void deletetask(Task t) {
    tasklist.remove(t);
    notifyListeners();
  }

  Future<void> addTask(Task t) async {
    // Call the user's CollectionReference to add a new user
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    final task = t;
    tasks
        .add(task.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    //createList();
    notifyListeners();
  }
}
