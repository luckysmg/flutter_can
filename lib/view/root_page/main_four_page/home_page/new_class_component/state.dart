import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/home_class_entity.dart';

class NewClassState implements Cloneable<NewClassState> {
  HomeClassEntity newClassData;

  @override
  NewClassState clone() {
    return NewClassState()..newClassData = newClassData;
  }
}
