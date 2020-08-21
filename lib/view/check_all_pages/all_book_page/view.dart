import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neng/util/constants.dart';
import 'package:neng/util/navigatior_util.dart';
import 'package:neng/view/book_detail_page/page.dart';
import 'package:neng/widgets/custom_navigation_bar.dart';
import 'package:neng/widgets/load_asset_image.dart';
import 'package:neng/widgets/loading_view.dart';
import 'package:neng/widgets/network_error_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AllBookState state, Dispatch dispatch, ViewService viewService) {
  var body;
  if (state.hasNetworkError) {
    body = NetworkErrorView(
      onTapButton: () => dispatch(LifecycleCreator.initState()),
    );
  } else if (state.recommendBookData == null) {
    body = LoadingView();
  } else {
    body = SmartRefresher(
      enablePullUp: true,
      onRefresh: () => dispatch(LifecycleCreator.initState()),
      onLoading: () => dispatch(AllBookActionCreator.loadMore()),
      physics: const BouncingScrollPhysics(),
      controller: state.refreshController,
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
        itemCount: state.recommendBookData.rows.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) => _item(state, dispatch, context, index),
      ),
    );
  }

  return Scaffold(
    appBar: CustomNavigationBar(
      title: '推荐书籍',
    ),
    body: body,
  );
}

Widget _item(
    AllBookState state, Dispatch dispatch, BuildContext context, int index) {
  var itemData = state.recommendBookData.rows[index];
  return GestureDetector(
    onTap: () => NavigatorUtil.push(
      context,
      BookDetailPage().buildPage({'oid': itemData.oid}),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: SizedBox(
            height: ScreenUtil().setHeight(220),
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: itemData.cover,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => LoadAssetImage(
                'default/pic_blank_book',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(itemData.name,
            maxLines: 2, style: TextStyle(fontSize: Constants.secondTextSize)),
      ],
    ),
  );
}
