import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    BookCollectionState state, Dispatch dispatch, ViewService viewService) {
  print('哈哈');
  return Center(
    child: Text('书'),
  );
}
