import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/redux/base_state.dart';

class ClassDetailState with BaseState implements Cloneable<ClassDetailState> {
  PageController pageController;
  String oid;
  ScrollController scrollController;
  FijkPlayer player;

  @override
  ClassDetailState clone() {
    return ClassDetailState()
      ..hasNetworkError = hasNetworkError
      ..oid = oid
      ..pageController = pageController
      ..scrollController = scrollController
      ..player = player;
  }
}

ClassDetailState initState(Map<String, dynamic> args) {
  FijkPlayer player = FijkPlayer();
  FijkOption option = FijkOption();
  option.setCodecOption('skip_loop_filter', 0);
  option.setFormatOption('analyzemaxduration', 100);
  option.setFormatOption('analyzeduration', 1);
  option.setPlayerOption('max-buffer-size', 1024 * 1024 * 2);
  option.setPlayerOption('videotoolbox', 1);
  option.setPlayerOption('enable-accurate-seek', 1);
  option.setFormatOption('fflags', 'fastseek');
  option.setFormatOption('probesize', 1024 * 100);
  option.setPlayerOption('max-fps', 60);
  player.applyOptions(option);

  return ClassDetailState()
    ..oid = args['oid']
    ..pageController = PageController()
    ..scrollController = ScrollController()
    ..player = player;
}
