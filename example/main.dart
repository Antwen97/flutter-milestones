import 'package:flutter/material.dart';
import 'package:flutter_milestones/flutter_milestones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.title),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 50
            ),
            child: Milestones(
              items: [
                MilestoneElement(
                    reached: true,
                    title: 'Title 1',
                    details: [
                      (true, 'Detail 1'),
                      (true, 'Detail 2'),
                      (true, 'Detail 3')
                    ],
                    verticalDividerLength: 100,
                    milestoneColor: Colors.red
                ),
                MilestoneElement(
                    reached: true,
                    title: 'Title 2',
                    milestoneChild: Text(
                      'Ok',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                    details: [
                      (true, 'Detail 1'),
                      (true, 'Detail 2'),
                      (false, 'Detail 3')
                    ],
                    milestoneColor: Colors.orange
                ),
                MilestoneElement(
                    reached: false,
                    title: 'Title 3',
                    milestoneChild: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                    details: [
                      (false, 'Detail 1'),
                      (false, 'Detail 2'),
                      (false, 'Detail 3')
                    ],
                    milestoneColor: Colors.blue
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
