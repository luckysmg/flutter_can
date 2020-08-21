import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/view/collection_page/book_collection_page/page.dart';
import 'package:neng/view/collection_page/class_collection_page/page.dart';
import 'package:neng/view/collection_page/discover_collection_page/page.dart';
import 'package:neng/view/collection_page/exam_collection_page/page.dart';
import 'state.dart';

Widget buildView(
    CollectionState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(44.0),
      child: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(viewService.context),
          icon: Icon(Icons.arrow_back_ios,
              size: Constants.backIconSize, color: Colors.black87),
        ),
        brightness: Brightness.light,
        centerTitle: true,
        backgroundColor: Theme.of(viewService.context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: TabBar(
          onTap: (index) => state.pageController.jumpToPage(index),
          isScrollable: true,
          indicatorColor: ColorUtil.mainColor,
          labelPadding: EdgeInsets.only(left: 15, bottom: 5, right: 15),
          indicatorPadding: EdgeInsets.only(right: 20, left: 20),
          tabs: state.tabs,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: state.tabController,
          unselectedLabelColor: ColorUtil.secondaryTextColor,
          unselectedLabelStyle: TextStyle(
              fontSize: Constants.mainTextSize,
              color: ColorUtil.secondaryTextColor),
          labelStyle: TextStyle(
              fontSize: Constants.mainTextSize,
              color: ColorUtil.mainTextColor,
              fontWeight: FontWeight.w500),
          labelColor: ColorUtil.mainTextColor,
        ),
      ),
    ),
    body: PageView(
      onPageChanged: (index) => state.tabController.animateTo(index),
      controller: state.pageController,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        ClassCollectionPage().buildPage(null),
        DiscoverCollectionPage().buildPage(null),
        CertificateCollectionPage().buildPage(null),
        BookCollectionPage().buildPage(null),
      ],
    ),
  );
}
