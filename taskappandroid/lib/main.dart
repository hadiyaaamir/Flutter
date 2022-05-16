import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskappandroid/createTask.dart';
import 'package:taskappandroid/displayTask.dart';
import 'package:taskappandroid/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Tasks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //context.watch<ListProvider>().createList();
    List<Task> tasks = context.watch<ListProvider>().list;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).

        //child: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (context.watch<ListProvider>().count == 0) ...[
                const Text('You have no pending tasks'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => createTask()));
                  },
                  child: const Text('Add a new task'),
                )
              ],
              if (context.watch<ListProvider>().count != 0) ...[
                Expanded(
                    child: ListView.builder(
                  itemCount: context.watch<ListProvider>().count,
                  itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => displayTask(
                                  i: index,
                                )));
                      },
                      title: Text(
                          context.read<ListProvider>().getname(tasks[index])),
                      subtitle: Text((context
                              .read<ListProvider>()
                              .getdue(tasks[index])
                              .day
                              .toString() +
                          '-' +
                          context
                              .read<ListProvider>()
                              .getdue(tasks[index])
                              .month
                              .toString() +
                          '-' +
                          context
                              .read<ListProvider>()
                              .getdue(tasks[index])
                              .year
                              .toString())),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        GestureDetector(
                          child: (!tasks[index].isDone)
                              ? Icon(
                                  Icons.circle,
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                          onTap: () {
                            if (!tasks[index].isDone) {
                              context
                                  .read<ListProvider>()
                                  .setisdone(true, tasks[index]);
                              context
                                  .read<ListProvider>()
                                  .setdoneon(DateTime.now(), tasks[index]);
                            }
                          },
                        ),
                        ((!tasks[index].isDone) &&
                                tasks[index].due.isBefore(DateTime.now()))
                            ? Container(
                                width: 7,
                                color: Colors.red,
                              )
                            // ? Icon(
                            //     Icons.circle,
                            //     color: Colors.red,
                            //   )
                            : Container(),
                        GestureDetector(
                          child: Icon(
                            Icons.remove_circle,
                          ),
                          onTap: () async {
                            bool del = false;
                            del = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Do you want to delete?'),
                                      content: Text(
                                          'This will remove the item from your cart'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text('No')),
                                      ],
                                    ));
                            if (del) {
                              Navigator.of(context).pop(true);
                              context
                                  .read<ListProvider>()
                                  .deletetask(tasks[index]);
                              // setState(() {});

                            }
                          },
                        ),
                      ])),
                )),
              ]
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
          visible: !tasks.isEmpty,
          child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => createTask()));
              },
              child: Icon(Icons.add))),
    );
  }
}

class Task {
  String name;
  String desc;
  DateTime due;
  bool isDone;
  DateTime? doneOn;

  Task(
      {required this.name,
      required this.desc,
      required this.due,
      required this.isDone,
      this.doneOn});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = name;
    data['desc'] = desc;
    data['due'] = due;
    data['isDone'] = isDone;
    data['doneOn'] = doneOn;

    return data;
  }

  static Task fromJson(Map<String, dynamic> json) => Task(
        name: json['title'],
        desc: json['desc'],
        due: json['due'].toDate(),
        isDone: json['isDone'],
        doneOn: json['doneOn'] != null ? json['doneOn'].toDate() : null,
      );
}
