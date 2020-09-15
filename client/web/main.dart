import 'dart:html';

import 'package:over_react/components.dart';
import 'package:react/react_dom.dart' as react_dom;

import 'package:hue_control/hue-control.dart';

Future main() async {
  final module = HueControlModule();
  
  react_dom.render(
    ErrorBoundary()(
      module.content()
    ),
    querySelector('#app')
  );
}