import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _SingleTickerProviderStfState<T> extends ComponentState<T>
    with SingleTickerProviderStateMixin {}

mixin SingleTickerProviderMixin<T> on Component<T> {
  @override
  _SingleTickerProviderStfState<T> createState() =>
      _SingleTickerProviderStfState<T>();
}

///示例
//class ComponentSingleTicker<T> extends Component<T>
//    with SingleTickerProviderMixin<T> {
//  ComponentSingleTicker()
//      : super(
//    view: null,
//    effect: (Action action, Context<T> ctx) {
//      if (action.type == Lifecycle.initState) {
//        final Object tickerProvider = ctx.stfState;
//        AnimationController controller =
//        AnimationController(vsync: tickerProvider);
//
//        /balabala
//      }
//      return null;
//    },
//  );
//}

class KeepAliveWidget extends StatefulWidget {
  final Widget child;

  const KeepAliveWidget(this.child);

  @override
  State<StatefulWidget> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

Widget keepAliveWrapper(Widget child) => KeepAliveWidget(child);

///示例
//class ReportComponent extends Component<ReportState> {
//  ReportComponent()
//      : super(
//    view: buildView,
//    wrapper: keepAliveWrapper,
//  );
//}
