import 'package:flutter/material.dart';

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
        primarySwatch: Colors.grey,
        canvasColor: Colors.grey.shade300,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'Hello ',
            style: TextStyle(
              color: Colors.green,
              fontSize: 32.0,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'World',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35.0,
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
