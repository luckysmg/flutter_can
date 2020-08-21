import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_banner_entity.dart';

class BannerState implements Cloneable<BannerState> {
  HomeBannerEntity bannerData;
  int currentIndex;

  @override
  BannerState clone() {
    return BannerState()
      ..bannerData = bannerData
      ..currentIndex = currentIndex;
  }
}
