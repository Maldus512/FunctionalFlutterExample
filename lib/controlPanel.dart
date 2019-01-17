import 'package:flutter/material.dart';
import 'main.dart';

enum DeviceConnectionState { Disconnected, Connecting, Connected }

class UsefulDevice {
  UsefulDevice(this.state);
  bool state;
  DeviceConnectionState connection = DeviceConnectionState.Disconnected;
}

// Approach of a Widget-returning function
Widget controlPanel(bool state, Function(bool) updateStateCallback,
    Function disconnectCallback) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text("Connected"),
      RaisedButton(
        child: Text(state ? "ON" : "OFF"),
        color: state ? Colors.green : Colors.red,
        onPressed: () => updateStateCallback(!state),
      ),
      FlatButton(
        child: Text("Disconnect"),
        onPressed: disconnectCallback,
      ),
    ],
  );
}

//Approach of a StatelessWidget + InheritedWidget
class StatelessControlPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = AppCentralState.of(context);
    return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text("Connected"),
      RaisedButton(
        child: Text(state.device.state ? "ON" : "OFF"),
        color: state.device.state ? Colors.green : Colors.red,
        onPressed: () => state.updateStateCallback(!state.device.state),
      ),
      FlatButton(
        child: Text("Disconnect"),
        onPressed: state.disconnectCallback,
      ),
    ],
  );
  }
}


//Approach of a StatefulWidget
class ControlPanel extends StatefulWidget {
  ControlPanel(this.device, {Key key}) : super(key: key);
  final UsefulDevice device;

  @override
  _ControlPanelState createState() => _ControlPanelState(device);
}

class _ControlPanelState extends State<ControlPanel> {
  _ControlPanelState(this.device);
  UsefulDevice device;

  void _updateState(bool state) {
    setState(() {
      device.state = state;
    });
  }

  void _disconnect() {
    setState(() {
      device.connection = DeviceConnectionState.Disconnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Connected"),
        RaisedButton(
          child: Text(device.state ? "ON" : "OFF"),
          color: device.state ? Colors.green : Colors.red,
          onPressed: () => _updateState(!device.state),
        ),
        FlatButton(
          child: Text("Disconnect"),
          onPressed: _disconnect,
        ),
      ],
    );
  }
}
