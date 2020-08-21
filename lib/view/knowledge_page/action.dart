import 'package:fish_redux/fish_redux.dart';

enum KnowledgeAction { loadMore, update, reload }

class KnowledgeActionCreator {
  static Action loadMore() {
    return const Action(KnowledgeAction.loadMore);
  }

  static Action update() {
    return const Action(KnowledgeAction.update);
  }

  static Action reload() {
    return const Action(KnowledgeAction.reload);
  }
}
