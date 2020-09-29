
import 'package:hue_control/src/models/hue_control_state.sg.dart';
import 'package:hue_control/src/redux/hue_api_middleware.dart';
import 'package:hue_control/src/redux/hue_control_actions.dart';
import 'package:hue_control/src/redux/reducers/hue_control_reducer.dart';
import 'package:hue_control/src/utils/hue_api.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';


import 'components/app.dart';

class HueControlModule {
  HueApi _hueApi;

  Store<HueControlState> _store;

  HueControlModule() {
    _hueApi = HueApi();

    _store = Store<HueControlState>(
      hueControlReducer,
      initialState: HueControlState((b) => b
        ..isOn = false
        ..brightness = 0
      ),
      middleware: HueApiMiddleware(_hueApi).middleware,
    );

    _hueApi.init()
      .then((_) async {
        final bri = await _hueApi.getBrightness();
        _store.dispatch(SetBrightnessAction(bri, shouldSyncWithServer: false));
      })
      .then((_) async {
        final isOn = await _hueApi.getState();
        _store.dispatch(SetStateAction(isOn, shouldSyncWithServer: false));
      });
  }

  Object content() {
    return (ReduxProvider()
      ..store = _store
    )(
      App()()
    );
  }
}