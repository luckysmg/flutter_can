import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PlanetInfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<PlanetInfoState>>{},
  );
}
