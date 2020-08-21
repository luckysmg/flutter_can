import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/curriculum_category_entity.dart';

class ClassLeftState implements Cloneable<ClassLeftState> {
  CurriculumCategoryEntity curriculumCategoryData;
  int currentIndex;

  @override
  ClassLeftState clone() {
    return ClassLeftState()
      ..curriculumCategoryData = curriculumCategoryData
      ..currentIndex = currentIndex;
  }
}
