import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neng/util/color_util.dart';
import 'package:neng/util/gap.dart';
import 'package:neng/view/root_page/main_four_page/home_page/banner_component/action.dart';
import 'package:neng/widgets/load_asset_image.dart';

import 'state.dart';

Widget buildView(
    BannerState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: SizedBox(
      height: 165,
      child: state.bannerData == null
          ? Gap.empty
          : Column(
              children: <Widget>[
                Gap.makeGap(height: 5),
                CarouselSlider.builder(
                  height: 150,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  itemCount: state.bannerData.data.length,
                  onPageChanged: (index) {
                    dispatch(BannerActionCreator.switchIndex(index));
                  },
                  itemBuilder: (BuildContext context, int itemIndex) => Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: state.bannerData.data[itemIndex].imageUrl,
                        fit: BoxFit.fitHeight,
                        placeholder: (_, __) => LoadAssetImage(
                          'default/pic_blank_banner',
                          fit: BoxFit.fitHeight,
                        ),
                        errorWidget: (_, __, ___) => LoadAssetImage(
                          'default/pic_blank_banner',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap.makeGap(height: 5),
                ///显示的点
                _buildIndicators(state, dispatch, viewService),
              ],
            ),
    ),
  );
}

Widget _buildIndicators(
    BannerState state, Dispatch dispatch, ViewService viewService) {
  var highlightColor = ColorUtil.mainColor;
  var normalColor = ColorUtil.auxiliaryColor;
  List<Widget> widgetList =
      List.generate(state.bannerData.data.length, (index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: state.currentIndex == index ? 10 : 5,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: state.currentIndex == index ? highlightColor : normalColor,
      ),
    );
  });
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgetList,
  );
}
