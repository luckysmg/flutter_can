import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const int _windowPopupDuration = 300;
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const Duration _kWindowDuration = Duration(milliseconds: _windowPopupDuration);

typedef OnPop<T> = Function(T t);

///
/// @created by 文景睿
/// description:弹出弹窗的按钮
///
class PopupWindowButton<T> extends StatefulWidget {
  const PopupWindowButton({
    Key key,
    this.child,
    this.window,
    this.offset = Offset.zero,
    this.elevation = 0.1,
    this.duration = 300,
    this.type = MaterialType.card,
    this.onPop,
  }) : super(key: key);

  /// 显示按钮button
  final Widget child;

  /// window 出现的位置。
  final Offset offset;

  /// 阴影
  final double elevation;

  /// 需要显示的window
  final Widget window;

  /// 按钮按钮后到显示window 出现的时间
  final int duration;

  final MaterialType type;

  final Function onPop;

  @override
  _PopupWindowButtonState createState() {
    return _PopupWindowButtonState();
  }
}

void showWindow<T>(
    {@required BuildContext context,
    RelativeRect position,
    @required Widget window,
    double elevation = 8.0,
    int duration = _windowPopupDuration,
    String semanticLabel,
    MaterialType type,
    OnPop onPop}) async {
  T t = await Navigator.push(
    context,
    _PopupWindowRoute<T>(
        position: position,
        child: window,
        elevation: elevation,
        duration: duration,
        semanticLabel: semanticLabel,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        type: type),
  );
  if (onPop != null) {
    onPop(t);
  }
}

class _PopupWindowButtonState<T> extends State<PopupWindowButton> {
  void _showWindow() {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showWindow<T>(
        context: context,
        window: widget.window,
        position: position,
        duration: widget.duration,
        elevation: widget.elevation,
        type: widget.type,
        onPop: widget.onPop);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showWindow,
      child: widget.child,
    );
  }
}

class _PopupWindowRoute<T> extends PopupRoute<T> {
  _PopupWindowRoute({
    this.position,
    this.child,
    this.elevation,
    this.theme,
    this.barrierLabel,
    this.semanticLabel,
    this.duration,
    this.type = MaterialType.card,
  });

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.linear,
        reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd));
  }

  final RelativeRect position;
  final Widget child;
  final double elevation;
  final ThemeData theme;
  final String semanticLabel;
  @override
  final String barrierLabel;
  final int duration;
  final MaterialType type;

  @override
  Duration get transitionDuration =>
      duration == 0 ? _kWindowDuration : Duration(milliseconds: duration);

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black26;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));

    return Builder(
      builder: (BuildContext context) {
        return CustomSingleChildLayout(
          delegate: _PopupWindowLayout(position),
          child: AnimatedBuilder(
              child: child,
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return Opacity(
                  opacity: opacity.evaluate(animation),
                  child: Material(
                    type: type,
                    elevation: elevation,
                    child: child,
                  ),
                );
              }),
        );
      },
    );
  }
}

class _PopupWindowLayout extends SingleChildLayoutDelegate {
  _PopupWindowLayout(this.position);

  final RelativeRect position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y = position.top;
    double x = 0.0;
    if (position.left > position.right) {
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      x = position.left;
    }
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
