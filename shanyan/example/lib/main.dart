import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shanyan/shanyan.dart';
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
    initListener();
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

  Future<void> initListener() async {

    if (Platform.isIOS){

    }else if(Platform.isAndroid){
      //闪验SDK 设置调试模式开关
      oneKeyLoginManager.setDebug(true);
      oneKeyLoginManager.setOnClickPrivacyListener();
      oneKeyLoginManager.setAuthPageOnClickListener(
              (AuthPageOnClickEvent authPageOnClickEvent) {
            Map map = authPageOnClickEvent.toMap();
            setState(() {
              _code = map[shanyan_code];
              _result = map[shanyan_result];
              _content = " code===" + _code.toString() + "\n result===" + _result;
              if (1000 == map[shanyan_code]) {
                oneKeyLoginManager.finishAuthActivity();
                _toast("一键登录 获取token成功");
              } else {
                _toast("点击：${map[shanyan_result]}");
              }
            });
          });
    }

  }

  Future<void> initPlatformState() async {

    String appId;
    if (Platform.isIOS){
      appId = "7I5nJT7h";
    }else if(Platform.isAndroid){
      appId = "loXN4jDs";
    }
    //闪验SDK 初始化
    oneKeyLoginManager
        .init(
      appId: appId,
    )
        .then((map) {
      setState(() {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
        _content = " code===" + _code.toString() + "\n result===" + _result;
      });
      if (1000 == map[shanyan_code]) {
        //初始化成功
      } else {
        //初始化失败
      }
    });
  }

  Future<void> getPhoneInfoPlatformState() async {
    //闪验SDK 预取号
    oneKeyLoginManager.getPhoneInfo().then((map) {
      setState(() {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
        _content = " code===" + _code.toString() + "\n result===" + _result;
      });
      if (1022 == map[shanyan_code]) {
        //预取号成功
      } else {
        //预取号失败
      }
    });
  }

  Future<void> openLoginAuthPlatformState() async {

    if (Platform.isIOS){
      //先设置SDK回调监听
      //openLoginAuthListener:调起授权页回调
      oneKeyLoginManager.openLoginAuthListener().then((map){
        setState(() {
          _code = map[shanyan_code];
          _result = map[shanyan_result];
          _content = " code===" + _code.toString() + "\n result===" + _result;
        });

        if (1000 == map[shanyan_code]) {
          //调起授权页成功
        } else {
          //调起授权页失败
        }

      });

      //openLoginAuthListener:调起授权页成功，后续回调
      oneKeyLoginManager.oneKeyLoginListener().then((map){
        int code = map[shanyan_code];
        if(code == 1000){
          //成功

          //关闭授权页
          oneKeyLoginManager.finishAuthControllerCompletion();

        } else {
          if(code == 1011){
            //取消

          }else{
            //失败

            //关闭授权页
            oneKeyLoginManager.finishAuthControllerCompletion();

          }
        }
        setState(() {
          _code = map[shanyan_code];
          _result = map[shanyan_result];
          Map<String, dynamic> result = convert.jsonDecode(_result);
          _content = " code===" + _code.toString() + "\n result===" + result["token"];
        });
      });
      //调起授权页
      oneKeyLoginManager.quickAuthLoginWithConfigure(this.ios_uiConfigure);

    }else if(Platform.isAndroid){
      //闪验SDK 拉起授权页
      oneKeyLoginManager
          .openLoginAuth(
        isFinish: false,
      )
          .then((map) {
        setState(() {
          _code = map[shanyan_code];
          _result = map[shanyan_result];
          _content = " code===" + _code.toString() + "\n result===" + _result;
        });
      });
    }
  }

  Future<void> startAuthenticationState() async {
//    RegExp exp = RegExp(
//        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
//    bool matched = exp.hasMatch(controllerPHone.text);
//    if (controllerPHone.text == null || controllerPHone.text == "") {
//      setState(() {
//        _result = "手机号码不能为空";
//        _content = " code===0" + "\n result===" + _result;
//      });
//      _toast("手机号码不能为空");
//      return;
//    } else if (!matched) {
//      setState(() {
//        _result = "请输入正确的手机号";
//        _content = " code===0" + "\n result===" + _result;
//      });
//      _toast("请输入正确的手机号");
//      return;
//    }
    //闪验SDK 本机认证获取token
    oneKeyLoginManager
        .startAuthentication()
        .then((map) {
      setState(() {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
        _content = " code===" + _code.toString() + "\n result===" + _result;
      });
      if (2000 == map[shanyan_code]) {
        //本机认证获取token成功
      }
    });
  }

  void setAuthThemeConfig() {

    if (Platform.isIOS){
      //iOS 全屏模式

      double screenWidthPortrait = window.physicalSize.width / window.devicePixelRatio; //竖屏宽

      var screenScale = screenWidthPortrait / 375.0; //相对iphone6屏幕
      if (screenScale > 1) {
        screenScale = 1; //大屏的无需放大
      }

      //竖屏
      double clLayoutLogoTop_Portrait = screenScale * 60;
      double clLayoutLogoWidth_Portrait = 60 * screenScale;
      double clLayoutLogoHeight_Portrait = 60 * screenScale;
      double clLayoutLogoCenterX_Portrait = 0;

      double clLayoutPhoneCenterY_Portrait = -20 * screenScale;
      double clLayoutPhoneLeft_Portrait = 50 * screenScale;
      double clLayoutPhoneRight_Portrait = -50 * screenScale;
      double clLayoutPhoneHeight_Portrait = 20 * screenScale;

      double clLayoutLoginBtnCenterY_Portrait = clLayoutPhoneCenterY_Portrait + clLayoutPhoneHeight_Portrait * 0.5 *
          screenScale + 20 * screenScale + 15 * screenScale;
      double clLayoutLoginBtnHeight_Portrait = 30 * screenScale;
      double clLayoutLoginBtnLeft_Portrait = 70 * screenScale;
      double clLayoutLoginBtnRight_Portrait = -70 * screenScale;

      double clLayoutAppPrivacyLeft_Portrait = 40 * screenScale;
      double clLayoutAppPrivacyRight_Portrait = -40 * screenScale;
      double clLayoutAppPrivacyBottom_Portrait = 0 * screenScale;
      double clLayoutAppPrivacyHeight_Portrait = 45 * screenScale;

      double clLayoutSloganLeft_Portrait = 0;
      double clLayoutSloganRight_Portrait = 0;
      double clLayoutSloganHeight_Portrait = 15 * screenScale;
      double clLayoutSloganBottom_Portrait = clLayoutAppPrivacyBottom_Portrait - clLayoutAppPrivacyHeight_Portrait;

      //横屏 （如app本身不支持横屏，可不需设置横屏下UI配置）

      double clLayoutLogoWidth_Landscape = 60 * screenScale;
      double clLayoutLogoHeight_Landscape = 60 * screenScale;
      double clLayoutLogoCenterX_Landscape = 0;
      double clLayoutLogoTop_Landscape = 25 * screenScale;

      double clLayoutPhoneCenterY_Landscape = -20 * screenScale;
      double clLayoutPhoneLeft_Landscape = 50 * screenScale;
      double clLayoutPhoneRight_Landscape = -50 * screenScale;
      double clLayoutPhoneHeight_Landscape = 20 * screenScale;

      double clLayoutLoginBtnCenterY_Landscape = clLayoutPhoneCenterY_Landscape + clLayoutPhoneHeight_Landscape * 0.5 *
          screenScale + 20 * screenScale + 15 * screenScale;
      double clLayoutLoginBtnHeight_Landscape = 30 * screenScale;
      double clLayoutLoginBtnLeft_Landscape = 70 * screenScale;
      double clLayoutLoginBtnRight_Landscape = -70 * screenScale;

      double clLayoutAppPrivacyLeft_Landscape = 40 * screenScale;
      double clLayoutAppPrivacyRight_Landscape = -40 * screenScale;
      double clLayoutAppPrivacyBottom_Landscape = 0 * screenScale;
      double clLayoutAppPrivacyHeight_Landscape = 45 * screenScale;

      double clLayoutSloganLeft_Landscape = 0;
      double clLayoutSloganRight_Landscape = 0;
      double clLayoutSloganHeight_Landscape = 15 * screenScale;
      double clLayoutSloganBottom_Landscape = clLayoutAppPrivacyBottom_Landscape - clLayoutAppPrivacyHeight_Landscape;

      this.ios_uiConfigure =
      {
        "clBackgroundImg": "assets/Img/eb9a0dae18491990a43fe02832d3cafa.jpg",

        "shouldAutorotate": true,
        /**支持方向
         * 如支持横竖屏，需同时设置 clOrientationLayOutPortrait 和 clOrientationLayOutLandscape
         * 0:UIInterfaceOrientationMaskPortrait
         * 1:UIInterfaceOrientationMaskLandscapeLeft
         * 2:UIInterfaceOrientationMaskLandscapeRight
         * 3:UIInterfaceOrientationMaskPortraitUpsideDown
         * 4:UIInterfaceOrientationMaskLandscape
         * 5:UIInterfaceOrientationMaskAll
         * 6:UIInterfaceOrientationMaskAllButUpsideDown
         * */
        "supportedInterfaceOrientations": 5,

        /**偏好方向
         * -1:UIInterfaceOrientationUnknown
         * 0:UIInterfaceOrientationPortrait
         * 1:UIInterfaceOrientationPortraitUpsideDown
         * 2:UIInterfaceOrientationLandscapeLeft
         * 3:UIInterfaceOrientationLandscapeRight
         * */
        //偏好方向默认Portrait preferredInterfaceOrientationForPresentation: Number(5),

        "clNavigationBackgroundClear": true, //导航栏透明
        "clNavigationBackBtnImage": "assets/Img/close-white.png", //返回按钮图片
        "clNavBackBtnAlimentRight": false, //返回按钮居右,设置自定义导航栏返回按钮时，以自定义为准

        "clLogoImage": "assets/Img/logo_shanyan_text.png", //logo图片

        "clLoginBtnText": "本机号一键登录", //一键登录按钮文字
        "clLoginBtnTextColor": [1, 1, 1, 1.0], //rgba
        "clLoginBtnBgColor": [0.2, 0.8, 0.2, 1.0], //rgba
        "clLoginBtnTextFont": 15 * screenScale,
        "clLoginBtnCornerRadius": 10,
        "clLoginBtnBorderWidth": 0.5,
        "clLoginBtnBorderColor": [0.1, 0.8, 0.1, 1.0], //rgba

        "clPhoneNumberFont": 20.0 * screenScale,

        "clAppPrivacyColor": [
          [0.6, 0.6, 0.6, 1.0],
          [0, 1, 0, 1.0]
        ], //2 item,commomTextColor and appPrivacyTextColor
        "clAppPrivacyTextFont": 11 * screenScale,
        "clAppPrivacyTextAlignment": 0, //0: center 1: left 2: right
        "clAppPrivacyFirst": ["测试连接A", "https://www.baidu.com"], // 2 item, name and url
        "clAppPrivacySecond": ["测试连接X", "https://www.sina.com"], // 2 item, name and url
//        "clAppPrivacyThird": ["测试连接C", "https://www.sina.com"], // 2 item, name and url

        "clAppPrivacyNormalDesTextFirst":"A",
        "clAppPrivacyNormalDesTextSecond":"B",
        "clAppPrivacyNormalDesTextThird":"-",
        "clAppPrivacyNormalDesTextFourth": "D",
        "clAppPrivacyNormalDesTextLast":" ",

    "clCheckBoxVerticalAlignmentToAppPrivacyCenterY": true,
        "clCheckBoxSize": [30 * screenScale, 30 * screenScale], //2 item, width and height
        "clCheckBoxImageEdgeInsets": [2 * screenScale, 10 * screenScale, 13 * screenScale, 5 * screenScale], //4 item, top left bottom right
        "clCheckBoxUncheckedImage": "assets/Img/checkBoxNor.png",
        "clCheckBoxCheckedImage": "assets/Img/checkBoxSEL.png",

        "clLoadingSize": [50, 50], //2 item, width and height
        "clLoadingTintColor": [0.2, 0.8, 0.2, 1],
        "clLoadingBackgroundColor": [1, 1, 1, 1],
        "clLoadingCornerRadius": 5,

        //竖屏布局对象
        "clOrientationLayOutPortrait": {

          //控件
          "clLayoutLogoWidth": clLayoutLogoWidth_Portrait,
          "clLayoutLogoHeight": clLayoutLogoHeight_Portrait,
          "clLayoutLogoCenterX": clLayoutLogoCenterX_Portrait,
          "clLayoutLogoTop": clLayoutLogoTop_Portrait,

          "clLayoutPhoneCenterY": clLayoutPhoneCenterY_Portrait,
          "clLayoutPhoneHeight": clLayoutPhoneHeight_Portrait,
          "clLayoutPhoneLeft": clLayoutPhoneLeft_Portrait,
          "clLayoutPhoneRight": clLayoutPhoneRight_Portrait,

          "clLayoutLoginBtnCenterY": clLayoutLoginBtnCenterY_Portrait,
          "clLayoutLoginBtnHeight": clLayoutLoginBtnHeight_Portrait,
          "clLayoutLoginBtnLeft": clLayoutLoginBtnLeft_Portrait,
          "clLayoutLoginBtnRight": clLayoutLoginBtnRight_Portrait,

          "clLayoutAppPrivacyLeft": clLayoutAppPrivacyLeft_Portrait,
          "clLayoutAppPrivacyRight": clLayoutAppPrivacyRight_Portrait,
          "clLayoutAppPrivacyBottom": clLayoutAppPrivacyBottom_Portrait,
          "clLayoutAppPrivacyHeight": clLayoutAppPrivacyHeight_Portrait,

          "clLayoutSloganLeft": clLayoutSloganLeft_Portrait,
          "clLayoutSloganRight": clLayoutSloganRight_Portrait,
          "clLayoutSloganHeight": clLayoutSloganHeight_Portrait,
          "clLayoutSloganBottom": clLayoutSloganBottom_Portrait,
        },
        //横屏布局对象 （如app本身不支持横屏，可不需设置横屏下UI配置对象）
        "clOrientationLayOutLandscape": {

          //控件
          "clLayoutLogoWidth": clLayoutLogoWidth_Landscape,
          "clLayoutLogoHeight": clLayoutLogoHeight_Landscape,
          "clLayoutLogoCenterX": clLayoutLogoCenterX_Landscape,
          "clLayoutLogoTop": clLayoutLogoTop_Landscape,

          "clLayoutPhoneCenterY": clLayoutPhoneCenterY_Landscape,
          "clLayoutPhoneHeight": clLayoutPhoneHeight_Landscape,
          "clLayoutPhoneLeft": clLayoutPhoneLeft_Landscape,
          "clLayoutPhoneRight": clLayoutPhoneRight_Landscape,

          "clLayoutLoginBtnCenterY": clLayoutLoginBtnCenterY_Landscape,
          "clLayoutLoginBtnHeight": clLayoutLoginBtnHeight_Landscape,
          "clLayoutLoginBtnLeft": clLayoutLoginBtnLeft_Landscape,
          "clLayoutLoginBtnRight": clLayoutLoginBtnRight_Landscape,

          "clLayoutAppPrivacyLeft": clLayoutAppPrivacyLeft_Landscape,
          "clLayoutAppPrivacyRight": clLayoutAppPrivacyRight_Landscape,
          "clLayoutAppPrivacyBottom": clLayoutAppPrivacyBottom_Landscape,
          "clLayoutAppPrivacyHeight": clLayoutAppPrivacyHeight_Landscape,

          "clLayoutSloganLeft": clLayoutSloganLeft_Landscape,
          "clLayoutSloganRight": clLayoutSloganRight_Landscape,
          "clLayoutSloganHeight": clLayoutSloganHeight_Landscape,
          "clLayoutSloganBottom": clLayoutSloganBottom_Landscape,
        },
        //自定义控件
        "widgets": {
          "widget0": {
            "widgetId": "customView_nav_left", //字符标记
            "type": "Button", // 类型：Button：按钮，ImageView:图片 TextView:文本
            "navPosition": "navleft", //按钮位置 navleft:导航栏左侧 ，navright:导航栏右侧（不设置默认添加到授权页上）,当设置为导航栏控件时，仅宽高可设置，位置固定
            "textContent": "自定义左侧返回按钮", //文字
            "textFont": 11, //字体
            "textColor": [1, 1, 0, 1], //文字颜色[r,g,b,a]
            // backgroundColor: [0,0,1,1],//控件背景色[r,g,b,a]
            "image": "assets/Img/close-black.png",


            // cornerRadius: 10,//圆角，设置圆角时请设置masksToBounds:true
            // masksToBounds:true,//圆角相关

            "isFinish": true, //点击销毁授权页,

            // clLayoutLeft:12,
            // clLayoutTop:60,
            // clLayoutRight:-12,
            // clLayoutBottom:-80,
            "clLayoutWidth": 40,
            "clLayoutHeight": 40,
            // clLayoutCenterX:0,
            // clLayoutCenterY:0,
          },
          "widgetnavRight": {
            "widgetId": "customView_nav_right", //字符标记
            "type": "Button", // 类型：Button：按钮，ImageView:图片 TextView:文本
            "navPosition": "navright", //按钮位置 navleft:导航栏左侧 ，navright:导航栏右侧（不设置默认添加到授权页上）,当设置为导航栏控件时，仅宽高可设置，位置固定
            "textContent": "自定义控件1（点击销毁授权页）", //文字
            "textFont": 13, //字体
            "textColor": [0, 1, 0, 1], //文字颜色[r,g,b,a]
            "backgroundColor": [0, 0, 1, 1], //控件背景色[r,g,b,a]
            "image": "assets/Img/checkbox-multiple-ma.png",

            "cornerRadius": 10, //圆角，设置圆角时请设置masksToBounds:true
            "masksToBounds": true, //圆角相关

            "isFinish": true, //点击销毁授权页,

            // clLayoutLeft:12,
            // clLayoutTop:60,
            // clLayoutRight:-12,
            // clLayoutBottom:-80,
            "clLayoutWidth": 60,
            "clLayoutHeight": 40,
            // clLayoutCenterX:0,
            // clLayoutCenterY:0,
          },
          "widget1": {
            "widgetId": "customView_one", //字符标记
            "type": "Button", // 类型：Button：按钮，ImageView:图片 TextView:文本
            "textContent": "自定义控件1（点击销毁授权页）", //文字
            "textFont": 13, //字体
            "textColor": [0, 1, 0, 1], //文字颜色[r,g,b,a]
            "backgroundColor": [0, 0, 1, 1], //控件背景色[r,g,b,a]
            "image": "assets/Img/logo_shanyan_text.png",


            "cornerRadius": 10, //圆角，设置圆角时请设置masksToBounds:true
            "masksToBounds": true, //圆角相关

            "isFinish": true, //点击销毁授权页,

            // clLayoutLeft:12,
            // clLayoutTop:60,
            // clLayoutRight:-12,
            "clLayoutBottom": -50,
            "clLayoutWidth": 180,
            "clLayoutHeight": 50,
            "clLayoutCenterX": 0,
            // clLayoutCenterY:0,
          },
          "widget2": {
            "widgetId": "customView_two", //字符标记
            "type": "TextView", // 类型：Button：按钮，ImageView:图片 TextView:文本
            "textContent": "自定义控件文本自定义控件文本自定义控件文本自定义控件文本自定义控件文本自定义控件文本自定义控件文本", //文字
            "textFont": 10, //字体
            "textColor": [1, 0.5, 0.6, 1], //文字颜色[r,g,b,a]
            "backgroundColor": [0, 1, 0, 1], //控件背景色[r,g,b,a]
            "numberOfLines": 0, //行数：默认单行， 0:无限，自动换行，其他：指定行数
            "textAlignment": 2, //0: center 1: left 2: right //仅TextView有效

            "clLayoutLeft": 80,
            // clLayoutTop:60,
            "clLayoutRight": -80,
            "clLayoutBottom": -120,
            // clLayoutWidth:150,
            "clLayoutHeight": 60,
            // clLayoutCenterX:0,
            // // clLayoutCenterY:0,
          },
          "widget3": {
            "widgetId": "customView_three_imageView", //字符标记
            "type": "ImageView", // 类型：Button：按钮，ImageView:图片 TextView:文本
            "image": "assets/Img/shanyanlogo1.png",
            "backgroundColor": [0, 1, 0, 1], //控件背景色[r,g,b,a]

            "cornerRadius": 40, //圆角，设置圆角时请设置masksToBounds:true
            "masksToBounds": true, //圆角相关

            "clLayoutLeft": 80,
            "clLayoutTop": 160,
            "clLayoutRight": -80,
            // clLayoutBottom:-280,
            // clLayoutWidth:150,
            "clLayoutHeight": 80,
            // clLayoutCenterX:0,
            // clLayoutCenterY:0,
          }
        }
      };

      //设置自定义控件点击回调,返回信息带有widgetId
      oneKeyLoginManager.setCustomInterface().then((map) {
        setState(() {
          _content = "自定义控件点击:" + map.toString();
        });
      });

    }else if(Platform.isAndroid){
      ShanYanUIConfig shanYanUIConfig = ShanYanUIConfig();
      shanYanUIConfig.setLogBtnText = "免密登录";
      shanYanUIConfig.setAuthBGImgPath = "sy_login_test_bg";
      //shanYanUIConfig.setAppPrivacyColor = [0xffffffff,0xff0085d0];
      //shanYanUIConfig.setFullScreen = true;
      shanYanUIConfig.setAppPrivacyOne = [
        "闪验用户协议",
        "https://api.253.com/api_doc/yin-si-zheng-ce/wei-hu-wang-luo-an-quan-sheng-ming.html"
      ];
      shanYanUIConfig.setAppPrivacyTwo = [
        "闪验隐私政策",
        "https://api.253.com/api_doc/yin-si-zheng-ce/ge-ren-xin-xi-bao-hu-sheng-ming.html"
      ];
      shanYanUIConfig.setAppPrivacyThree = [
        "用户服务条款",
        "https://api.253.com/api_doc/yin-si-zheng-ce/ge-ren-xin-xi-bao-hu-sheng-ming.html"
      ];
      shanYanUIConfig.setAppPrivacyColor=["#808080","#00cc00"];
      shanYanUIConfig.setPrivacyText = ["登录即同意", "、", "、", "和", "并授权使用本机号码"];
      //shanYanUIConfig.setLoadingView = "custom_loading_dialog";
      List<ShanYanCustomWidgetLayout> shanYanCustomWidgetLayout = [];
      String layout_name = "relative_item_view";
      ShanYanCustomWidgetLayout relativeLayoutWidget = ShanYanCustomWidgetLayout(
          layout_name, ShanYanCustomWidgetLayoutType.RelativeLayout);
      relativeLayoutWidget.top = 300;
      relativeLayoutWidget.widgetLayoutId = ["weixin", "qq", "weibo"];
      oneKeyLoginManager.addClikWidgetLayoutEventListener(
              (WidgetLayoutOnClickEvent widgetLayoutOnClickEvent) {
            Map map = widgetLayoutOnClickEvent.toMap();
            if ("weixin" == map[shanyan_widgetLayoutId]) {
              _toast("点击 微信");
            } else if ("qq" == map[shanyan_widgetLayoutId]) {
              _toast("点击 QQ");
            } else if ("weibo" == map[shanyan_widgetLayoutId]) {
              _toast("点击 微博");
            }
          });

      shanYanCustomWidgetLayout.add(relativeLayoutWidget);

      List<ShanYanCustomWidget> shanyanCustomWidget = [];
      final String btn_widgetId = "other_custom_button"; // 标识控件 id
      ShanYanCustomWidget buttonWidget =
      ShanYanCustomWidget(btn_widgetId, ShanYanCustomWidgetType.TextView);
      buttonWidget.textContent = "其他方式登录 >";
      buttonWidget.bottom = 200;
      buttonWidget.width = 150;
      buttonWidget.height = 40;
      buttonWidget.backgroundColor ="#330000";
      buttonWidget.isFinish = false;
      //buttonWidget.btnNormalImageName = "";
      //buttonWidget.btnPressedImageName = "";
      buttonWidget.textAlignment = ShanYanCustomWidgetGravityType.center;
      // 添加点击事件监听
      oneKeyLoginManager.addClikWidgetEventListener(btn_widgetId, (eventId) {
        if ("other_custom_button" == eventId) {
          _toast("点击其他方式登录");
        }
      });
      shanyanCustomWidget.add(buttonWidget);
      oneKeyLoginManager.setAuthThemeConfig(
          uiConfig: shanYanUIConfig,
          widgets: shanyanCustomWidget,
          widgetLayout: shanYanCustomWidgetLayout);
    }

    setState(() {
      _content = "界面配置成功";
    });

  }

  void setAuthPopupThemeConfig() {
    if(Platform.isIOS){
      //iOS 弹窗模式

      double screenWidth_Portrait = window.physicalSize.width / window.devicePixelRatio; //竖屏宽
      double screenHeight_Portrait = window.physicalSize.height / window.devicePixelRatio; //竖屏宽
      double screenWidth_Landscape = window.physicalSize.height / window.devicePixelRatio; //横屏宽(即竖屏高)
      double screenHeight_Landscape = window.physicalSize.width / window.devicePixelRatio; //横屏高(即竖屏宽)

      log(screenWidth_Portrait.toString());

      var screenScale = screenWidth_Portrait / 375.0; //相对iphone6屏幕
      if (screenScale > 1) {
        screenScale = 1; //大屏的无需放大
      }

      //竖屏
      //窗口中心
      double clAuthWindowOrientationCenterX_Portrait = screenWidth_Portrait * 0.5;
      double clAuthWindowOrientationCenterY_Portrait = screenHeight_Portrait * 0.5;

      //窗口宽高
      double clAuthWindowOrientationWidth_Portrait = screenWidth_Portrait * 0.8;
      double clAuthWindowOrientationHeight_Portrait = clAuthWindowOrientationWidth_Portrait * 0.8;

      double clLayoutLogoTop_Portrait = screenScale * 25;
      double clLayoutLogoWidth_Portrait = 60 * screenScale;
      double clLayoutLogoHeight_Portrait = 60 * screenScale;
      double clLayoutLogoCenterX_Portrait = 0;

      double clLayoutPhoneCenterY_Portrait = -20 * screenScale;
      double clLayoutPhoneLeft_Portrait = 50 * screenScale;
      double clLayoutPhoneRight_Portrait = -50 * screenScale;
      double clLayoutPhoneHeight_Portrait = 20 * screenScale;

      double clLayoutLoginBtnCenterY_Portrait = clLayoutPhoneCenterY_Portrait + clLayoutPhoneHeight_Portrait * 0.5 *
          screenScale + 20 * screenScale + 15 * screenScale;
      double clLayoutLoginBtnHeight_Portrait = 30 * screenScale;
      double clLayoutLoginBtnLeft_Portrait = 70 * screenScale;
      double clLayoutLoginBtnRight_Portrait = -70 * screenScale;

      double clLayoutAppPrivacyLeft_Portrait = 40 * screenScale;
      double clLayoutAppPrivacyRight_Portrait = -40 * screenScale;
      double clLayoutAppPrivacyBottom_Portrait = 0 * screenScale;
      double clLayoutAppPrivacyHeight_Portrait = 45 * screenScale;

      double clLayoutSloganLeft_Portrait = 0;
      double clLayoutSloganRight_Portrait = 0;
      double clLayoutSloganHeight_Portrait = 15 * screenScale;
      double clLayoutSloganBottom_Portrait = clLayoutAppPrivacyBottom_Portrait - clLayoutAppPrivacyHeight_Portrait;

      //横屏
      //窗口中心
      double clAuthWindowOrientationCenterX_Landscape = screenWidth_Landscape * 0.5;
      double clAuthWindowOrientationCenterY_Landscape = screenHeight_Landscape * 0.5;

      //窗口宽高
      double clAuthWindowOrientationWidth_Landscape = screenWidth_Portrait * 0.8; //窗口宽度为竖屏宽度的0.8;
      double clAuthWindowOrientationHeight_Landscape = clAuthWindowOrientationWidth_Landscape * 0.8; //窗口高度为窗口宽度的0.8

      double clLayoutLogoWidth_Landscape = 60 * screenScale;
      double clLayoutLogoHeight_Landscape = 60 * screenScale;
      double clLayoutLogoCenterX_Landscape = 0;
      double clLayoutLogoTop_Landscape = 25 * screenScale;

      double clLayoutPhoneCenterY_Landscape = -20 * screenScale;
      double clLayoutPhoneLeft_Landscape = 50 * screenScale;
      double clLayoutPhoneRight_Landscape = -50 * screenScale;
      double clLayoutPhoneHeight_Landscape = 20 * screenScale;

      double clLayoutLoginBtnCenterY_Landscape = clLayoutPhoneCenterY_Landscape + clLayoutPhoneHeight_Landscape * 0.5 *
          screenScale + 20 * screenScale + 15 * screenScale;
      double clLayoutLoginBtnHeight_Landscape = 30 * screenScale;
      double clLayoutLoginBtnLeft_Landscape = 70 * screenScale;
      double clLayoutLoginBtnRight_Landscape = -70 * screenScale;

      double clLayoutAppPrivacyLeft_Landscape = 40 * screenScale;
      double clLayoutAppPrivacyRight_Landscape = -40 * screenScale;
      double clLayoutAppPrivacyBottom_Landscape = 0 * screenScale;
      double clLayoutAppPrivacyHeight_Landscape = 45 * screenScale;

      double clLayoutSloganLeft_Landscape = 0;
      double clLayoutSloganRight_Landscape = 0;
      double clLayoutSloganHeight_Landscape = 15 * screenScale;
      double clLayoutSloganBottom_Landscape = clLayoutAppPrivacyBottom_Landscape - clLayoutAppPrivacyHeight_Landscape;

      this.ios_uiConfigure = {

        "clBackgroundImg": "assets/Img/eb9a0dae18491990a43fe02832d3cafa.jpg",

        "shouldAutorotate": true,
        /**支持方向
         * 如支持横竖屏，需同时设置 clOrientationLayOutPortrait 和 clOrientationLayOutLandscape
         * 0:UIInterfaceOrientationMaskPortrait
         * 1:UIInterfaceOrientationMaskLandscapeLeft
         * 2:UIInterfaceOrientationMaskLandscapeRight
         * 3:UIInterfaceOrientationMaskPortraitUpsideDown
         * 4:UIInterfaceOrientationMaskLandscape
         * 5:UIInterfaceOrientationMaskAll
         * 6:UIInterfaceOrientationMaskAllButUpsideDown
         * */
        "supportedInterfaceOrientations": 5,

        /**偏好方向
         * -1:UIInterfaceOrientationUnknown
         * 0:UIInterfaceOrientationPortrait
         * 1:UIInterfaceOrientationPortraitUpsideDown
         * 2:UIInterfaceOrientationLandscapeLeft
         * 3:UIInterfaceOrientationLandscapeRight
         * */
        //偏好方向默认Portrait preferredInterfaceOrientationForPresentation: Number(5),

        "clNavigationBackgroundClear": true, //导航栏透明
        "clNavigationBackBtnImage": "assets/Img/close-white.png", //返回按钮图片
        "clNavBackBtnAlimentRight": true, //返回按钮居右

        "clLogoImage": "assets/Img/logo_shanyan_text.png", //logo图片

        "clLoginBtnText": "本机号一键登录", //一键登录按钮文字
        "clLoginBtnTextColor": [1, 1, 1, 1.0], //rgba
        "clLoginBtnBgColor": [0.2, 0.8, 0.2, 1.0], //rgba
        "clLoginBtnTextFont": 15 * screenScale,
        "clLoginBtnCornerRadius": 10,
        "clLoginBtnBorderWidth": 0.5,
        "clLoginBtnBorderColor": [0.1, 0.8, 0.1, 1.0], //rgba

        "clPhoneNumberFont": 20.0 * screenScale,

        "clAuthTypeUseWindow": true,
        "clAuthWindowCornerRadius": 20,

        "clAppPrivacyColor": [
          [0.6, 0.6, 0.6, 1.0],
          [0, 1, 0, 1.0]
        ], //2 item,commomTextColor and appPrivacyTextColor
        "clAppPrivacyTextFont": 11 * screenScale,
        "clAppPrivacyTextAlignment": 0, //0: center 1: left 2: right
        "clAppPrivacyFirst": ["测试连接A", "https://www.baidu.com"], // 2 item, name and url
        "clAppPrivacySecond": ["测试连接B", "https://www.sina.com"], // 2 item, name and url

        "clCheckBoxVerticalAlignmentToAppPrivacyCenterY": true,
        "clCheckBoxSize": [30 * screenScale, 30 * screenScale], //2 item, width and height
        "clCheckBoxImageEdgeInsets": [2 * screenScale, 10 * screenScale, 13 * screenScale, 5 * screenScale], //4 item, top left bottom right
        "clCheckBoxUncheckedImage": "assets/Img/checkBoxNor.png",
        "clCheckBoxCheckedImage": "assets/Img/checkBoxSEL.png",

        "clLoadingSize": [50, 50], //2 item, width and height
        "clLoadingTintColor": [0.2, 0.8, 0.2, 1],
        "clLoadingBackgroundColor": [1, 1, 1, 1],
        "clLoadingCornerRadius": 5,

        //竖屏布局对象
        "clOrientationLayOutPortrait": {
          //窗口
          "clAuthWindowOrientationWidth": clAuthWindowOrientationWidth_Portrait,
          "clAuthWindowOrientationHeight": clAuthWindowOrientationHeight_Portrait,

          "clAuthWindowOrientationCenterX": clAuthWindowOrientationCenterX_Portrait,
          "clAuthWindowOrientationCenterY": clAuthWindowOrientationCenterY_Portrait,

          //控件
          "clLayoutLogoWidth": clLayoutLogoWidth_Portrait,
          "clLayoutLogoHeight": clLayoutLogoHeight_Portrait,
          "clLayoutLogoCenterX": clLayoutLogoCenterX_Portrait,
          "clLayoutLogoTop": clLayoutLogoTop_Portrait,

          "clLayoutPhoneCenterY": clLayoutPhoneCenterY_Portrait,
          "clLayoutPhoneHeight": clLayoutPhoneHeight_Portrait,
          "clLayoutPhoneLeft": clLayoutPhoneLeft_Portrait,
          "clLayoutPhoneRight": clLayoutPhoneRight_Portrait,

          "clLayoutLoginBtnCenterY": clLayoutLoginBtnCenterY_Portrait,
          "clLayoutLoginBtnHeight": clLayoutLoginBtnHeight_Portrait,
          "clLayoutLoginBtnLeft": clLayoutLoginBtnLeft_Portrait,
          "clLayoutLoginBtnRight": clLayoutLoginBtnRight_Portrait,

          "clLayoutAppPrivacyLeft": clLayoutAppPrivacyLeft_Portrait,
          "clLayoutAppPrivacyRight": clLayoutAppPrivacyRight_Portrait,
          "clLayoutAppPrivacyBottom": clLayoutAppPrivacyBottom_Portrait,
          "clLayoutAppPrivacyHeight": clLayoutAppPrivacyHeight_Portrait,

          "clLayoutSloganLeft": clLayoutSloganLeft_Portrait,
          "clLayoutSloganRight": clLayoutSloganRight_Portrait,
          "clLayoutSloganHeight": clLayoutSloganHeight_Portrait,
          "clLayoutSloganBottom": clLayoutSloganBottom_Portrait,
        },
        //横屏布局对象
        "clOrientationLayOutLandscape": {
          //窗口
          "clAuthWindowOrientationWidth": clAuthWindowOrientationWidth_Landscape,
          "clAuthWindowOrientationHeight": clAuthWindowOrientationHeight_Landscape,

          "clAuthWindowOrientationCenterX": clAuthWindowOrientationCenterX_Landscape,
          "clAuthWindowOrientationCenterY": clAuthWindowOrientationCenterY_Landscape,

          //控件
          "clLayoutLogoWidth": clLayoutLogoWidth_Landscape,
          "clLayoutLogoHeight": clLayoutLogoHeight_Landscape,
          "clLayoutLogoCenterX": clLayoutLogoCenterX_Landscape,
          "clLayoutLogoTop": clLayoutLogoTop_Landscape,

          "clLayoutPhoneCenterY": clLayoutPhoneCenterY_Landscape,
          "clLayoutPhoneHeight": clLayoutPhoneHeight_Landscape,
          "clLayoutPhoneLeft": clLayoutPhoneLeft_Landscape,
          "clLayoutPhoneRight": clLayoutPhoneRight_Landscape,

          "clLayoutLoginBtnCenterY": clLayoutLoginBtnCenterY_Landscape,
          "clLayoutLoginBtnHeight": clLayoutLoginBtnHeight_Landscape,
          "clLayoutLoginBtnLeft": clLayoutLoginBtnLeft_Landscape,
          "clLayoutLoginBtnRight": clLayoutLoginBtnRight_Landscape,

          "clLayoutAppPrivacyLeft": clLayoutAppPrivacyLeft_Landscape,
          "clLayoutAppPrivacyRight": clLayoutAppPrivacyRight_Landscape,
          "clLayoutAppPrivacyBottom": clLayoutAppPrivacyBottom_Landscape,
          "clLayoutAppPrivacyHeight": clLayoutAppPrivacyHeight_Landscape,

          "clLayoutSloganLeft": clLayoutSloganLeft_Landscape,
          "clLayoutSloganRight": clLayoutSloganRight_Landscape,
          "clLayoutSloganHeight": clLayoutSloganHeight_Landscape,
          "clLayoutSloganBottom": clLayoutSloganBottom_Landscape,
        },
      };

    }else if(Platform.isAndroid){
      ShanYanUIConfig shanYanUIConfig = ShanYanUIConfig();
      shanYanUIConfig.setLogBtnText = "免密登录";
      //shanYanUIConfig.setAuthBgGifPath = "test";
      //shanYanUIConfig.setFullScreen = true;
      shanYanUIConfig.setAppPrivacyOne = ["协议1", "https://baidu.com/"];
      shanYanUIConfig.setAppPrivacyTwo = ["协议2", "https://baidu.com/"];
      shanYanUIConfig.setAppPrivacyThree = ["协议3", "https://baidu.com/"];
      shanYanUIConfig.setPrivacyText = ["登录即同意", "、", "、", "和", "授权"];
      shanYanUIConfig.setDialogTheme = ["120", "150", "0", "0", "false"];
      shanYanUIConfig.setLogoWidth=108;
      shanYanUIConfig.setLogoHeight=45;
      shanYanUIConfig.setLogoHidden=false;
      shanYanUIConfig.setLogoOffsetY=10;
      shanYanUIConfig.setNumFieldOffsetY=60;
      shanYanUIConfig.setNumberSize=18;
      shanYanUIConfig.setLogBtnOffsetY=120;
      shanYanUIConfig.setLogBtnTextSize=15;
      shanYanUIConfig.setLogBtnWidth=250;
      shanYanUIConfig.setLogoHeight=40;
      shanYanUIConfig.setLogBtnOffsetY=130;
      shanYanUIConfig.setSloganHidden=true;

      //shanYanUIConfig.setLoadingView = "custom_loading_dialog";
      List<ShanYanCustomWidgetLayout> shanYanCustomWidgetLayout = [];
      String layout_name = "relative_item_view";
      ShanYanCustomWidgetLayout relativeLayoutWidget = ShanYanCustomWidgetLayout(
          layout_name, ShanYanCustomWidgetLayoutType.RelativeLayout);
      relativeLayoutWidget.top = 200;
      relativeLayoutWidget.widgetLayoutId = ["weixin", "qq", "weibo"];
      oneKeyLoginManager.addClikWidgetLayoutEventListener(
              (WidgetLayoutOnClickEvent widgetLayoutOnClickEvent) {
            Map map = widgetLayoutOnClickEvent.toMap();
            if ("weixin" == map[shanyan_widgetLayoutId]) {
              _toast("点击 微信");
            } else if ("qq" == map[shanyan_widgetLayoutId]) {
              _toast("点击 QQ");
            } else if ("weibo" == map[shanyan_widgetLayoutId]) {
              _toast("点击 微博");
            }
          });

      shanYanCustomWidgetLayout.add(relativeLayoutWidget);
      oneKeyLoginManager.setAuthThemeConfig(
          uiConfig: shanYanUIConfig,
          widgetLayout: shanYanCustomWidgetLayout);
    }
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
                            setAuthThemeConfig();
                          },
                          title: "授权页  沉浸样式"),
                      new Text("   "),
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
