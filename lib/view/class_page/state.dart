import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:neng/entity/curriculum_category_entity.dart';
import 'package:neng/redux/base_state.dart';

import 'class_left_component/state.dart';
import 'class_right_component/state.dart';

class ClassState with BaseState implements Cloneable<ClassState> {
  ///现在显示的左边的条目的index
  int currentIndex;
  CurriculumCategoryEntity curriculumCategoryData;
  ScrollController rightScrollController;

  @override
  ClassState clone() {
    return ClassState()
      ..hasNetworkError = hasNetworkError
      ..curriculumCategoryData = curriculumCategoryData
      ..rightScrollController = rightScrollController;
  }
}

ClassState initState(Map<String, dynamic> args) {
  return ClassState()
    ..currentIndex = 0
    ..rightScrollController = ScrollController();
}

class ClassLeftConnector extends ConnOp<ClassState, ClassLeftState> {
  @override
  ClassLeftState get(ClassState state) {
    final ClassLeftState subState = ClassLeftState();
    subState.currentIndex = state.currentIndex;
    subState.curriculumCategoryData = state.curriculumCategoryData;
    return subState;
  }

  @override
  void set(ClassState state, ClassLeftState subState) {
    state.currentIndex = subState.currentIndex;
    state.curriculumCategoryData = subState.curriculumCategoryData;
  }
}

class ClassRightConnector extends ConnOp<ClassState, ClassRightState> {
  @override
  ClassRightState get(ClassState state) {
    final ClassRightState subState = ClassRightState();
    subState.scrollController = state.rightScrollController;
    subState.currentIndex = state.currentIndex;
    subState.curriculumCategoryData = state.curriculumCategoryData;
    return subState;
  }

  @override
  void set(ClassState state, ClassRightState subState) {
    state.rightScrollController = subState.scrollController;
    state.currentIndex = subState.currentIndex;
    state.curriculumCategoryData = subState.curriculumCategoryData;
  }
}
