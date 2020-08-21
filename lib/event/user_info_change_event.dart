///
/// @created by 文景睿
/// description:这是当用户登陆过后，或者修改数据过后,发送的刷新页面的事件
///
class UserInfoChangeEvent {
  ///一般来说这个变量只有需要用户知道现在是登陆没有登陆的时候才需要
  bool isLogin;

  UserInfoChangeEvent({this.isLogin = true});
}
