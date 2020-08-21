import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/comment_list_entity.dart';

class BookDetailCommentListState
    implements Cloneable<BookDetailCommentListState> {
  String oid;
  CommentListEntity commentsData;

  @override
  BookDetailCommentListState clone() {
    return BookDetailCommentListState()
      ..commentsData = commentsData
      ..oid = oid;
  }
}
