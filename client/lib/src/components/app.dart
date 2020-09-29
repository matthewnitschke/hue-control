import 'dart:html';

import 'package:hue_control/src/redux/hue_control_actions.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:hue_control/src/models/hue_control_state.sg.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {
  double brightness;
  bool isOn;

  void Function(double) onBrightnessChange;
  void Function(bool) onStateChange;
}

UiFactory<AppProps> App = connect<HueControlState, AppProps>(
  mapStateToProps: (state) => (App()
    ..brightness = state.brightness
    ..isOn = state.isOn
  ),
  mapDispatchToProps: (dispatch) => (App()
    ..onBrightnessChange = ((newValue) => dispatch(SetBrightnessAction(newValue)))
    ..onStateChange = ((isOn) => dispatch(SetStateAction(isOn)))
  ),
)(
  uiFunction((props) {

    final isMouseDown = useState(false);

    void __handleBrightnessChange(e) {
      double percentage = (e.pageX * 100)/window.innerWidth;
      props.onBrightnessChange(percentage);
    }

    return (Dom.div()
      ..className = 'main-container ${props.isOn ? '' : 'off'}'
      ..onMouseDown = ((_) => isMouseDown.set(true))
      ..onMouseUp = ((_) => isMouseDown.set(false))
      ..onClick = __handleBrightnessChange
      ..onMouseMove = ((e) {
        if (isMouseDown.value && props.isOn) {
          __handleBrightnessChange(e);
        }
      })
    )(
      (Dom.div()
        ..className = 'slider'
        ..style = { 'width': '${props.brightness}%' }
      )(),
      (Dom.div()
        ..className = 'percentage'
        ..onDoubleClick = ((_) => props.onStateChange(!props.isOn))
        ..onClick = ((e) {
          e.stopPropagation();
        })
      )(
        props.brightness.toStringAsFixed(0)
      )
    );
  }, $AppConfig, // ignore: undefined_identifier, argument_type_not_assignable
));