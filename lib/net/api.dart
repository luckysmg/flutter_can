class API {
  API._();

  static const BASE_URL = "http://39.105.145.189";

  static const String _imageUrl = "/asf/general/storage/download";

  ///上传文件
  static const uploadFile = '/asf/general/storage/upload';

  ///图片的前缀
  static const String imageUrlHeader = BASE_URL + _imageUrl;

  ///普通的Content-Type类型
  static const NORMAL_CONTENT_TYPE = "application/json";

  ///发现页：查询tab的标签集合
  static const String discover_category = '/sailclient/galaxy/search';

  ///发现页：根据oid查询列表
  static const String discover_list = '/sailclient/discover/searchByCategory';

  ///密码登陆
  static const password_login = '/asf/usercenter/user/signin/pass';

  ///读取用户信息
  static const user_profile = '/asf/usercenter/user/profile/read';

  ///保存昵称
  static const save_nickname = '/asf/usercenter/user/profile/save/nickname';

  ///修改密码
  static const password_modify = '/asf/usercenter/user/pass/modify';

  ///发送注册验证码
  static const register_code = '/asf/usercenter/user/regist/sendsms';

  ///注册
  static const register = '/asf/usercenter/user/regist';

  ///短信登陆验证码
  static const sms_login_code = '/asf/usercenter/user/signin/sendsms';

  ///短信登陆
  static const sms_login = '/asf/usercenter/user/signin/sms';

  ///重置密码验证码
  static const reset_password_code =
      '/asf/usercenter/user/pass/retrieve/sendsms';

  ///重置密码
  static const reset_password = '/asf/usercenter/user/pass/retrieve';

  ///保存头像
  static const save_head = '/asf/usercenter/user/profile/save/headimageurl';

  ///查询发现详情
  static const discover_item_detail = '/sailclient/discover/read';

  ///评论查询
  static const comment_search = '/sailclient/comment/search';

  ///添加评论
  static const add_comment = '/sailclient/comment/save';

  ///收藏发现条目
  static const discover_collection = '/sailclient/favorite/discover/collection';

  ///取消收藏发现条目
  static const discover_cancel_collection =
      '/sailclient/favorite/discover/uncollection';

  ///点赞发现条目
  static const discover_like = '/sailclient/praise/discover/like';

  ///取消点赞发现条目
  static const discover_cancel_like = '/sailclient/praise/discover/unlike';

  ///保存性别
  static const change_gender = '/asf/usercenter/user/profile/save/gender';

  ///收藏的发现列表
  static const collection_discover = '/sailclient/favorite/discover/search';

  ///查询收藏的精品课列表
  static const collection_class_list = '/sailclient/favorite/curriculum/search';

  ///查询首页的课
  static const home_class = '/sailclient/curriculum/home/search';

  ///首页banner
  static const home_banner = '/sailclient/banner/search';

  ///查询所有证书列表
  static const search_all_certificate = '/sailclient/certification/load';

  ///考证详情
  static const certification_detail = '/sailclient/examination/read';

  static const certification_collection =
      '/sailclient/favorite/certification/collection';

  ///取消收藏证书
  static const certification_cancel_collection =
      '/sailclient/favorite/certification/uncollection';

  ///精品课详情
  static const class_detail = '/sailclient/curriculum/read';

  ///精品课目录
  static const class_dictionary = '/sailclient/curriculum/menu/load';

  ///收藏精品课
  static const collection_class = '/sailclient/favorite/curriculum/collection';

  ///取消收藏精品课
  static const cancel_collection_class =
      '/sailclient/favorite/curriculum/uncollection';

  ///根据名称查询职业列表
  static const search_profession_by_name =
      '/sailclient/profession/searchByName';

  ///保存职业信息
  static const save_profession = '/asf/usercenter/user/profile/save/profession';

  ///查询职业列表
  static const profession_list = '/sailclient/profession/load';

  ///查询精品课分类
  static const curriculum_category = '/sailclient/curriculum/category/load';

  ///查询首屏的精品课列表
  static const home_class_list = '/sailclient/curriculum/searchForPlan';

  ///首页职业屏查询推荐职位
  static const search_recommend_profession =
      '/sailclient/profession/searchAdvanced';

  ///首页书籍列表
  static const search_book = '/sailclient/book/searchForPlan';

  ///首页查询推荐证书
  static const search_certification = '/sailclient/certification/searchForPlan';

  ///职业百科的精品课列表
  static const wiki_curriculum = '/sailclient/curriculum/wiki/searchForPlan';

  ///职业百科查询推荐职业
  static const wiki_recommend_profession =
      '/sailclient/profession/wiki/searchAdvanced';

  ///职业百科推荐证书
  static const wiki_recommend_certification =
      '/sailclient/certification/wiki/searchForPlan';

  ///职业百科查询书籍
  static const wiki_recommend_book = '/sailclient/book/wiki/searchForPlan';

  ///根据oid查询精品课分类列表
  static const good_class_category_list =
      '/sailclient/curriculum/searchByCategory';

  ///书籍详情
  static const book_detail = '/sailclient/book/read';

  ///收藏书籍
  static const collect_book = '/sailclient/favorite/book/collection';

  ///取消收藏书籍
  static const cancel_collect_book = '/sailclient/favorite/book/uncollection';

  ///保存定居星系信息
  static const save_galaxy = '/asf/usercenter/user/profile/save/galaxy';

  ///查询知识行星列表
  static const knowledge_list = '/sailclient/community/searchByUser';

  ///查询星球动态的列表
  static const essay_list = '/sailclient/essay/search';

  ///添加动态
  static const essay_add = '/sailclient/essay/add';

  ///添加知识行星
  static const galaxy_add = '/sailclient/community/add';

  ///搜索知识行星
  static const search_planet = '/sailclient/community/search';

  ///加入知识行星
  static const join_planet = '/sailclient/community/join';

  ///查看行星详情
  static const planet_detail = '/sailclient/community/read';

  ///删除知识行星动态
  static const delete_essay = '/sailclient/essay/delete';

  ///根据星系oid查询行星
  static const check_planet_with_galaxy_oid =
      '/sailclient/community/search/galaxy';

  ///修改知识行星公告
  static const change_planet_notice = '/sailclient/community/update/notice';

  ///修改知识行星介绍
  static const change_planet_introduction =
      '/sailclient/community/update/remark';

  ///修改知识行星标题
  static const change_planet_title = '/sailclient/community/update/title';

  ///修改行星图片
  static const change_planet_img = '/sailclient/community/update/image';

  ///根据level查询课程列表
  static const search_class_with_level = '/sailclient/curriculum/search/level';

  ///查看动态详情
  static const essay_detail = '/sailclient/essay/read';

  ///点赞动态
  static const essay_like = '/sailclient/praise/essay/like';

  ///取消点赞动态
  static const essay_unlike = '/sailclient/praise/essay/unlike';

  ///收藏动态
  static const essay_collect = '/sailclient/favorite/essay/collection';

  ///取消收藏动态
  static const essay_cancel_collect = '/sailclient/favorite/essay/uncollection';

  ///查询android最新版本
  static const get_android_version = '/asf/general/application/version/BOOM/ANDROID/RELEASE/last';

  ///查询ios最新版本
  static const get_ios_version = '/asf/general/application/version/BOOM/IOS/RELEASE/last';
}
