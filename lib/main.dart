import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OasisPlugin {
  static const MethodChannel _channel = const MethodChannel('oasis');

  static Future<String> get deviceInfo async {
    final String version = await _channel.invokeMethod('getDeviceInfo');

    return version;
  }

  static showAlertDialog() async {
    await _channel.invokeMethod('showAlertDialog');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oasis',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LandingPage(title: 'Oasis'),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text("Hello!"),
              onPressed: () => OasisPlugin.showAlertDialog(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
