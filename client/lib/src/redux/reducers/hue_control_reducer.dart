import 'package:hue_control/src/redux/hue_control_actions.dart';
import 'package:redux/redux.dart';
import 'package:hue_control/src/models/hue_control_state.sg.dart';


Reducer<HueControlState> hueControlReducer = combineReducers([
  TypedReducer<HueControlState, SetBrightnessAction>(_setBrightness),
  TypedReducer<HueControlState, SetStateAction>(_setIsOn),
]);

HueControlState _setBrightness(HueControlState state, SetBrightnessAction action) {
  return state.rebuild((b) => b
    ..brightness = action.brightness
  );
}

HueControlState _setIsOn(HueControlState state, SetStateAction action) {
  return state.rebuild((b) => b
    ..isOn = action.isOn
  );
}
