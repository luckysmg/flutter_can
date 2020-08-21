import 'dart:typed_data';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/redux/base_state.dart';

class BuildPlanetState with BaseState implements Cloneable<BuildPlanetState> {
  TextEditingController textEditingController;
  FocusNode focusNode;
  Uint8List img;

  @override
  BuildPlanetState clone() {
    return BuildPlanetState()
      ..hasNetworkError = hasNetworkError
      ..focusNode = focusNode
      ..textEditingController = textEditingController
      ..img = img;
  }
}

BuildPlanetState initState(Map<String, dynamic> args) {
  return BuildPlanetState()
    ..textEditingController = TextEditingController()
    ..focusNode = FocusNode();
}
