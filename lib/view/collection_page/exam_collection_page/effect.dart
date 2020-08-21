import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CertificateCollectionState> buildEffect() {
  return combineEffects(<Object, Effect<CertificateCollectionState>>{
    CertificateCollectionAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CertificateCollectionState> ctx) {}
