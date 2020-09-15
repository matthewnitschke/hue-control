
import 'package:hue_control/src/models/hue_control_state.sg.dart';
import 'package:hue_control/src/utils/sonos_api.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';


import 'components/app.dart';

class HueControlModule {
  HueActionAPI _sonosActionApi;

  Store<HueControlState> _store;

  SonosControlModule() {
    _sonosActionApi = HueActionAPI();

    HueControlState appStateReducers(HueControlState state, action) => (HueControlStateBuilder()
    ).build();

    _store = Store<HueControlState>(
      appStateReducers,
      initialState: HueControlState(),
      // middleware: SonosAPIMiddleware(_sonosActionApi).middleware,
    );

    HueEventAPI(_store);
  }

  Object content() {
    return (ReduxProvider()
      ..store = _store
    )(
      App()()
    );
  }
}