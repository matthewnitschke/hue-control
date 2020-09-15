import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:hue_control/src/models/hue_control_state.sg.dart';

part 'app.over_react.g.dart';

mixin AppProps on UiProps {
  String backgroundColor;
}

UiFactory<AppProps> App = connect<HueControlState, AppProps>(
  mapStateToProps: (state) => App(),
  mapDispatchToProps: (dispatch) => App(),
)(
  uiFunction((props) {
    return (Dom.div()
      ..className = 'main-container'
      ..style = {
        'backgroundColor': '#${props.backgroundColor}'
      }
    )(
      "Suh"
    );
  }, $AppConfig, // ignore: undefined_identifier, argument_type_not_assignable
));