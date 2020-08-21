import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/comment_list_entity.dart';

class CommentListState implements Cloneable<CommentListState> {
  CommentListEntity commentsData;

  @override
  CommentListState clone() {
    return CommentListState()..commentsData = commentsData;
  }
}
