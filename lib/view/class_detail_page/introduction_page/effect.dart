import 'package:fish_redux/fish_redux.dart';
import 'package:neng/entity/class_detail_entity.dart';
import 'package:neng/entity/class_dictionary_entity.dart';
import 'package:neng/entity/collection_entity.dart';
import 'package:neng/net/api.dart';
import 'package:neng/net/dio_util.dart';
import 'package:neng/util/tip_util.dart';
import 'package:neng/util/toast_util.dart';
import 'package:neng/view/class_detail_page/action.dart';
import 'package:neng/view/class_detail_page/introduction_page/action.dart';

import 'state.dart';

Effect<IntroductionState> buildEffect() {
  return combineEffects(<Object, Effect<IntroductionState>>{
    Lifecycle.initState: _init,
    IntroductionAction.collect: _collect,
    IntroductionAction.changeUrl: _changeUrl,
  });
}

void _init(Action action, Context<IntroductionState> ctx) async {
  ///请求课程详情信息
  var getDetailData = DioUtil.getInstance().doPost<ClassDetailEntity>(
      url: API.class_detail + '/${ctx.state.oid}',
      context: ctx.context,
      needDelay: true,
      onSuccess: (data) {
        ctx.state.classDetailEntity = data;
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });

  ///请求课程目录信息
  var getDicData = DioUtil.getInstance().doPost<ClassDictionaryEntity>(
      url: API.class_dictionary + '/${ctx.state.oid}',
      context: ctx.context,
      onSuccess: (data) {
        ctx.state.classDictionaryEntity = data;
        ctx.state.currentUrl = data.data[0].videoUrl;
        ctx.forceUpdate();
        ctx.broadcast(
            ClassDetailActionCreator.updateUrl(data.data[0].videoUrl));
      },
      onFailure: (e) {
        ToastUtil.show(e.msg);
      });

  await Future.wait([getDetailData, getDicData]);
  ctx.forceUpdate();
}

void _collect(Action action, Context<IntroductionState> ctx) {
  print('进入effect');
  bool shouldCollect =
      ctx.state.classDetailEntity.data.collectionStatus == 'NO';
  var data = ctx.state.classDetailEntity.data;
  if (shouldCollect) {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.collection_class,
        context: ctx.context,
        param: {
          'curriculumOid': ctx.state.oid,
          'curriculumTitle': data.title,
          'curriculumPrice': data.price,
          'curriculumDiscountPrice': data.discountPrice,
          'curriculumCommercialOid': data.commercialOid,
          'curriculumCommercialName': data.commercialName,
          'curriculumAddress':
              '${data.provinceName}${data.cityName}${data.districtName}'
        },
        onSuccess: (data) {
          ctx.state.classDetailEntity.data.collectionStatus = 'YES';
          ctx.state.classDetailEntity.data.collectionNumber++;
          ctx.forceUpdate();
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  } else {
    DioUtil.getInstance().doPost<CollectionEntity>(
        url: API.cancel_collection_class + '/${ctx.state.oid}',
        context: ctx.context,
        onSuccess: (data) {
          ctx.state.classDetailEntity.data.collectionStatus = 'NO';
          ctx.state.classDetailEntity.data.collectionNumber--;
          ctx.forceUpdate();
        },
        onFailure: (e) {
          ToastUtil.show(e.msg);
        });
  }
}

void _changeUrl(Action action, Context<IntroductionState> ctx) {
  String currentUrl = action.payload;
  ctx.state.currentUrl = currentUrl;
  ctx.forceUpdate();
  ctx.broadcast(ClassDetailActionCreator.updateUrl(currentUrl));
}
