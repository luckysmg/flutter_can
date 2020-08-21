import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/book_detail_entity.dart';

class BookDetailIntroductionState
    implements Cloneable<BookDetailIntroductionState> {
  BookDetailEntity bookDetailData;

  @override
  BookDetailIntroductionState clone() {
    return BookDetailIntroductionState()..bookDetailData = bookDetailData;
  }
}
