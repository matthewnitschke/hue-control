
import 'package:hue_control/src/models/hue_control_state.sg.dart';
import 'package:hue_control/src/redux/reducers/hue_control_reducer.dart';
import 'package:hue_control/src/utils/sonos_api.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';


import 'components/app.dart';

class HueControlModule {
  HueActionAPI _sonosActionApi;

  Store<HueControlState> _store;

  HueControlModule() {
    _sonosActionApi = HueActionAPI();



    _store = Store<HueControlState>(
      hueControlReducer,
      initialState: HueControlState((b) => b
        ..brightness = 50.0
      ),
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