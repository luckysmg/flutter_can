import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePreviewPage extends StatefulWidget {
  final List<String> imgList;
  final currentIndex;

  const ImagePreviewPage({Key key, this.imgList, this.currentIndex})
      : super(key: key);

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    var content = Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          middle: Text('${currentIndex + 1} / ${widget.imgList.length}',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white))),
      body: ExtendedImageGesturePageView.builder(
        itemBuilder: (BuildContext context, int index) {
          var item = widget.imgList[index];
          Widget image = ExtendedImage.network(
            item,
            enableSlideOutPage: true,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
          );
          image = Padding(
            padding: const EdgeInsets.all(5.0),
            child: image,
          );
          return image;
        },
        itemCount: widget.imgList.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: PageController(
          initialPage: widget.currentIndex,
        ),
        scrollDirection: Axis.horizontal,
      ),
    );

    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      slideEndHandler: (
        Offset offset, {
        ExtendedImageSlidePageState state,
        ScaleEndDetails details,
      }) {
        return defaultSlideEndHandler(offset,
            pageSize: state.pageSize, pageGestureAxis: SlideAxis.both);
      },
      child: content,
    );
  }

  ///默认的交互判别器，当手指滑到屏幕size的1/12，那么就判定可以退出页面
  bool defaultSlideEndHandler(Offset offset,
      {Size pageSize, SlideAxis pageGestureAxis}) {
    if (pageGestureAxis == SlideAxis.both) {
      return offset.distance >
          Offset(pageSize.width, pageSize.height).distance / 20;
    } else if (pageGestureAxis == SlideAxis.horizontal) {
      return offset.dx.abs() > pageSize.width / 20;
    } else if (pageGestureAxis == SlideAxis.vertical) {
      return offset.dy.abs() > pageSize.height / 20;
    }
    return true;
  }
}
