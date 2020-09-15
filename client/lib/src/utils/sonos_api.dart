import 'package:redux/redux.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:hue_control/src/models/hue_control_state.sg.dart';
import 'package:hue_control/src/utils/socket.dart';

class HueEventAPI {
  Store<HueControlState> _store;

  HueEventAPI(this._store) {
    final socket = ServerSocket().socket;

    socket.on('something', (res) {
     
    });

  }
}

class HueActionAPI {
  final IO.Socket _socket;

  HueActionAPI() : _socket = ServerSocket().socket;

  void setSomething() {
    _socket.emit('setSomething', 'true');
  }
}