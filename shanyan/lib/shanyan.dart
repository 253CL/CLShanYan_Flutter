import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'shanYanUIConfig.dart';
import 'shanYanResult.dart';

///// 监听添加的自定义控件的点击事件
//typedef ShanYanWidgetEventListener = void Function(String widgetId);
//
///// 监听添加的自定义布局的点击事件
//typedef ShanYanWidgetLayoutEventListener = void Function(
//    WidgetLayoutOnClickEvent event);
//
/// 闪验SDK 授权页回调（一键登录点击/sdk自带返回）
typedef ShanYanOneKeyLoginListener = void Function(ShanYanResult shanYanResult);
//
//typedef AuthPageActionListener = void Function(AuthPageActionEvent event);
//
class OneKeyLoginManager {

  final ShanYanEventHandlers _eventHanders = new ShanYanEventHandlers();

  final MethodChannel _channel = const MethodChannel("shanyan");

  ShanYanUIConfig shanYanUIConfig;

  OneKeyLoginManager(){
    _channel.setMethodCallHandler(_handlerMethod);
  }

//  /// 授权页控件的点击事件（“复选框”、"协议"） Android
//  setAuthPageActionListener(AuthPageActionListener callback) {
//    _channel.invokeMethod("setActionListener");
//    _eventHanders.authPageActionListener = callback;
//  }
//
//  /// 自定义控件的点击事件 Android
//  addClikWidgetEventListener(
//      String eventId, ShanYanWidgetEventListener callback) {
//    _eventHanders.clickEventsMap[eventId] = callback;
//  }
//
//  /// 自定布局的点击事件 Android
//  addClikWidgetLayoutEventListener(ShanYanWidgetLayoutEventListener callback) {
//    _eventHanders.clickLayoutEvents.clear();
//    _eventHanders.clickLayoutEvents.add(callback);
//  }
//
//  OneKeyLoginManager.private(MethodChannel channel) : _channel = channel;
//  static final _instance =
//      new OneKeyLoginManager.private(const MethodChannel("shanyan"));


//  /// 设置调试模式开关 Android
//  void setDebug(bool debug) {
//    _channel.invokeMethod("setDebugMode", {"debug": debug});
//  }
//
  ///闪验SDK 初始化(Android+iOS)
  Future<ShanYanResult> init({String appId}) async {
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

  ///闪验SDK 拉起授权页(Android+iOS)
  Future<ShanYanResult> openLoginAuth() async {
    if (Platform.isAndroid) {

      Map<dynamic, dynamic> result = await _channel.invokeMethod("openLoginAuth");
      Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
      return ShanYanResult.fromJson(newResult);

    } else if (Platform.isIOS){

      Map iosConfigure = this.shanYanUIConfig.ios.toJson();
      Map<dynamic, dynamic> result = await _channel.invokeMethod("openLoginAuth",iosConfigure);
      Map<String, dynamic> newResult = new Map<String, dynamic>.from(result);
      return ShanYanResult.fromJson(newResult);

    }else{
      return ShanYanResult(code: 1003,message: "拉起授权页失败,暂不支持此设备");
    }
  }
  ///闪验SDK 主动销毁授权页 Android+IOS
  Future<void> finishAuthControllerCompletion() async {
    if (Platform.isIOS) {
      return await _channel.invokeMethod("finishAuthControllerCompletion");
    } else if (Platform.isAndroid) {
      return await _channel.invokeMethod("finishAuthActivity");;
    }
  }

//
//  ///闪验SDK 设置复选框是否选中 Android+IOS
//  void setCheckBoxValue(bool isChecked) {
//    _channel.invokeMethod("setCheckBoxValue", {"isChecked": isChecked});
//  }
//
//  ///闪验SDK 设置授权页loading是否隐藏 Android+IOS
//  void setLoadingVisibility(bool visibility) {
//    _channel.invokeMethod("setLoadingVisibility", {"visibility": visibility});
//  }
//
//  ///闪验SDK 本机号校验获取token (Android+iOS)
//  Future<Map<dynamic, dynamic>> startAuthentication() async {
//    return await _channel.invokeMethod("startAuthentication");
//  }
//
  ///闪验SDK 配置授权页 Android
  void setAuthThemeConfig({ShanYanUIConfig uiConfig}) {

    shanYanUIConfig = uiConfig;

    Map<String, dynamic> uiConfig_json = uiConfig.toJson();

    print("uiConfig====" + uiConfig_json.toString());

    if (Platform.isAndroid) {

      //    print("uiConfig====" + uiConfig.toJsonMap().toString());
//
//    var para = Map();
//    var para1 = uiConfig.toJsonMap();
//    para1.removeWhere((key, value) => value == null);
//    para["portraitConfig"] = para1;
//    if (null != uiConfig && null != uiConfig.widgets) {
//      var widgetList = List();
//      for (ShanYanCustomWidget widget in uiConfig.widgets) {
//        var para2 = widget.toJsonMap();
//        para2.removeWhere((key, value) => value == null);
//        widgetList.add(para2);
//      }
//      para["portraitWidgets"] = widgetList;
//    }
//    if (null != uiConfig && null != uiConfig.widgetLayout) {
//      var widgetLayoutList = List();
//      for (ShanYanCustomWidgetLayout widget in uiConfig.widgetLayout) {
//        var para3 = widget.toJsonMap();
//        para3.removeWhere((key, value) => value == null);
//        widgetLayoutList.add(para3);
//      }
//      para["portraitWidgetLayout"] = widgetLayoutList;
//    }
//
//    if (null != landscapeConfig) {
//      print("landscapeConfig=====" + landscapeConfig.toJsonMap().toString());
//
//      var para2 = landscapeConfig.toJsonMap();
//      para2.removeWhere((key, value) => value == null);
//      para["landscapeConfig"] = para2;
//      if (null != landscapeConfig && null != landscapeConfig.widgets) {
//        var widgetList = List();
//        for (ShanYanCustomWidget widget in landscapeConfig.widgets) {
//          var para2 = widget.toJsonMap();
//          para2.removeWhere((key, value) => value == null);
//          widgetList.add(para2);
//        }
//        para["landscapeWidgets"] = widgetList;
//      }
//      if (null != landscapeConfig && null != landscapeConfig.widgetLayout) {
//        var widgetLayoutList = List();
//        for (ShanYanCustomWidgetLayout widget in landscapeConfig.widgetLayout) {
//          var para3 = widget.toJsonMap();
//          para3.removeWhere((key, value) => value == null);
//          widgetLayoutList.add(para3);
//        }
//        para["landscapeWidgetLayout"] = widgetLayoutList;
//      }
//    }
//    _channel.invokeMethod("setAuthThemeConfig", para);

    }
  }
//
//  //Android
  Future<void> _handlerMethod(MethodCall call) async {
    switch (call.method) {
      case 'onReceiveAuthPageEvent':
        ShanYanResult result = ShanYanResult.fromJson(call.arguments);
        _eventHanders.oneKeyLoginListener(result);
        break;
//      case 'onReceiveClickWidgetEvent':
//        {
//          String widgetId = call.arguments.cast<dynamic, dynamic>()['widgetId'];
//          bool isContains = _eventHanders.clickEventsMap.containsKey(widgetId);
//          if (isContains) {
//            ShanYanWidgetEventListener cb =
//                _eventHanders.clickEventsMap[widgetId];
//            cb(widgetId);
//          }
//        }
//        break;
//      case 'onReceiveClickWidgetLayoutEvent':
//        {
//          for (ShanYanWidgetLayoutEventListener cb
//              in _eventHanders.clickLayoutEvents) {
//            Map json = call.arguments.cast<dynamic, dynamic>();
//            WidgetLayoutOnClickEvent ev =
//                WidgetLayoutOnClickEvent.fromJson(json);
//            cb(ev);
//          }
//        }
//        break;
//
//      case 'onReceiveAuthEvent':
//        Map json = call.arguments.cast<dynamic, dynamic>();
//        AuthPageActionEvent ev = AuthPageActionEvent.fromJson(json);
//        _eventHanders.authPageActionListener(ev);
//        break;
      default:
        throw new UnsupportedError("Unrecognized Event");
    }
  }
}
//

//
///// 闪验SDK 授权页默认控件点击事件
//class AuthPageActionEvent {
//  final int type; //类型
//  final int code; //返回码
//  final String message; //事件描述
//
//  AuthPageActionEvent.fromJson(Map<dynamic, dynamic> json)
//      : type = json['type'],
//        code = json['code'],
//        message = json['message'];
//
//  Map toMap() {
//    return {'type': type, 'code': code, 'message': message};
//  }
//}
//
///// 闪验SDK 自定义布局点击事件
//class WidgetLayoutOnClickEvent {
//  final String widgetLayoutId; //点击的控件id
//  WidgetLayoutOnClickEvent.fromJson(Map<dynamic, dynamic> json)
//      : widgetLayoutId = json['widgetLayoutId'];
//
//  Map toMap() {
//    return {'widgetLayoutId': widgetLayoutId};
//  }
//}
//
class ShanYanEventHandlers {

//  final ShanYanEventHandlers _instance =  ShanYanEventHandlers._internal();

//  ShanYanEventHandlers._internal();

//  factory ShanYanEventHandlers() => _instance;
//  Map<String, ShanYanWidgetEventListener> clickEventsMap = Map();
//  List<ShanYanWidgetLayoutEventListener> clickLayoutEvents = [];
  ShanYanOneKeyLoginListener oneKeyLoginListener;
//  AuthPageActionListener authPageActionListener;
}


//
//String getStringFromEnum<T>(T) {
//  if (T == null) {
//    return null;
//  }
//
//  return T.toString().split('.').last;
//}
