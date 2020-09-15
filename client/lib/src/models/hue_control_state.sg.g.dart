// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hue_control_state.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HueControlState extends HueControlState {
  factory _$HueControlState([void Function(HueControlStateBuilder) updates]) =>
      (new HueControlStateBuilder()..update(updates)).build();

  _$HueControlState._() : super._();

  @override
  HueControlState rebuild(void Function(HueControlStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HueControlStateBuilder toBuilder() =>
      new HueControlStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HueControlState;
  }

  @override
  int get hashCode {
    return 584098866;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('HueControlState').toString();
  }
}

class HueControlStateBuilder
    implements Builder<HueControlState, HueControlStateBuilder> {
  _$HueControlState _$v;

  HueControlStateBuilder();

  @override
  void replace(HueControlState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HueControlState;
  }

  @override
  void update(void Function(HueControlStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HueControlState build() {
    final _$result = _$v ?? new _$HueControlState._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new