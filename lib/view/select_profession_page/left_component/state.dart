import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/profession_list_entity.dart';

class LeftState implements Cloneable<LeftState> {
  int currentIndex;
  ProfessionListEntity professionListData;

  @override
  LeftState clone() {
    return LeftState()
      ..currentIndex = currentIndex
      ..professionListData = professionListData;
  }
}
