import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/certification_entity.dart';

class LeftListState implements Cloneable<LeftListState> {
  ///现在被选中条目的index
  int currentIndex;
  CertificationEntity certificationData;

  @override
  LeftListState clone() {
    return LeftListState()..certificationData = certificationData;
  }
}
