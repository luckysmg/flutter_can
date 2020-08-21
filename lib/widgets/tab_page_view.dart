import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabPageView extends StatefulWidget {
  final List<Widget> tabs;
  List<Widget> pages;
  IndexedWidgetBuilder builder;
  int itemCount;
  bool isScrollable;
  Color indicatorColor;
  double indicatorWeight = 2.0;
  EdgeInsets indicatorPadding = EdgeInsets.zero;
  Decoration indicator;
  TabBarIndicatorSize indicatorSize;
  Color labelColor;
  TextStyle labelStyle;
  EdgeInsets labelPadding;
  Color unselectedLabelColor;
  TextStyle unselectedLabelStyle;
  DragStartBehavior dragStartBehavior = DragStartBehavior.start;
  Alignment tabAlignment;
  ScrollPhysics physics;

  TabPageView({
    Key key,
    @required this.tabs,
    @required this.pages,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.tabAlignment,
    this.physics,
  });

  TabPageView.builder({
    @required this.tabs,
    @required this.itemCount,
    @required this.builder,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.tabAlignment,
    this.physics,
  });

  @override
  _TabPageViewState createState() => _TabPageViewState();
}

class _TabPageViewState extends State<TabPageView>
    with TickerProviderStateMixin {
  TabController tabController;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this);
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    ///非builder模式
    if (widget.builder == null) {
      return Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              alignment: widget.tabAlignment,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TabBar(
                isScrollable: widget.isScrollable,
                dragStartBehavior: widget.dragStartBehavior,
                indicatorPadding: widget.indicatorPadding,
                indicatorSize: widget.indicatorSize,
                unselectedLabelStyle: widget.unselectedLabelStyle,
                unselectedLabelColor: widget.unselectedLabelColor,
                labelStyle: widget.labelStyle,
                indicatorWeight: widget.indicatorWeight,
                indicator: widget.indicator,
                labelPadding: widget.labelPadding,
                indicatorColor: widget.indicatorColor,
                labelColor: widget.labelColor,
                onTap: (index) {
                  pageController.jumpToPage(index);
                },
                controller: tabController,
                tabs: widget.tabs,
              )),
          Expanded(
            child: PageView(
              physics: widget.physics,
              dragStartBehavior: DragStartBehavior.down,
              controller: pageController,
              onPageChanged: (index) {
                tabController.animateTo(index);
              },
              children: widget.pages,
            ),
          ),
        ],
      );
    }

    ///builder模式
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            alignment: widget.tabAlignment,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              isScrollable: widget.isScrollable,
              dragStartBehavior: widget.dragStartBehavior,
              indicatorPadding: widget.indicatorPadding,
              indicatorSize: widget.indicatorSize,
              unselectedLabelStyle: widget.unselectedLabelStyle,
              unselectedLabelColor: widget.unselectedLabelColor,
              labelStyle: widget.labelStyle,
              indicatorWeight: widget.indicatorWeight,
              indicator: widget.indicator,
              labelPadding: widget.labelPadding,
              indicatorColor: widget.indicatorColor,
              labelColor: widget.labelColor,
              onTap: (index) {
                pageController.jumpToPage(index);
              },
              controller: tabController,
              tabs: widget.tabs,
            )),
        Expanded(
          child: PageView.builder(
            physics: widget.physics,
            itemCount: widget.itemCount,
            itemBuilder: widget.builder,
            controller: pageController,
            onPageChanged: (index) {
              tabController.animateTo(index);
            },
          ),
        ),
      ],
    );
  }
}
