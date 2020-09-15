import 'package:redux/redux.dart';
import 'package:hue_control/src/models/hue_control_state.sg.dart';


Reducer<HueControlState> hueControlReducer = combineReducers([
  // TypedReducer<SonosControlState, SetSpeakersAction>(_setSpeakers),
]);

// SonosControlState _setSpeakers(SonosControlState state, SetSpeakersAction action) {
//   return state.rebuild((b) => b
//     ..speakers = action.speakers.toBuilder()
//   );
// }
