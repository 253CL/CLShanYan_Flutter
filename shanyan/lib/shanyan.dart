import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 监听添加的自定义控件的点击事件
typedef ShanYanWidgetEventListener = void Function(String widgetId);

/// 监听添加的自定义布局的点击事件
typedef ShanYanWidgetLayoutEventListener = void Function(
    WidgetLayoutOnClickEvent event);

/// 闪验SDK 授权页默认控件点击事件回调
typedef AuthPageOnClickListener = void Function(AuthPageOnClickEvent event);

class OneKeyLoginManager {
  final String flutter_log = "|shanyan_flutter======|";

  factory OneKeyLoginManager() => _instance;
  final ShanYanEventHandlers _eventHanders = new ShanYanEventHandlers();

  final MethodChannel _channel;

  /// 授权页默认控件的点击事件（“一键登录按钮”、返回按钮（包括物理返回键）、协议条款）
  setAuthPageOnClickListener(AuthPageOnClickListener callback) {
    _eventHanders.authPageEvents.add(callback);
  }

  /// 自定义控件的点击事件
  addClikWidgetEventListener(
      String eventId, ShanYanWidgetEventListener callback) {
    _eventHanders.clickEventsMap[eventId] = callback;
  }

  // 自定布局的点击事件
  addClikWidgetLayoutEventListener(ShanYanWidgetLayoutEventListener callback) {
    _eventHanders.clickLayoutEvents.add(callback);
  }

  @visibleForTesting
  OneKeyLoginManager.private(MethodChannel channel) : _channel = channel;
  static final _instance =
  new OneKeyLoginManager.private(const MethodChannel("shanyan"));

  /// 设置调试模式开关
  void setDebug(bool debug) {
    _channel.invokeMethod("setDebugMode", {"debug": debug});
  }

  //闪验SDK 初始化
  Future<Map<dynamic, dynamic>> init({String appId}) async {
    _channel.setMethodCallHandler(_handlerMethod);
    return await _channel.invokeMethod("init", {"appId": appId});
  }

  //闪验SDK 预取号
  Future<Map<dynamic, dynamic>> getPhoneInfo({String appId}) async {
    return await _channel.invokeMethod("getPhoneInfo");
  }

  //闪验SDK 拉起授权页
  Future<Map<dynamic, dynamic>> openLoginAuth({bool isFinish}) async {
    return await _channel.invokeMethod("openLoginAuth", {"isFinish": isFinish});
  }

  //闪验SDK 主动销毁授权页
  void finishAuthActivity() {
    _channel.invokeMethod("finishAuthActivity");
  }

  //闪验SDK 设置点击协议监听
  void setOnClickPrivacyListener() {
    _channel.invokeMethod("setOnClickPrivacyListener");
  }

  //闪验SDK 本机号校验获取token
  Future<Map<dynamic, dynamic>> startAuthentication({String phoneNum}) async {
    return await _channel
        .invokeMethod("startAuthentication", {"phoneNum": phoneNum});
  }

  //闪验SDK 配置授权页
  void setAuthThemeConfig(
      {ShanYanUIConfig uiConfig,
        List<ShanYanCustomWidget> widgets,
        List<ShanYanCustomWidgetLayout> widgetLayout}) {
    var para = Map();
    var para1 = uiConfig.toJsonMap();
    para1.removeWhere((key, value) => value == null);
    para["uiConfig"] = para1;
    if (null != widgets) {
      var widgetList = List();
      for (ShanYanCustomWidget widget in widgets) {
        var para2 = widget.toJsonMap();
        para2.removeWhere((key, value) => value == null);
        widgetList.add(para2);
      }
      para["widgets"] = widgetList;
    }
    if (null != widgetLayout) {
      var widgetLayoutList = List();
      for (ShanYanCustomWidgetLayout widget in widgetLayout) {
        var para3 = widget.toJsonMap();
        para3.removeWhere((key, value) => value == null);
        widgetLayoutList.add(para3);
      }
      para["widgetLayout"] = widgetLayoutList;
    }
    _channel.invokeMethod("setAuthThemeConfig", para);
  }

  Future<void> _handlerMethod(MethodCall call) async {
    switch (call.method) {
      case 'onReceiveAuthPageEvent':
        {
          for (AuthPageOnClickListener cb in _eventHanders.authPageEvents) {
            Map json = call.arguments.cast<dynamic, dynamic>();
            AuthPageOnClickEvent ev = AuthPageOnClickEvent.fromJson(json);
            cb(ev);
          }
        }
        break;
      case 'onReceiveClickWidgetEvent':
        {
          String widgetId = call.arguments.cast<dynamic, dynamic>()['widgetId'];
          bool isContains = _eventHanders.clickEventsMap.containsKey(widgetId);
          if (isContains) {
            ShanYanWidgetEventListener cb =
            _eventHanders.clickEventsMap[widgetId];
            cb(widgetId);
          }
        }
        break;
      case 'onReceiveClickWidgetLayoutEvent':
        {
          for (ShanYanWidgetLayoutEventListener cb
          in _eventHanders.clickLayoutEvents) {
            Map json = call.arguments.cast<dynamic, dynamic>();
            WidgetLayoutOnClickEvent ev =
            WidgetLayoutOnClickEvent.fromJson(json);
            cb(ev);
          }
        }
        break;
      default:
        throw new UnsupportedError("Unrecognized Event");
    }
    return;
  }
}

/// 闪验SDK 授权页默认控件点击事件
class AuthPageOnClickEvent {
  final int code; //返回码
  final String message; //事件描述

  AuthPageOnClickEvent.fromJson(Map<dynamic, dynamic> json)
      : code = json['code'],
        message = json['result'];

  Map toMap() {
    return {'code': code, 'result': message};
  }
}

/// 闪验SDK 自定义布局点击事件
class WidgetLayoutOnClickEvent {
  final String widgetLayoutId; //点击的控件id
  WidgetLayoutOnClickEvent.fromJson(Map<dynamic, dynamic> json)
      : widgetLayoutId = json['widgetLayoutId'];

  Map toMap() {
    return {'widgetLayoutId': widgetLayoutId};
  }
}

class ShanYanEventHandlers {
  static final ShanYanEventHandlers _instance =
  new ShanYanEventHandlers._internal();

  ShanYanEventHandlers._internal();

  factory ShanYanEventHandlers() => _instance;
  Map<String, ShanYanWidgetEventListener> clickEventsMap = Map();
  List<ShanYanWidgetLayoutEventListener> clickLayoutEvents = [];
  List<AuthPageOnClickListener> authPageEvents = [];
}

/*
* 闪验SDK 授权页UI 配置类
* */
class ShanYanUIConfig {
  // 授权页背景
  String setAuthBGImgPath; //普通图片
  String setAuthBgGifPath; //GIF图片（只支持本地gif图，需要放置到drawable文件夹中）

  String setAuthBgVideoPath; //视频背景

  //授权页 导航栏
  bool setFullScreen; //设置是否全屏显示（true：全屏；false：不全屏）默认不全屏
  String setNavColor; //设置导航栏背景颜色
  String setNavText; //设置导航栏标题文字
  String setNavTextColor; //设置导航栏标题文字颜色
  int setNavTextSize; //设置导航栏标题文字大小
  String setNavReturnImgPath; //设置导航栏返回按钮图标
  bool setNavReturnImgHidden = false; //设置导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）
  int setNavReturnBtnWidth; //设置导航栏返回按钮宽度
  int setNavReturnBtnHeight; //设置导航栏返回按钮高度
  int setNavReturnBtnOffsetRightX; //设置导航栏返回按钮距离屏幕右侧X偏移
  int setNavReturnBtnOffsetX; //设置导航栏返回按钮距离屏幕左侧X偏移
  int setNavReturnBtnOffsetY; //设置导航栏返回按钮距离屏幕上侧Y偏移
  bool setAuthNavHidden; //设置导航栏是否隐藏（true：隐藏；false：不隐藏）
  bool setAuthNavTransparent; //设置导航栏是否透明（true：透明；false：不透明）

  // 授权页logo
  String setLogoImgPath; //设置logo图片
  int setLogoWidth; //设置logo宽度
  int setLogoHeight; //设置logo高度
  int setLogoOffsetY; //设置logo相对于标题栏下边缘y偏移
  int setLogoOffsetBottomY; //设置logo相对于屏幕底部y偏移
  bool setLogoHidden; //设置logo是否隐藏（true：隐藏；false：不隐藏）
  int setLogoOffsetX; //设置logo相对屏幕左侧X偏移

  // 授权页 号码栏
  String setNumberColor; //设置号码栏字体颜色
  int setNumFieldOffsetY; //设置号码栏相对于标题栏下边缘y偏移
  int setNumFieldOffsetBottomY; //设置号码栏相对于屏幕底部y偏移
  int setNumFieldWidth; //设置号码栏宽度
  int setNumFieldHeight; //设置号码栏高度
  int setNumberSize; //设置号码栏字体大小
  int setNumFieldOffsetX; //设置号码栏相对屏幕左侧X偏移

  //授权页 登录按钮
  String setLogBtnText; //设置登录按钮文字
  String setLogBtnTextColor; //设置登录按钮文字颜色
  String setLogBtnImgPath; //设置授权登录按钮图片
  int setLogBtnOffsetY; //设置登录按钮相对于标题栏下边缘Y偏移
  int setLogBtnOffsetBottomY; //设置登录按钮相对于屏幕底部Y偏移
  int setLogBtnTextSize; //设置登录按钮字体大小
  int setLogBtnHeight; //设置登录按钮高度
  int setLogBtnWidth; //设置登录按钮宽度
  int setLogBtnOffsetX; //设置登录按钮相对屏幕左侧X偏移

  //授权页 隐私协议栏
  List<String> setAppPrivacyOne; //设置开发者隐私条款1，包含两个参数：1.名称 2.URL
  List<String> setAppPrivacyTwo; //设置开发者隐私条款2，包含两个参数：1.名称 2.URL
  List<String> setAppPrivacyThree; //设置开发者隐私条款3，包含两个参数：1.名称 2.URL
  bool setPrivacySmhHidden; //设置协议名称是否显示书名号《》，默认显示书名号（true：不显示；false：显示）
  int setPrivacyTextSize; //设置隐私栏字体大小
  List<String> setAppPrivacyColor; //设置隐私条款文字颜色，包含两个参数：1.基础文字颜色 2.协议文字颜色
  int setPrivacyOffsetBottomY; //设置隐私条款相对于授权页面底部下边缘y偏移
  int setPrivacyOffsetY; //设置隐私条款相对于授权页面标题栏下边缘y偏移
  int setPrivacyOffsetX; //设置隐私条款相对屏幕左侧X偏移
  bool setPrivacyOffsetGravityLeft; //设置隐私条款文字左对齐（true：左对齐；false：居中）
  bool setPrivacyState; //设置隐私条款的CheckBox是否选中（true：选中；false：未选中）
  String setUncheckedImgPath; //设置隐私条款的CheckBox未选中时图片
  String setCheckedImgPath; //设置隐私条款的CheckBox选中时图片
  bool setCheckBoxHidden; //设置隐私条款的CheckBox是否隐藏（true：隐藏；false：不隐藏）
  List<int> setCheckBoxWH; //设置checkbox的宽高，包含两个参数：1.宽 2.高
  List<int> setCheckBoxMargin; //设置checkbox的间距，包含四个参数：1.左间距 2.上间距 3.右间距 4.下间距
  List<String> setPrivacyText; //设置隐私条款名称外的文字,包含五个参数

  //授权页 slogan（***提供认证服务）
  String setSloganTextColor; //设置slogan文字颜色
  int setSloganTextSize; //设置slogan文字字体大小
  int setSloganOffsetY; //设置slogan相对于标题栏下边缘y偏移
  bool setSloganHidden = false; //设置slogan是否隐藏（true：隐藏；false：不隐藏）
  int setSloganOffsetBottomY; //设置slogan相对屏幕底部Y偏移
  int setSloganOffsetX; //设置slogan相对屏幕左侧X偏移

  String setLoadingView; //设置授权页点击一键登录自定义loading
  List<String>
  setDialogTheme; //设置授权页为弹窗样式，包含5个参数：1.弹窗宽度 2.弹窗高度 3.弹窗X偏移量（以屏幕中心为原点） 4.弹窗Y偏移量（以屏幕中心为原点） 5.授权页弹窗是否贴于屏幕底部

  Map toJsonMap() {
    return {
      "setAuthBGImgPath": setAuthBGImgPath ??= null,
      "setAuthBgGifPath": setAuthBgGifPath ??= null,
      "setAuthBgVideoPath": setAuthBgVideoPath ??= null,
      "setFullScreen": setFullScreen,
      "setNavColor": setNavColor ??= null,
      "setNavText": setNavText ??= null,
      "setNavTextColor": setNavTextColor ??= null,
      "setNavTextSize": setNavTextSize ??= null,
      "setNavReturnImgPath": setNavReturnImgPath ??= null,
      "setNavReturnImgHidden": setNavReturnImgHidden,
      "setNavReturnBtnWidth": setNavReturnBtnWidth ??= null,
      "setNavReturnBtnHeight": setNavReturnBtnHeight ??= null,
      "setNavReturnBtnOffsetRightX": setNavReturnBtnOffsetRightX ??= null,
      "setNavReturnBtnOffsetX": setNavReturnBtnOffsetX ??= null,
      "setNavReturnBtnOffsetY": setNavReturnBtnOffsetY ??= null,
      "setAuthNavHidden": setAuthNavHidden,
      "setAuthNavTransparent": setAuthNavTransparent,
      "setLogoImgPath": setLogoImgPath ??= null,
      "setLogoWidth": setLogoWidth ??= null,
      "setLogoHeight": setLogoHeight ??= null,
      "setLogoOffsetY": setLogoOffsetY ??= null,
      "setLogoOffsetBottomY": setLogoOffsetBottomY ??= null,
      "setLogoHidden": setLogoHidden,
      "setLogoOffsetX": setLogoOffsetX ??= null,
      "setNumberColor": setNumberColor ??= null,
      "setNumFieldOffsetY": setNumFieldOffsetY ??= null,
      "setNumFieldOffsetBottomY": setNumFieldOffsetBottomY ??= null,
      "setNumFieldWidth": setNumFieldWidth ??= null,
      "setNumFieldHeight": setNumFieldHeight ??= null,
      "setNumberSize": setNumberSize ??= null,
      "setNumFieldOffsetX": setNumFieldOffsetX ??= null,
      "setLogBtnText": setLogBtnText ??= null,
      "setLogBtnTextColor": setLogBtnTextColor ??= null,
      "setLogBtnImgPath": setLogBtnImgPath ??= null,
      "setLogBtnOffsetY": setLogBtnOffsetY ??= null,
      "setLogBtnOffsetBottomY": setLogBtnOffsetBottomY ??= null,
      "setLogBtnTextSize": setLogBtnTextSize ??= null,
      "setLogBtnHeight": setLogBtnHeight ??= null,
      "setLogBtnWidth": setLogBtnWidth ??= null,
      "setLogBtnOffsetX": setLogBtnOffsetX ??= null,
      "setAppPrivacyOne": setAppPrivacyOne ??= null,
      "setAppPrivacyTwo": setAppPrivacyTwo ??= null,
      "setAppPrivacyThree": setAppPrivacyThree ??= null,
      "setPrivacySmhHidden": setPrivacySmhHidden ??= null,
      "setPrivacyTextSize": setPrivacyTextSize ??= null,
      "setAppPrivacyColor": setAppPrivacyColor ??= null,
      "setPrivacyOffsetBottomY": setPrivacyOffsetBottomY ??= null,
      "setPrivacyOffsetY": setPrivacyOffsetY ??= null,
      "setPrivacyOffsetX": setPrivacyOffsetX ??= null,
      "setPrivacyOffsetGravityLeft": setPrivacyOffsetGravityLeft,
      "setPrivacyState": setPrivacyState,
      "setUncheckedImgPath": setUncheckedImgPath ??= null,
      "setCheckedImgPath": setCheckedImgPath ??= null,
      "setCheckBoxHidden": setCheckBoxHidden,
      "setCheckBoxWH": setCheckBoxWH ??= null,
      "setCheckBoxMargin": setCheckBoxMargin ??= null,
      "setPrivacyText": setPrivacyText ??= null,
      "setSloganTextColor": setSloganTextColor ??= null,
      "setSloganTextSize": setSloganTextSize ??= null,
      "setSloganOffsetY": setSloganOffsetY ??= null,
      "setSloganHidden": setSloganHidden,
      "setSloganOffsetBottomY": setSloganOffsetBottomY ??= null,
      "setSloganOffsetX": setSloganOffsetX ??= null,
      "setLoadingView": setLoadingView ??= null,
      "setDialogTheme": setDialogTheme ??= null,
    }..removeWhere((key, value) => value == null);
  }
}

//添加自定义布局类型，目前支持RelativeLayout布局xml文件
enum ShanYanCustomWidgetLayoutType { RelativeLayout }

// 自定义控件
class ShanYanCustomWidgetLayout {
  String widgetLayoutName;
  List<String> widgetLayoutId; //自定义控件ID
  int left = 0; // 自定义控件距离屏幕左边缘偏移量，单位dp
  int top = 0; // 自定义控件距离导航栏底部偏移量，单位dp
  int right = 0; // 自定义控件距离屏幕右边缘偏移量，单位dp
  int bottom = 0; // 自定义控件距离屏幕底部偏移量，单位dp
  int width = 0; // 自定义控件宽度，单位dp
  int height = 0; // 自定义控件高度，单位dp
  ShanYanCustomWidgetLayoutType type; //自定义控件类型，目前只支持 textView,button
  ShanYanCustomWidgetLayout(
      @required this.widgetLayoutName, @required this.type) {
    this.widgetLayoutName = widgetLayoutName;
    this.type = type;
  }

  Map toJsonMap() {
    return {
      "widgetLayoutName": widgetLayoutName,
      "widgetLayoutId": widgetLayoutId,
      "type": getStringFromEnum(type),
      "left": left,
      "top": top,
      "right": right,
      "bottom": bottom,
      "width": width,
      "height": height,
    }..removeWhere((key, value) => value == null);
  }
}

//添加自定义控件类型，目前只支持 TextView
enum ShanYanCustomWidgetType { TextView }

// 文本对齐方式
enum ShanYanCustomWidgetGravityType { left, right, center }

// 自定义控件
class ShanYanCustomWidget {
  String widgetId; //自定义控件ID
  int left = 0; // 自定义控件距离屏幕左边缘偏移量，单位dp
  int top = 0; // 自定义控件距离导航栏底部偏移量，单位dp
  int right = 0; // 自定义控件距离屏幕右边缘偏移量，单位dp
  int bottom = 0; // 自定义控件距离屏幕底部偏移量，单位dp
  int width = 0; // 自定义控件宽度，单位dp
  int height = 0; // 自定义控件高度，单位dp
  String textContent = ""; // 自定义控件内容
  double textFont = 13.0; // 自定义控件文字大小，单位sp
  String textColor = "#aa0000"; // 自定义控件文字颜色
  String backgroundColor; // 自定义控件背景颜色
  String backgroundImgPath; // 自定义控件背景图片
  ShanYanCustomWidgetGravityType textAlignment; //自定义控件内容对齐方式
  ShanYanCustomWidgetType type; //自定义控件类型，目前只支持 textView,button
  bool isFinish = true; //点击自定义控件是否自动销毁授权页

  ShanYanCustomWidget(@required this.widgetId, @required this.type) {
    this.widgetId = widgetId;
    this.type = type;
  }

  Map toJsonMap() {
    return {
      "widgetId": widgetId,
      "type": getStringFromEnum(type),
      "textContent": textContent,
      "textFont": textFont ??= null,
      "backgroundImgPath": backgroundImgPath ??= null,
      "textAlignment": getStringFromEnum(textAlignment),
      "textColor": textColor ??= null,
      "backgroundColor": backgroundColor ??= null,
      "isFinish": isFinish,
      "left": left,
      "top": top,
      "right": right,
      "bottom": bottom,
      "width": width,
      "height": height,
    }..removeWhere((key, value) => value == null);
  }
}

String getStringFromEnum<T>(T) {
  if (T == null) {
    return null;
  }

  return T.toString().split('.').last;
}