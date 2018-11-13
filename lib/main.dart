import 'package:flutter/material.dart';
import 'dart:async';
import 'controlPanel.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsefulDevice device = UsefulDevice(false);

  void _updateState(bool s) {
    /* Long and verbose function that modifies our device state */
    setState(() {
      device.state = s;
    });
  }

  void _connect() {
    setState(() {
      device.connection = DeviceConnectionState.Connecting;
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        device.connection = DeviceConnectionState.Connected;
      });
    });
  }

  void _disconnect() {
    setState(() {
          device.connection = DeviceConnectionState.Disconnected;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Functional example"),
      ),
      body: Center(child: _buildMainContent()),
    );
  }

  Widget _buildMainContent() {
    switch (device.connection) {
      case DeviceConnectionState.Disconnected:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Not connected"),
            RaisedButton(
              onPressed: _connect,
              child: Text("Connect"),
            )
          ],
        );
      case DeviceConnectionState.Connected:
        return controlPanel(device.state, _updateState, _disconnect);
        //return ControlPanel(device);
      case DeviceConnectionState.Connecting:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Connecting..."),
          ],
        );
    }
  }
}
