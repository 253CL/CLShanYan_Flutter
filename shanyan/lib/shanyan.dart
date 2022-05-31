import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'shanYanResult.dart';
import 'shanYanUIConfig.dart';

/// 闪验SDK 授权页回调（一键登录点击/sdk自带返回）
typedef ShanYanOneKeyLoginListener = void Function(ShanYanResult shanYanResult);

/// 闪验SDK 自定义控件点击回调
typedef ShanYanWidgetEventListener = void Function(String shanYanWidgetEvent);

/// 闪验SDK 授权页点击事件监听（复选框和协议）
typedef AuthPageActionListener = void Function(AuthPageActionEvent event);

class OneKeyLoginManager {
  final ShanYanEventHandlers _eventHanders = new ShanYanEventHandlers();

  final MethodChannel _channel = const MethodChannel("shanyan");

  ShanYanUIConfig shanYanUIConfig = new ShanYanUIConfig();

  OneKeyLoginManager() {
    _channel.setMethodCallHandler(_handlerMethod);
  }

  /// 授权页控件的点击事件（“复选框”、"协议"） Android
  setAuthPageActionListener(AuthPageActionListener callback) {
    _channel.invokeMethod("setActionListener");
    _eventHanders.authPageActionListener = callback;
  }

//  /// 设置调试模式开关 Android
  void setDebug(bool debug) {
    _channel.invokeMethod("setDebugMode", {"debug": debug});
  }

  void getOaidEnable(bool oaidEnable) {
    _channel.invokeMethod("getOaidEnable", {"oaidEnable": oaidEnable});
  }

  void getSinbEnable(bool sinbEnable) {
    _channel.invokeMethod("getSinbEnable", {"sinbEnable": sinbEnable});
  }

  void getSiEnable(bool sibEnable) {
    _channel.invokeMethod("getSiEnable", {"sibEnable": sibEnable});
  }

  void getIEnable(bool iEnable) {
    _channel.invokeMethod("getIEnable", {"iEnable": iEnable});
  }

  void getMaEnable(bool maEnable) {
    _channel.invokeMethod("getMaEnable", {"maEnable": maEnable});
  }

  void getImEnable(bool imEnable) {
    _channel.invokeMethod("getImEnable", {"imEnable": imEnable});
  }

  Future<String> getOperatorType() async {
    return await _channel.invokeMethod("getOperatorType");
  }

  ///闪验SDK 初始化(Android+iOS)
  Future<ShanYanResult> init({required String appId}) async {
    Map result = await _channel.invokeMethod("init", {"appId": appId});
    Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
    return ShanYanResult.fromJson(newResult);
  }

  ///闪验SDK 预取号(Android+iOS)
  Future<ShanYanResult> getPhoneInfo() async {
    Map<dynamic, dynamic> result = await _channel.invokeMethod("getPhoneInfo");
    Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
    return ShanYanResult.fromJson(newResult);
  }

  /// 设置授权页一键登录回调（“一键登录按钮”、返回按钮（包括物理返回键）） (Android+iOS)
  setOneKeyLoginListener(ShanYanOneKeyLoginListener callback) {
    _eventHanders.oneKeyLoginListener = callback;
  }

  /// 自定义控件的点击事件 Android
  addClikWidgetEventListener(ShanYanWidgetEventListener callback) {
    _eventHanders.shanYanWidgetEventListener = callback;
  }

  ///闪验SDK 拉起授权页(Android+iOS)
  Future<ShanYanResult> openLoginAuth() async {
    if (Platform.isAndroid) {
      Map<dynamic, dynamic> result =
          await _channel.invokeMethod("openLoginAuth");
      Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
      return ShanYanResult.fromJson(newResult);
    } else if (Platform.isIOS) {
      Map iosConfigure = this.shanYanUIConfig.ios.toJson();
      Map<dynamic, dynamic> result =
          await _channel.invokeMethod("openLoginAuth", iosConfigure);
      Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
      return ShanYanResult.fromJson(newResult);
    } else {
      return ShanYanResult(code: 1003, message: "拉起授权页失败,暂不支持此设备");
    }
  }

  ///闪验SDK 主动销毁授权页 Android+IOS
  Future<void> finishAuthControllerCompletion() async {
    if (Platform.isIOS) {
      return await _channel.invokeMethod("finishAuthControllerCompletion");
    } else if (Platform.isAndroid) {
      return await _channel.invokeMethod("finishAuthActivity");
    }
  }

//  Future<void> alertNativeIOS(String title,String message,String cancelButtonTitle,String okButtonTitle,String otherButtonTitle) async {
//    Map alert = {
//      "title":title,
//      "message":message,
//      "cancelButtonTitle":cancelButtonTitle,
//      "okButtonTitle": okButtonTitle,
//      "otherButtonTitle":otherButtonTitle
//    };
//
//    Map<dynamic, dynamic> result = await _channel.invokeMethod("alertNative",alert);
//    Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
//    return ShanYanResult.fromJson(newResult);
//  }

//
  ///闪验SDK 设置复选框是否选中 Android+IOS
  void setCheckBoxValue(bool isChecked) {
    _channel.invokeMethod("setCheckBoxValue", {"isChecked": isChecked});
  }

  ///闪验SDK 设置授权页loading是否隐藏 Android+IOS
  void setLoadingVisibility(bool visibility) {
    _channel.invokeMethod("setLoadingVisibility", {"visibility": visibility});
  }

  ///闪验SDK 本机号校验获取token (Android+iOS)
  Future<ShanYanResult> startAuthentication() async {
    Map<dynamic, dynamic> result =
        await _channel.invokeMethod("startAuthentication");
    Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
    return ShanYanResult.fromJson(newResult);
  }

  /// 清除预取号缓存
  void clearScripCache() {
      _channel.invokeMethod("clearScripCache");
  }

  ///闪验SDK 配置授权页 Android
  void setAuthThemeConfig({required ShanYanUIConfig uiConfig}) {
    shanYanUIConfig = uiConfig;
    if (Platform.isIOS) {
      print("uiConfig====" + uiConfig.ios.toJson().toString());
    } else if (Platform.isAndroid) {
      Map<String, dynamic> uiConfig_json = uiConfig.toJson();
      _channel.invokeMethod("setAuthThemeConfig", uiConfig_json);
      print("uiConfig====" + uiConfig.androidLandscape.toJson().toString());
    }
  }

  //Android
  Future<void> _handlerMethod(MethodCall call) async {
    switch (call.method) {
      case 'onReceiveAuthPageEvent':
        Map<String, dynamic> newResult =
            new Map<String, dynamic>.from(call.arguments);
        ShanYanResult result = ShanYanResult.fromJson(newResult);
        _eventHanders.oneKeyLoginListener?.call(result);
        break;
      case 'onReceiveClickWidgetEvent':
        {
          String widgetId = call.arguments.cast<dynamic, dynamic>()['widgetId'];
          print("点击了：" + widgetId);
          if (null != widgetId) {
            _eventHanders.shanYanWidgetEventListener?.call(widgetId);
          }
        }
        break;
      case 'onReceiveAuthEvent':
        Map json = call.arguments.cast<dynamic, dynamic>();
        AuthPageActionEvent ev = AuthPageActionEvent.fromJson(json);
        _eventHanders.authPageActionListener?.call(ev);
        break;
      default:
        throw new UnsupportedError("Unrecognized Event");
    }
  }
}

/// 闪验SDK 授权页默认控件点击事件
class AuthPageActionEvent {
  final int type; //类型
  final int code; //返回码
  final String message; //事件描述

  AuthPageActionEvent.fromJson(Map<dynamic, dynamic> json)
      : type = json['type'],
        code = json['code'],
        message = json['message'];

  Map toMap() {
    return {'type': type, 'code': code, 'message': message};
  }
}

/// 闪验SDK 自定义控件点击事件
class ShanYanWidgetEvent {
  final String widgetLayoutId; //点击的控件id
  ShanYanWidgetEvent.fromJson(Map<dynamic, dynamic> json)
      : widgetLayoutId = json['widgetLayoutId'];

  Map toMap() {
    return {'widgetLayoutId': widgetLayoutId};
  }
}

class ShanYanEventHandlers {
  ShanYanOneKeyLoginListener? oneKeyLoginListener;
  ShanYanWidgetEventListener? shanYanWidgetEventListener;
  AuthPageActionListener? authPageActionListener;
}

//
//String getStringFromEnum<T>(T) {
//  if (T == null) {
//    return null;
//  }
//
//  return T.toString().split('.').last;
//}
