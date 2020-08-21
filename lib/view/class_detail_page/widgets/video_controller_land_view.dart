import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:orientation/orientation.dart';

enum Speed {
  one,
  onePointFive,
  Two,
}

///横屏视图
class VideoControllerLandView extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;
  final isPortraitUp;

  const VideoControllerLandView({
    @required this.player,
    this.buildContext,
    this.viewSize,
    this.texturePos,
    this.isPortraitUp = true,
  });

  @override
  _VideoControllerLandViewState createState() =>
      _VideoControllerLandViewState();
}

class _VideoControllerLandViewState extends State<VideoControllerLandView> {
  FijkPlayer get player => widget.player;

  Duration _duration = Duration();
  Duration _currentPos = Duration();

  // Duration _bufferPos = Duration();
  bool _playing = false;
  bool _prepared = false;
  String _exception;

  // bool _buffering = false;

  double _seekPos = -1.0;

  StreamSubscription _currentPosSubs;

  //StreamSubscription _bufferPosSubs;
  //StreamSubscription _bufferingSubs;

  Timer _hideTimer;
  bool _hideStuff = true;

  double _volume = 1.0;

  final barHeight = 40.0;
  bool isPortraitUp;

  Speed speed;

  @override
  void initState() {
    super.initState();
    speed = Speed.one;
    isPortraitUp = widget.isPortraitUp;
    _duration = player.value.duration;
    _currentPos = player.currentPos;
    //_bufferPos = player.bufferPos;
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;
    _exception = player.value.exception.message;
    // _buffering = player.isBuffering;

    player.addListener(_playerValueChanged);

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
      });
    });
  }

  void _playerValueChanged() {
    FijkValue value = player.value;
    if (value.duration != _duration) {
      setState(() {
        _duration = value.duration;
      });
    }

    bool playing = (value.state == FijkState.started);
    bool prepared = value.prepared;
    String exception = value.exception.message;
    if (playing != _playing ||
        prepared != _prepared ||
        exception != _exception) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
        _exception = exception;
      });
    }
  }

  void _playOrPause() {
    if (_playing == true) {
      player.pause();
    } else {
      player.start();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _hideTimer?.cancel();
    player.removeListener(_playerValueChanged);
    _currentPosSubs?.cancel();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _cancelAndRestartTimer() {
    if (_hideStuff == true) {
      _startHideTimer();
    }
    setState(() {
      _hideStuff = !_hideStuff;
    });
  }

  Widget _buildBottomBar(BuildContext context) {
    double duration = _duration.inMilliseconds.toDouble();
    double currentValue =
        _seekPos > 0 ? _seekPos : _currentPos.inMilliseconds.toDouble();
    currentValue = min(currentValue, duration);
    currentValue = max(currentValue, 0);
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 0.6,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: barHeight * 2.3,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildSlider(currentValue, duration),
            Row(
              children: <Widget>[
                ///左边的音量图标
                GestureDetector(
                  onTap: _playOrPause,
                  child: _playing
                      ? Icon(
                          Icons.pause_circle_filled,
                          color: Colors.white,
                          size: 34,
                        )
                      : Icon(
                          Icons.play_circle_filled,
                          color: Colors.white,
                          size: 34,
                        ),
                ),
                Gap.makeGap(width: 20),

                ///现在播放的进度

                Text(
                  '${_duration2String(_currentPos)}',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),

                Text("/").withStyle(color: Colors.white70),

                Text(
                  '${_duration2String(_duration)}',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),

                const Spacer(),

                ///倍速按钮
                _buildSpeedText(speed),

                ///切换非全屏
                GestureDetector(
                    onTap: () {
                      performPop();
                    },
                    child: Icon(
                      Icons.screen_rotation,
                      color: Colors.white,
                      size: 20,
                    )),
                Gap.makeGap(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performPop() async {
    await OrientationPlugin.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
    await OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    await Future.delayed(const Duration(milliseconds: 300));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = player.value.fullScreen
        ? Rect.fromLTWH(0, 0, widget.viewSize.width, widget.viewSize.height)
        : Rect.fromLTRB(
            max(0.0, widget.texturePos.left),
            max(0.0, widget.texturePos.top),
            min(widget.viewSize.width, widget.texturePos.right),
            min(widget.viewSize.height, widget.texturePos.bottom));
    return WillPopScope(
      onWillPop: () async {
        await performPop();
        return false;
      },
      child: Positioned.fromRect(
        rect: rect,
        child: GestureDetector(
          onTap: _cancelAndRestartTimer,
          child: AbsorbPointer(
            absorbing: _hideStuff,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _cancelAndRestartTimer();
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                          child: _exception != null
                              ? Text(
                                  _exception,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                )
                              : (_prepared ||
                                      player.state == FijkState.initialized)
                                  ? AnimatedOpacity(
                                      opacity: _hideStuff ? 0.0 : 0.7,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: _playing
                                          ? GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: _playOrPause,
                                              child: Icon(
                                                Icons.pause,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                            )
                                          : GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: _playOrPause,
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                            ),
                                    )
                                  : SizedBox(
                                      width: barHeight * 1,
                                      height: barHeight * 1,
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white)),
                                    )),
                    ),
                  ),
                ),
                _buildBottomBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedText(Speed speed) {
    var text;
    switch (speed) {
      case Speed.one:
        text = '1X';
        break;
      case Speed.onePointFive:
        text = '1.5X';
        break;
      case Speed.Two:
        text = '2X';
        break;
    }
    return Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Text(text).withStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500));
  }

  Widget _buildSlider(currentValue, duration) {
    return Slider(
      activeColor: ColorUtil.mainColor,
      value: currentValue,
      min: 0.0,
      max: duration,
      onChangeStart: (_) {
        ///开始拖拽时取消currentPos的更新
        _currentPosSubs.cancel();
      },
      onChanged: (v) {
        _startHideTimer();

        ///在时间栏实时更新currentPos
        setState(() {
          _seekPos = v;
          _currentPos = Duration(milliseconds: _seekPos.toInt());
        });
      },
      onChangeEnd: (v) {
        ///拖拽放手后继续进行监听
        _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
          setState(() {
            _currentPos = v;
          });
        });

        setState(() {
          player.seekTo(v.toInt());
          _currentPos = Duration(milliseconds: _seekPos.toInt());
          _seekPos = -1;
        });
      },
    );
  }

  Widget _buildTopBar() {
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 0.3,
      duration: const Duration(milliseconds: 200),
      child: Container(
        color: Colors.black,
        alignment: Alignment.centerLeft,
        height: barHeight,
        child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '标题',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}

String _duration2String(Duration duration) {
  if (duration.inMilliseconds < 0) return "-: negtive";

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  int inHours = duration.inHours;
  return inHours > 0
      ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}
