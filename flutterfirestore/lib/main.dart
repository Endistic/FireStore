import 'package:flutter/material.dart';
import 'package:flutterfirestore/screen/display.dart';
import 'package:flutterfirestore/screen/formscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            new FormScreen(),
            new DisplayScreen(),
          ],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
              text: "รายการสินค้า",
            ),
            Tab(
              text: "รายการร้านค้า",
            )
          ],
        ),
      ),
      length: 2,
    );
  }
}
