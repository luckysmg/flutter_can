import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EssayDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<EssayDetailState>>{},
  );
}
