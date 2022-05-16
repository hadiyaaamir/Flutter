import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

void main() {
  runApp(const MyApp());
}

late Animation<double> animation;
late Animation<double> animation2;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    animation2 = Tween<double>(begin: -1, end: 0).animate(controller);
    controller.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SpringController springController =
        SpringController(initialAnim: Motion.play);

    return Spring.translate(
        child: AnimatedLogo(animation: animation),
        beginOffset: Offset(0, -300),
        endOffset: Offset(0, 0),
        animDuration: const Duration(milliseconds: 3000),
        animStatus: (AnimStatus status) {
          if (status == AnimStatus.completed) {
            setState(() {
              springController.play(
                motion: Motion.reverse,
                curve: Curves.bounceInOut,
              );
            });
          }
        });
  }
}

//anim logo

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final animation2 = listenable as Animation<double>;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
