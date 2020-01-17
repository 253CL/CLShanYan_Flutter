/*
* 闪验SDK 授权页UI 配置类
* */

import 'package:json_annotation/json_annotation.dart';
part 'shanYanUIConfig.g.dart';

/// 修改UI属性后，需删除shanyan.g.dart,再执行`flutter packages pub run build_runner build`，会生成新的 shanyan.g.dart; 运行 ` flutter packages pub run build_runner clean ` 清空文件

@JsonSerializable(explicitToJson: true)
class ShanYanUIConfig {

  ShanYanUIConfig({this.ios,this.android_portrait,this.android_landscape});

  final ShanYanUIConfigIOS ios = new ShanYanUIConfigIOS(); //iOS

  final ShanYanUIConfigAndroid android_portrait = new ShanYanUIConfigAndroid(); //Android竖屏
  final ShanYanUIConfigAndroid android_landscape = new ShanYanUIConfigAndroid(); //Android横屏

  //反序列化
  factory ShanYanUIConfig.fromJson(Map<String, dynamic> json) => _$ShanYanUIConfigFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$ShanYanUIConfigToJson(this);
}

//  //授权页 导航栏
//  String setNavColor; //设置导航栏背景颜色
//  String setNavText; //设置导航栏标题文字
//  String setNavTextColor; //设置导航栏标题文字颜色
//  int setNavTextSize; //设置导航栏标题文字大小
//  String setNavReturnImgPath; //设置导航栏返回按钮图标
//  bool setNavReturnImgHidden = false; //设置导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）

//  bool setAuthNavHidden; //设置导航栏是否隐藏（true：隐藏；false：不隐藏）
//  bool setAuthNavTransparent; //设置导航栏是否透明（true：透明；false：不透明）
//  bool setNavTextBold; //设置导航栏字体是否加粗（true：加粗；false：不加粗）
//


//  // 授权页 号码栏
//  String setNumberColor; //设置号码栏字体颜色

//  bool setNumberBold; //设置号码栏字体是否加粗（true：加粗；false：不加粗）
//
//  //授权页 登录按钮
//  String setLogBtnText; //设置登录按钮文字
//  String setLogBtnTextColor; //设置登录按钮文字颜色
//  String setLogBtnImgPath; //设置授权登录按钮图片
//  bool setLogBtnTextBold; //设置登录按钮字体是否加粗（true：加粗；false：不加粗）
//
//  //授权页 隐私协议栏
//  List<String> setAppPrivacyOne; //设置开发者隐私条款1，包含两个参数：1.名称 2.URL
//  List<String> setAppPrivacyTwo; //设置开发者隐私条款2，包含两个参数：1.名称 2.URL
//  List<String> setAppPrivacyThree; //设置开发者隐私条款3，包含两个参数：1.名称 2.URL
//  bool setPrivacySmhHidden; //设置协议名称是否显示书名号《》，默认显示书名号（true：不显示；false：显示）
//  int setPrivacyTextSize; //设置隐私栏字体大小
//  List<String> setAppPrivacyColor; //设置隐私条款文字颜色，包含两个参数：1.基础文字颜色 2.协议文字颜色

//  bool setPrivacyOffsetGravityLeft; //设置隐私条款文字左对齐（true：左对齐；false：居中）
//  bool setPrivacyState; //设置隐私条款的CheckBox是否选中（true：选中；false：未选中）
//  String setUncheckedImgPath; //设置隐私条款的CheckBox未选中时图片
//  String setCheckedImgPath; //设置隐私条款的CheckBox选中时图片
//  bool setCheckBoxHidden; //设置隐私条款的CheckBox是否隐藏（true：隐藏；false：不隐藏）
//  List<int> setCheckBoxWH; //设置checkbox的宽高，包含两个参数：1.宽 2.高
//  List<int> setCheckBoxMargin; //设置checkbox的间距，包含四个参数：1.左间距 2.上间距 3.右间距 4.下间距
//  List<String> setPrivacyText; //设置隐私条款名称外的文字,包含五个参数
//  bool setPrivacyTextBold; //设置协议栏字体是否加粗（true：加粗；false：不加粗）
//
//  //授权页 slogan（***提供认证服务）
//  String setSloganTextColor; //设置slogan文字颜色
//  int setSloganTextSize; //设置slogan文字字体大小
//  bool setSloganHidden = false; //设置slogan是否隐藏（true：隐藏；false：不隐藏）
//  bool setSloganTextBold; //设置slogan文字字体是否加粗（true：加粗；false：不加粗）
//
//  //创蓝slogan设置
//  int setShanYanSloganTextColor; //设置创蓝slogan文字颜色
//  int setShanYanSloganTextSize; //设置创蓝slogan文字字体大小

//  bool setShanYanSloganHidden; //设置创蓝slogan是否隐藏（true：隐藏；false：不隐藏）
//  bool setShanYanSloganTextBold; //设置创蓝slogan文字字体是否加粗（true：加粗；false：不加粗）
//
//  //协议页导航栏
//  int setPrivacyNavColor; //设置协议页导航栏背景颜色
//  bool setPrivacyNavTextBold; //设置协议页导航栏标题文字是否加粗（true：加粗；false：不加粗）
//  int setPrivacyNavTextColor; //设置协议页导航栏标题文字颜色
//  int setPrivacyNavTextSize; //设置协议页导航栏标题文字大小
//  String setPrivacyNavReturnImgPath; //设置协议页导航栏返回按钮图标
//  bool setPrivacyNavReturnImgHidden; //设置协议页导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）
//  int setPrivacyNavReturnBtnWidth; //设置协议页导航栏返回按钮宽度
//  int setPrivacyNavReturnBtnHeight; //设置协议页导航栏返回按钮高度
//  int setPrivacyNavReturnBtnOffsetRightX; //设置协议页导航栏返回按钮距离屏幕右侧X偏移
//  int setPrivacyNavReturnBtnOffsetX; //设置协议页导航栏返回按钮距离屏幕左侧X偏移
//  int setPrivacyNavReturnBtnOffsetY; //设置协议页导航栏返回按钮距离屏幕上侧Y偏移
//
//  String addCustomPrivacyAlertView; //添加授权页上显示隐私协议弹框
//  String setLoadingView; //设置授权页点击一键登录自定义loading
//  List<String>
//      setDialogTheme; //设置授权页为弹窗样式，包含5个参数：1.弹窗宽度 2.弹窗高度 3.弹窗X偏移量（以屏幕中心为原点） 4.弹窗Y偏移量（以屏幕中心为原点） 5.授权页弹窗是否贴于屏幕底部
//  List<ShanYanCustomWidgetLayout> widgetLayout; //添加自定义布局layout
//  List<ShanYanCustomWidget> widgets; //添加自定义控件 暂时只支持textview
//
//  Map toJsonMap() {
//    return {
//      "isFinish": isFinish,
//      "setAuthBGImgPath": setAuthBGImgPath ??= null,
//      "setAuthBgGifPath": setAuthBgGifPath ??= null,
//      "setAuthBgVideoPath": setAuthBgVideoPath ??= null,
//      "setStatusBarColor": setStatusBarColor ??= null,
//      "setLightColor": setLightColor,
//      "setStatusBarHidden": setStatusBarHidden,
//      "setVirtualKeyTransparent": setVirtualKeyTransparent,
//      "setFullScreen": setFullScreen,
//      "setNavColor": setNavColor ??= null,
//      "setNavText": setNavText ??= null,
//      "setNavTextColor": setNavTextColor ??= null,
//      "setNavTextSize": setNavTextSize ??= null,
//      "setNavReturnImgPath": setNavReturnImgPath ??= null,
//      "setNavReturnImgHidden": setNavReturnImgHidden,
//      "setNavReturnBtnWidth": setNavReturnBtnWidth ??= null,
//      "setNavReturnBtnHeight": setNavReturnBtnHeight ??= null,
//      "setNavReturnBtnOffsetRightX": setNavReturnBtnOffsetRightX ??= null,
//      "setNavReturnBtnOffsetX": setNavReturnBtnOffsetX ??= null,
//      "setNavReturnBtnOffsetY": setNavReturnBtnOffsetY ??= null,
//      "setAuthNavHidden": setAuthNavHidden,
//      "setAuthNavTransparent": setAuthNavTransparent,
//      "setNavTextBold": setNavTextBold,
//      "setLogoImgPath": setLogoImgPath ??= null,
//      "setLogoWidth": setLogoWidth ??= null,
//      "setLogoHeight": setLogoHeight ??= null,
//      "setLogoOffsetY": setLogoOffsetY ??= null,
//      "setLogoOffsetBottomY": setLogoOffsetBottomY ??= null,
//      "setLogoHidden": setLogoHidden,
//      "setLogoOffsetX": setLogoOffsetX ??= null,
//      "setNumberColor": setNumberColor ??= null,
//      "setNumFieldOffsetY": setNumFieldOffsetY ??= null,
//      "setNumFieldOffsetBottomY": setNumFieldOffsetBottomY ??= null,
//      "setNumFieldWidth": setNumFieldWidth ??= null,
//      "setNumFieldHeight": setNumFieldHeight ??= null,
//      "setNumberSize": setNumberSize ??= null,
//      "setNumFieldOffsetX": setNumFieldOffsetX ??= null,
//      "setNumberBold": setNumberBold,
//      "setLogBtnText": setLogBtnText ??= null,
//      "setLogBtnTextColor": setLogBtnTextColor ??= null,
//      "setLogBtnImgPath": setLogBtnImgPath ??= null,
//      "setLogBtnOffsetY": setLogBtnOffsetY ??= null,
//      "setLogBtnOffsetBottomY": setLogBtnOffsetBottomY ??= null,
//      "setLogBtnTextSize": setLogBtnTextSize ??= null,
//      "setLogBtnHeight": setLogBtnHeight ??= null,
//      "setLogBtnWidth": setLogBtnWidth ??= null,
//      "setLogBtnOffsetX": setLogBtnOffsetX ??= null,
//      "setLogBtnTextBold": setLogBtnTextBold,
//      "setAppPrivacyOne": setAppPrivacyOne ??= null,
//      "setAppPrivacyTwo": setAppPrivacyTwo ??= null,
//      "setAppPrivacyThree": setAppPrivacyThree ??= null,
//      "setPrivacySmhHidden": setPrivacySmhHidden ??= null,
//      "setPrivacyTextSize": setPrivacyTextSize ??= null,
//      "setAppPrivacyColor": setAppPrivacyColor ??= null,
//      "setPrivacyOffsetBottomY": setPrivacyOffsetBottomY ??= null,
//      "setPrivacyOffsetY": setPrivacyOffsetY ??= null,
//      "setPrivacyOffsetX": setPrivacyOffsetX ??= null,
//      "setPrivacyOffsetGravityLeft": setPrivacyOffsetGravityLeft,
//      "setPrivacyState": setPrivacyState,
//      "setUncheckedImgPath": setUncheckedImgPath ??= null,
//      "setCheckedImgPath": setCheckedImgPath ??= null,
//      "setCheckBoxHidden": setCheckBoxHidden,
//      "setCheckBoxWH": setCheckBoxWH ??= null,
//      "setCheckBoxMargin": setCheckBoxMargin ??= null,
//      "setPrivacyText": setPrivacyText ??= null,
//      "setPrivacyTextBold": setPrivacyTextBold,
//      "setSloganTextColor": setSloganTextColor ??= null,
//      "setSloganTextSize": setSloganTextSize ??= null,
//      "setSloganOffsetY": setSloganOffsetY ??= null,
//      "setSloganHidden": setSloganHidden,
//      "setSloganOffsetBottomY": setSloganOffsetBottomY ??= null,
//      "setSloganOffsetX": setSloganOffsetX ??= null,
//      "setSloganTextBold": setSloganTextBold,
//      "setShanYanSloganTextColor": setShanYanSloganTextColor ??= null,
//      "setShanYanSloganTextSize": setShanYanSloganTextSize ??= null,
//      "setShanYanSloganOffsetY": setShanYanSloganOffsetY ??= null,
//      "setShanYanSloganHidden": setShanYanSloganHidden,
//      "setShanYanSloganOffsetBottomY": setShanYanSloganOffsetBottomY ??= null,
//      "setShanYanSloganOffsetX": setShanYanSloganOffsetX ??= null,
//      "setShanYanSloganTextBold": setShanYanSloganTextBold,
//      "setPrivacyNavColor": setPrivacyNavColor ??= null,
//      "setPrivacyNavTextBold": setPrivacyNavTextBold,
//      "setPrivacyNavTextColor": setPrivacyNavTextColor ??= null,
//      "setPrivacyNavTextSize": setPrivacyNavTextSize ??= null,
//      "setPrivacyNavReturnImgPath": setPrivacyNavReturnImgPath ??= null,
//      "setPrivacyNavReturnImgHidden": setPrivacyNavReturnImgHidden,
//      "setPrivacyNavReturnBtnWidth": setPrivacyNavReturnBtnWidth ??= null,
//      "setPrivacyNavReturnBtnHeight": setPrivacyNavReturnBtnHeight ??= null,
//      "setPrivacyNavReturnBtnOffsetRightX":
//          setPrivacyNavReturnBtnOffsetRightX ??= null,
//      "setPrivacyNavReturnBtnOffsetX": setPrivacyNavReturnBtnOffsetX ??= null,
//      "setPrivacyNavReturnBtnOffsetY": setPrivacyNavReturnBtnOffsetY ??= null,
//      "addCustomPrivacyAlertView": addCustomPrivacyAlertView ??= null,
//      "setLoadingView": setLoadingView ??= null,
//      "setDialogTheme": setDialogTheme ??= null,
//      /*"widgets": widgets ??= null,
//      "widgetLayout": widgetLayout ??= null,*/
//    }..removeWhere((key, value) => value == null);
//  }
//}


///*iOS独有*/
@JsonSerializable(explicitToJson: true)
class ShanYanUIConfigIOS {

  ShanYanUIConfigIOS();

  bool isFinish; //是否自动销毁

  String setAuthBGImgPath; //授权页背景 普通图片

  bool setStatusBarHidden; //授权页状态栏 设置状态栏是否隐藏
  bool navigationBackgroundClear;//导航栏透明
  String navigationBackBtnImage;//返回按钮图片

  String setLogoImgPath;//logo图片

  String loginBtnText; //一键登录按钮文字
  String loginBtnTextColor;
  String loginBtnBgColor;
  double loginBtnTextFont;
  double loginBtnCornerRadius;//一键登录按钮圆角
  double loginBtnBorderWidth;//一键登录按描边粗细
  String loginBtnBorderColor;//一键登录按描边颜色

  double phoneNumberFont;//手机号字体大小

  //布局设置
  final ClOrientationLayOutIOS layOut_portrait = new ClOrientationLayOutIOS();//横屏下使用的布局
  final ClOrientationLayOutIOS layOut_landscape = new ClOrientationLayOutIOS();//竖屏下使用的布局(不需要则不设置)

//反序列化
  factory ShanYanUIConfigIOS.fromJson(Map<String, dynamic> json) => _$ShanYanUIConfigIOSFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$ShanYanUIConfigIOSToJson(this);
}

/*iOS布局(横竖需屏分别设置)*/
@JsonSerializable()
class ClOrientationLayOutIOS{

  ClOrientationLayOutIOS();

  //logo
  int setLogoWidth;
  int setLogoHeight;
  int setLogoLeft;
  int setLogoRight;
  int setLogoTop;
  int setLogoBottom;
  int setLogoCenterX;
  int setLogoCenterY;

  //脱敏手机号
  int setNumFieldWidth;
  int setNumFieldHeight;
  int setNumFieldLeft;
  int setNumFieldRight;
  int setNumFieldTop;
  int setNumFieldBottom;
  int setNumFieldCenterX;
  int setNumFieldCenterY;

  //一键登录按钮
  int setLogBtnHeight;
  int setLogBtnWidth;
  int setLogBtnLeft;
  int setLogBtnRight;
  int setLogBtnTop;
  int setLogBtnBottom;
  int setLogBtnCenterX;
  int setLogBtnCenterY;

  //隐私协议
  int setPrivacyHeight;
  int setPrivacyWidth;
  int setPrivacyLeft;
  int setPrivacyRight;
  int setPrivacyTop;
  int setPrivacyBottom;
  int setPrivacyCenterX;
  int setPrivacyCenterY;

  //授权页 slogan（***提供认证服务）
  int setSloganHeight;
  int setSloganWidth;
  int setSloganLeft;
  int setSloganRight;
  int setSloganTop;
  int setSloganBottom;
  int setSloganCenterX;
  int setSloganCenterY;

  //授权页 创蓝slogan（创蓝253提供认证服务）
  int setShanYanSloganHeight;
  int setShanYanSloganWidth;
  int setShanYanSloganLeft;
  int setShanYanSloganRight;
  int setShanYanSloganTop;
  int setShanYanSloganBottom;
  int setShanYanSloganCenterX;
  int setShanYanSloganCenterY;

  //反序列化
  factory ClOrientationLayOutIOS.fromJson(Map<String, dynamic> json) => _$ClOrientationLayOutIOSFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$ClOrientationLayOutIOSToJson(this);
}


/*Android独有布局*/
@JsonSerializable()
class ShanYanUIConfigAndroid {

  ShanYanUIConfigAndroid({this.isFinish});

  bool isFinish; //是否自动销毁

  String setAuthBGImgPath; //授权页背景 普通图片

  bool setStatusBarHidden; //授权页状态栏 设置状态栏是否隐藏

  String setAuthBgGifPath; //GIF图片（只支持本地gif图，需要放置到drawable文件夹中）
  String setAuthBgVideoPath; //视频背景

  //授权页 状态栏
  String setStatusBarColor; //设置状态栏背景颜色
  bool setLightColor; //设置状态栏字体颜色是否为白色
  bool setVirtualKeyTransparent; //设置虚拟键是否透明

  //授权页 导航栏
  bool setFullScreen; //-*Android only*- 设置是否全屏显示（true：全屏；false：不全屏）默认不全屏
  int setNavReturnBtnWidth; //-*Android only*-设置导航栏返回按钮宽度
  int setNavReturnBtnHeight; //-*Android only*-设置导航栏返回按钮高度
  int setNavReturnBtnOffsetRightX; //设置导航栏返回按钮距离屏幕右侧X偏移
  int setNavReturnBtnOffsetX; //设置导航栏返回按钮距离屏幕左侧X偏移
  int setNavReturnBtnOffsetY; //设置导航栏返回按钮距离屏幕上侧Y偏移

  //logo
  String setLogoImgPath; //设置logo图片
  bool setLogoHidden; //设置logo是否隐藏（true：隐藏；false：不隐藏）
  int setLogoOffsetY; //设置logo相对于标题栏下边缘y偏移
  int setLogoOffsetBottomY; //设置logo相对于屏幕底部y偏移
  int setLogoOffsetX; //设置logo相对屏幕左侧X偏移
  int setLogoWidth;
  int setLogoHeight;

  //脱敏手机号
  int setNumFieldOffsetY; //设置号码栏相对于标题栏下边缘y偏移
  int setNumFieldOffsetBottomY; //设置号码栏相对于屏幕底部y偏移
  int setNumberSize; //设置号码栏字体大小
  int setNumFieldOffsetX; //设置号码栏相对屏幕左侧X偏移
  int setNumFieldWidth;
  int setNumFieldHeight;

  //一键登录按钮
  int setLogBtnOffsetY; //设置登录按钮相对于标题栏下边缘Y偏移
  int setLogBtnOffsetBottomY; //设置登录按钮相对于屏幕底部Y偏移
  int setLogBtnTextSize; //设置登录按钮字体大小
  int setLogBtnOffsetX; //设置登录按钮相对屏幕左侧X偏移
  int setLogBtnHeight;
  int setLogBtnWidth;

  //Privacy
  int setPrivacyOffsetBottomY; //设置隐私条款相对于授权页面底部下边缘y偏移
  int setPrivacyOffsetY; //设置隐私条款相对于授权页面标题栏下边缘y偏移
  int setPrivacyOffsetX; //设置隐私条款相对屏幕左侧X偏移

  //授权页 slogan（***提供认证服务）
  int setSloganOffsetY; //设置slogan相对于标题栏下边缘y偏移
  int setSloganOffsetBottomY; //设置slogan相对屏幕底部Y偏移
  int setSloganOffsetX; //设置slogan相对屏幕左侧X偏移

  //创蓝slogan设置
  int setShanYanSloganOffsetY; //设置创蓝slogan相对于标题栏下边缘y偏移
  int setShanYanSloganOffsetBottomY; //设置创蓝slogan相对屏幕底部Y偏移
  int setShanYanSloganOffsetX; //设置创蓝slogan相对屏幕左侧X偏移

  //反序列化
  factory ShanYanUIConfigAndroid.fromJson(Map<String, dynamic> json) => _$ShanYanUIConfigAndroidFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$ShanYanUIConfigAndroidToJson(this);
}


////添加自定义布局类型，目前支持RelativeLayout布局xml文件
//enum ShanYanCustomWidgetLayoutType { RelativeLayout }
//
//// 自定义控件
//class ShanYanCustomWidgetLayout {
//  String widgetLayoutName;
//  List<String> widgetLayoutId; //自定义控件ID
//  int left = 0; // 自定义控件距离屏幕左边缘偏移量，单位dp
//  int top = 0; // 自定义控件距离导航栏底部偏移量，单位dp
//  int right = 0; // 自定义控件距离屏幕右边缘偏移量，单位dp
//  int bottom = 0; // 自定义控件距离屏幕底部偏移量，单位dp
//  int width = 0; // 自定义控件宽度，单位dp
//  int height = 0; // 自定义控件高度，单位dp
//  ShanYanCustomWidgetLayoutType type; //自定义控件类型，目前只支持 textView,button
//  ShanYanCustomWidgetLayout(
//      @required this.widgetLayoutName, @required this.type) {
//    this.widgetLayoutName = widgetLayoutName;
//    this.type = type;
//  }
//
//  Map toJsonMap() {
//    return {
//      "widgetLayoutName": widgetLayoutName,
//      "widgetLayoutId": widgetLayoutId,
//      "type": getStringFromEnum(type),
//      "left": left,
//      "top": top,
//      "right": right,
//      "bottom": bottom,
//      "width": width,
//      "height": height,
//    }..removeWhere((key, value) => value == null);
//  }
//}
//
////添加自定义控件类型，目前只支持 TextView
//enum ShanYanCustomWidgetType { TextView }
//
//// 文本对齐方式
//enum ShanYanCustomWidgetGravityType { left, right, center }
//
//// 自定义控件
//class ShanYanCustomWidget {
//  String widgetId; //自定义控件ID
//  int left = 0; // 自定义控件距离屏幕左边缘偏移量，单位dp
//  int top = 0; // 自定义控件距离导航栏底部偏移量，单位dp
//  int right = 0; // 自定义控件距离屏幕右边缘偏移量，单位dp
//  int bottom = 0; // 自定义控件距离屏幕底部偏移量，单位dp
//  int width = 0; // 自定义控件宽度，单位dp
//  int height = 0; // 自定义控件高度，单位dp
//  String textContent = ""; // 自定义控件内容
//  double textFont = 13.0; // 自定义控件文字大小，单位sp
//  String textColor = "#aa0000"; // 自定义控件文字颜色
//  String backgroundColor; // 自定义控件背景颜色
//  String backgroundImgPath; // 自定义控件背景图片
//  ShanYanCustomWidgetGravityType textAlignment; //自定义控件内容对齐方式
//  ShanYanCustomWidgetType type; //自定义控件类型，目前只支持 textView,button
//  bool isFinish = true; //点击自定义控件是否自动销毁授权页
//
//  ShanYanCustomWidget(@required this.widgetId, @required this.type) {
//    this.widgetId = widgetId;
//    this.type = type;
//  }
//
//  Map toJsonMap() {
//    return {
//      "widgetId": widgetId,
//      "type": getStringFromEnum(type),
//      "textContent": textContent,
//      "textFont": textFont ??= null,
//      "backgroundImgPath": backgroundImgPath ??= null,
//      "textAlignment": getStringFromEnum(textAlignment),
//      "textColor": textColor ??= null,
//      "backgroundColor": backgroundColor ??= null,
//      "isFinish": isFinish,
//      "left": left,
//      "top": top,
//      "right": right,
//      "bottom": bottom,
//      "width": width,
//      "height": height,
//    }..removeWhere((key, value) => value == null);
//  }
//}