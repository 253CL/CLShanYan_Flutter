import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shanyan/shanyan.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';

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

  final OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initListener();
    initPlatformState();
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

  Future<void> initPlatformState() async {
    //闪验SDK 初始化
    oneKeyLoginManager
        .init(
      appId: "loXN4jDs",
    )
        .then((map) {
      setState(() {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
        _content = " code===" + _code.toString() + "\n result===" + _result;
      });
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
    });
  }

  Future<void> openLoginAuthPlatformState() async {
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

  Future<void> startAuthenticationState() async {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(controllerPHone.text);
    if (controllerPHone.text == null || controllerPHone.text == "") {
      setState(() {
        _result = "手机号码不能为空";
        _content = " code===0" + "\n result===" + _result;
      });
      _toast("手机号码不能为空");
      return;
    } else if (!matched) {
      setState(() {
        _result = "请输入正确的手机号";
        _content = " code===0" + "\n result===" + _result;
      });
      _toast("请输入正确的手机号");
      return;
    }
    //闪验SDK 本机认证获取token
    oneKeyLoginManager
        .startAuthentication(phoneNum: controllerPHone.text)
        .then((map) {
      setState(() {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
        _content = " code===" + _code.toString() + "\n result===" + _result;
        if (2000 == map[shanyan_code]) {
          _toast("本机认证获取token成功");
        }
      });
    });
  }

  void setAuthThemeConfig() {
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
    setState(() {
      _content = " code===1000" + "\n result===界面配置成功";
    });
  }

  void setAuthPopupThemeConfig() {
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
    setState(() {
      _content = " code===1000" + "\n result===界面配置成功";
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
