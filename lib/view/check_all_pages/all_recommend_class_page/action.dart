import 'package:fish_redux/fish_redux.dart';

enum AllRecommendClassAction { action, loadMore }

class AllRecommendClassActionCreator {
  static Action onAction() {
    return const Action(AllRecommendClassAction.action);
  }

  static Action loadMore() {
    return const Action(AllRecommendClassAction.loadMore);
  }
}
