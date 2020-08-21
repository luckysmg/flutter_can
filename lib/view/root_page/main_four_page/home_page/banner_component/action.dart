import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_banner_entity.dart';

enum BannerAction { init, switchIndex }

class BannerActionCreator {
  static Action init(HomeBannerEntity data) {
    return Action(BannerAction.init, payload: data);
  }

  static Action switchIndex(int index) {
    return Action(BannerAction.switchIndex, payload: index);
  }
}
