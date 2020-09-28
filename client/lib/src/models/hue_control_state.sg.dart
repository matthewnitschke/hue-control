import 'package:built_value/built_value.dart';

part 'hue_control_state.sg.g.dart';

abstract class HueControlState implements Built<HueControlState, HueControlStateBuilder> {

  double get brightness;

  factory HueControlState([void Function(HueControlStateBuilder) updates]) = _$HueControlState;
  HueControlState._();
}