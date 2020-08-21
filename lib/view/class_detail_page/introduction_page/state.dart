import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/class_detail_entity.dart';
import 'package:neng/entity/class_dictionary_entity.dart';

class IntroductionState implements Cloneable<IntroductionState> {
  ClassDetailEntity classDetailEntity;
  ClassDictionaryEntity classDictionaryEntity;
  String oid;

  ///现在所选的url
  String currentUrl;

  @override
  IntroductionState clone() {
    return IntroductionState()
      ..currentUrl = currentUrl
      ..oid = oid
      ..classDetailEntity = classDetailEntity
      ..classDictionaryEntity = classDictionaryEntity;
  }
}

IntroductionState initState(Map<String, dynamic> args) {
  return IntroductionState()..oid = args['oid'];
}
