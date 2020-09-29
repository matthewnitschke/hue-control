import 'dart:async';
import 'dart:convert';
import 'dart:html';

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

class HueApi {
  String _username;
  String _groupName;

  String _bridgeIp;
  String _groupId;

  HueApi();

  Future<void> init() async {
    final loc = window.location;
    final port = 3000;
    final env = json.decode(
      await (window.fetch('${loc.protocol}//${loc.hostname}:${port}/env')).then((resp) => resp.text()),
    );
    _username = env['username'];
    _groupName = env['groupName'];

    _bridgeIp = await getBridgeIp();
    _groupId = await resolveGroupId(_groupName);
  }

  Future<String> getBridgeIp() async {
    final resp = await window.fetch('https://discovery.meethue.com/');
    final data = (await resp.json()) as List<dynamic>;

    return data[0].internalipaddress;
  }

  Future<String> resolveGroupId(String groupName) async {
    final data = await _fetch<Map<String, dynamic>>('https://$_bridgeIp/api/$_username/groups');

    String groupId;
    data.forEach((key, value) {
      String name = value['name'];
      if (name == groupName) {
        groupId = key;
      } 
    });

    return groupId;
  }

  Future<double> getBrightness() async {
    final data = await _fetch('https://$_bridgeIp/api/$_username/groups/$_groupId');

    final brightnessNum = data['action']['bri'] as int;

    // convert to a percentage
    return (brightnessNum * 100) / 255;
  }

  Future<bool> getState() async {
    final data = await _fetch('https://$_bridgeIp/api/$_username/groups/$_groupId');

    return data['action']['on'];
  }

  Timer setBrightnessTimer;
  Future<void> setBrightness(double percentage) async {
    if (setBrightnessTimer == null) {
      setBrightnessTimer = Timer(Duration(milliseconds: 100), () async {
        final bri = ((percentage * 255) / 100).round();
        final resp = await window.fetch(
          'https://$_bridgeIp/api/$_username/groups/$_groupId/action',
          {
            'method': 'PUT',
            'body': json.encode({
              'bri': bri
            })
          },
        );

        setBrightnessTimer = null;
      });
    }
  }

  Future<void> setState(bool isOn) async {
    await window.fetch(
      'https://$_bridgeIp/api/$_username/groups/$_groupId/action',
      {
        'method': 'PUT',
        'body': json.encode({
          'on': isOn
        })
      },
    );
  }

  Future<Map<String, dynamic>> _fetch<T>(String url, [dynamic options]) async {
    final resp = await window.fetch(url, options);
    return json.decode(await resp.text()) as Map<String, dynamic>;
  }

}