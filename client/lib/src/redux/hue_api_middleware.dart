import 'package:hue_control/src/models/hue_control_state.sg.dart';
import 'package:hue_control/src/redux/hue_control_actions.dart';
import 'package:hue_control/src/utils/hue_api.dart';
import 'package:redux/redux.dart';

class HueApiMiddleware {
  HueApi _hueApi;

  HueApiMiddleware(this._hueApi);

  List<Middleware<HueControlState>> get middleware => [
    TypedMiddleware<HueControlState, SetBrightnessAction>(_handleSetBrightness),
    TypedMiddleware<HueControlState, SetStateAction>(_handleSetState),
  ];

  void _handleSetBrightness(_, SetBrightnessAction action, NextDispatcher next) {
    if (action.shouldSyncWithServer) {
      _hueApi.setBrightness(action.brightness);
    }

    next(action);
  }

  void _handleSetState(_, SetStateAction action, NextDispatcher next) {
    if (action.shouldSyncWithServer) {
      _hueApi.setState(action.isOn);
    }

    next(action);
  }
}