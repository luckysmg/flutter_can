import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:neng/entity/curriculum_category_entity.dart';

class ClassRightState implements Cloneable<ClassRightState> {
  CurriculumCategoryEntity curriculumCategoryData;
  int currentIndex;
  ScrollController scrollController;

  @override
  ClassRightState clone() {
    return ClassRightState()
      ..curriculumCategoryData = curriculumCategoryData
      ..scrollController = scrollController
      ..currentIndex = currentIndex;
  }
}
