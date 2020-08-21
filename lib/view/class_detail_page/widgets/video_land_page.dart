import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';

import 'video_controller_land_view.dart';

///
/// @created by 文景睿
/// description:横屏页面
///
class VideoLandPage extends StatefulWidget {
  final FijkPlayer player;

  const VideoLandPage({Key key, this.player}) : super(key: key);

  @override
  _VideoLandPageState createState() => _VideoLandPageState();
}

class _VideoLandPageState extends State<VideoLandPage> {
  bool isHero;

  @override
  void initState() {
    super.initState();
    isHero = false;
    OrientationPlugin.setPreferredOrientations(
        [DeviceOrientation.landscapeRight]);
    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
    setUpHeroView();
  }

  @override
  Widget build(BuildContext context) {
    var videoView = FijkView(
      player: widget.player,
      color: Colors.black,
      panelBuilder: (player, data, ctx, viewSize, rect) {
        return VideoControllerLandView(
          player: player,
          viewSize: viewSize,
          texturePos: rect,
          buildContext: ctx,
        );
      },
    );

    if (isHero) {
      return Scaffold(
        body: Hero(
          tag: 'video',
          child: videoView,
        ),
      );
    }
    return Scaffold(
      body: videoView,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setUpHeroView() async {
    await Future.delayed(Duration(milliseconds: 500));
    isHero = true;
    setState(() {});
  }
}
