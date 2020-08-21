import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_extension/jr_extension.dart';
import 'package:neng/route/custom_routes.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/view/class_detail_page/widgets/video_land_page.dart';

///
/// @created by 文景睿
/// description:
///
class VideoControllerView extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;
  final isPortraitUp;

  const VideoControllerView({
    @required this.player,
    this.buildContext,
    this.viewSize,
    this.texturePos,
    this.isPortraitUp = true,
  });

  @override
  _VideoControllerViewState createState() => _VideoControllerViewState();
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

class _VideoControllerViewState extends State<VideoControllerView> {
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

  @override
  void initState() {
    super.initState();
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: barHeight,
        color: Colors.black,
        child: Row(
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
                      )),
//            IconButton(
//                icon: Icon(
//                  _volume > 0 ? Icons.volume_up : Icons.volume_off,
//                  color: Colors.white,
//                ),
//                padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                onPressed: () {
//                  setState(() {
//                    _volume = _volume > 0 ? 0.0 : 1.0;
//                    player.setVolume(_volume);
//                  });
//                }),

            ///进度条
            _duration.inMilliseconds == 0
                ? Expanded(
                    child: Center(),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0),
                      child: Row(
                        children: <Widget>[
                          CupertinoSlider(
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
                                _currentPos =
                                    Duration(milliseconds: _seekPos.toInt());
                              });
                            },
                            onChangeEnd: (v) {
                              ///拖拽放手后继续进行监听
                              _currentPosSubs =
                                  player.onCurrentPosUpdate.listen((v) {
                                setState(() {
                                  _currentPos = v;
                                });
                              });

                              setState(() {
                                player.seekTo(v.toInt());
                                _currentPos =
                                    Duration(milliseconds: _seekPos.toInt());
                                _seekPos = -1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

            ///现在播放的进度
            Padding(
              padding: EdgeInsets.only(right: 5.0, left: 5),
              child: Text(
                '${_duration2String(_currentPos)}',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),

            Text("/").withStyle(color: Colors.white70),

            ///总时间
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 5),
              child: Text(
                '${_duration2String(_duration)}',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),

            ///切换全屏
            GestureDetector(
                onTap: () async {
                  await Navigator.push(context,
                      GradualChangePageRoute(VideoLandPage(player: player)));
                },
                child: Icon(
                  Icons.zoom_out_map,
                  size: 24,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
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
    return Positioned.fromRect(
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
                                    duration: const Duration(milliseconds: 200),
                                    child: _playing
                                        ? GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: _playOrPause,
                                            child: Icon(
                                              Icons.pause,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          )
                                        : GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: _playOrPause,
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                  )
                                : SizedBox(
                                    width: barHeight * 1.5,
                                    height: barHeight * 1.5,
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white)),
                                  ).offset(offset: Offset(0, 30))),
                  ),
                ),
              ),
              _buildBottomBar(context),
            ],
          ),
        ),
      ),
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
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
