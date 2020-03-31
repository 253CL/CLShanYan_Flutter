import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:shanyan/shanyan.dart';
import 'package:shanyan/shanYanUIConfig.dart';
import 'package:shanyan/shanYanResult.dart';

import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:ui';
import 'dart:io';
import 'dart:convert' as convert;

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String shanyan_code = "code";
  final String shanyan_result = "result";
  final String shanyan_operator = "operator";
  final String shanyan_widgetLayoutId = "widgetLayoutId";
  final String shanyan_widgetId = "widgetId";
  var controllerPHone = new TextEditingController();

  bool _loading = false;

  String _result = "result=";
  int _code = 0;
  String _content = "content=";

  var ios_uiConfigure;

  final OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('shanyan_flutter demo'),
        ),
        body: ModalProgressHUD(child: _buildContent(), inAsyncCall: _loading),
      ),
    );
  }


  Future<void> initPlatformState() async {
    String appId;
    if (Platform.isIOS) {
      appId = "7I5nJT7h";
    } else if (Platform.isAndroid) {
      appId = "loXN4jDs";
    }
    //闪验SDK 初始化
    oneKeyLoginManager.init(appId: appId).then((shanYanResult) {

      setState(() {
        _code = shanYanResult.code;
        _result = shanYanResult.message;
        _content = shanYanResult.toJson().toString();
      });

      if (1000 == shanYanResult.code) {
        //初始化成功
      } else {
        //初始化失败
      }

    });
  }

  Future<void> getPhoneInfoPlatformState() async {
    //闪验SDK 预取号
    oneKeyLoginManager.getPhoneInfo().then((ShanYanResult shanYanResult) {
      setState(() {
        _code = shanYanResult.code;
        _result = shanYanResult.message;
        _content = shanYanResult.toJson().toString();
      });

      if (1000 == shanYanResult.code) {
        //预取号成功
      } else {
        //预取号失败
      }
    });
  }

  Future<void> openLoginAuthPlatformState() async {

    ///闪验SDK 设置授权页一键登录回调（“一键登录按钮”、返回按钮（包括物理返回键））
    oneKeyLoginManager.setOneKeyLoginListener((ShanYanResult shanYanResult) {
      setState(() {
        _code = shanYanResult.code;
        _result = shanYanResult.message;
        _content = shanYanResult.toJson().toString();
      });

      if (1000 == shanYanResult.code) {
        ///一键登录获取token成功
      } else if (1011 == shanYanResult.code){
        ///点击返回/取消 （强制自动销毁）
      }else{
        ///一键登录获取token失败

        //关闭授权页
        oneKeyLoginManager.finishAuthControllerCompletion();

      }
    });

    ///闪验SDK 拉起授权页
    oneKeyLoginManager.openLoginAuth().then((ShanYanResult shanYanResult) {
      setState(() {
        _code = shanYanResult.code;
        _result = shanYanResult.message;
        _content = shanYanResult.toJson().toString();
      });

      if (1000 == shanYanResult.code) {
        //拉起授权页成功
      } else {
        //拉起授权页失败
      }
    });

  }

  Future<void> startAuthenticationState() async {
//    //闪验SDK 本机认证获取token
    oneKeyLoginManager.startAuthentication().then((shanYanResult) {
      setState(() {
        _code = shanYanResult.code;
        _result = shanYanResult.message;
        _content = shanYanResult.toJson().toString();
      });

      if (1000 == shanYanResult.code) {
        //初始化成功
      } else {
        //初始化失败
      }
    });
  }

  void setAuthPopupThemeConfig() {
    double screenWidthPortrait = window.physicalSize.width / window.devicePixelRatio; //竖屏宽
    double screenHeightPortrait = window.physicalSize.height / window.devicePixelRatio; //竖屏宽

    ShanYanUIConfig shanYanUIConfig = ShanYanUIConfig();
    /*iOS 页面样式设置*/
    shanYanUIConfig.ios.setAppPrivacyFirst = ["中策云店服务协议","https://www.baidu.com"];
    shanYanUIConfig.ios.setAppPrivacySecond = ["中策云店赢驷条款","https://www.sina.com"];

    oneKeyLoginManager.setAuthThemeConfig(uiConfig: shanYanUIConfig);

    //隐私协议
    final String otherLoginButton_widgetId = "Button_20200331_otherLoginButton"; // 其他方式登录 id
    final String cancel_right_btn_widgetId = "Button_20200331_cancelButton"; // 右上角取消 id
    oneKeyLoginManager.addClikWidgetEventListener((eventId) {
      if (eventId == otherLoginButton_widgetId) {
        _toast("点击了验证码登录，id ：" + eventId);
      }
      if (eventId == cancel_right_btn_widgetId){
        _toast("点击了取消，id ：" + eventId);
      }
    });
    oneKeyLoginManager.setAuthPageActionListener((AuthPageActionEvent authPageActionEvent) {
      Map map = authPageActionEvent.toMap();
      print("setActionListener" + map.toString());
      _toast("点击：${map.toString()}");
    });

    setState(() {
      _content = "界面配置成功";
    });
  }

  Widget _buildContent() {
    return Center(
      widthFactor: 2,
      child: new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            color: Colors.greenAccent,
            child: Text(_content),
            width: 300,
            height: 180,
          ),
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CustomButton(
                          onPressed: () {
                            initPlatformState();
                          },
                          title: "闪验SDK  初始化"),
                      new Text("   "),
                      new CustomButton(
                        onPressed: () {
                          getPhoneInfoPlatformState();
                        },
                        title: "闪验SDK  预取号",
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CustomButton(
                        onPressed: () {
                          setAuthPopupThemeConfig();
                        },
                        title: "授权页  弹窗样式",
                      ),
                    ],
                  ),
                ),
                new Container(
                  child: SizedBox(
                    child: new CustomButton(
                      onPressed: () {
                        openLoginAuthPlatformState();
                      },
                      title: "闪验SDK 拉起授权页",
                    ),
                    width: double.infinity,
                  ),
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                ),
                new Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "请输入手机号码",
                        hintStyle: TextStyle(color: Colors.black)),
                    controller: controllerPHone,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                      LengthLimitingTextInputFormatter(11) //限制长度
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                ),
                new Container(
                  child: SizedBox(
                    child: new CustomButton(
                      onPressed: () {
                        initPlatformState();
                      },
                      title: "本机认证 初始化",
                    ),
                    width: double.infinity,
                  ),
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                ),
                new Container(
                  child: SizedBox(
                    child: new CustomButton(
                      onPressed: () {
                        startAuthenticationState();
                      },
                      title: "本机认证 获取token",
                    ),
                    width: double.infinity,
                  ),
                  margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                )
              ],
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}

void _toast(String str) {
  Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}

/// 封装 按钮
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const CustomButton({@required this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new FlatButton(
      onPressed: onPressed,
      child: new Text("$title"),
      color: Color(0xff585858),
      highlightColor: Color(0xff888888),
      splashColor: Color(0xff888888),
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    );
  }
}
