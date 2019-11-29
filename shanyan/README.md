# Flutter 插件集成文档

<a name="FpCKu"></a>
# 创建应用

应用的创建流程及APPID的获取，请查看「[账号创建](http://flash.253.com/document/details?lid=292&cid=91&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档<br />**注意：如果应用有多个包名或签名不同的马甲包，须创建多个对应包名和签名的应用，否则马甲包将报包名或签名校验不通过。**


<a name="2tBGU"></a>
# Android 部分

<a name="khv3D"></a>
## 一、免密登录API使用说明
<a name="ANoDq"></a>
### 1.初始化

使用一键登录功能前，必须先进行初始化操作。

调用示例

```dart
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.init(
      appId: "您的创建应用时生成的appid",
    ).then((map) {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
    });
```

参数描述

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| appId | String | 闪验平台获取到的appId |


返回参数含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | Int | code为1022:成功；其他：失败 |
| result | String | 返回信息 |


<a name="8Cuhp"></a>
### 2.预取号

- **建议在判断当前用户属于未登录状态时使用，****已登录状态用户请不要调用该方法**
- 建议在执行拉取授权登录页的方法前，提前一段时间调用预取号方法，中间最好有2-3秒的缓冲（因为预取号方法需要1~3s的时间取得临时凭证）
- **请勿频繁的多次调用、请勿与拉起授权登录页同时和之后调用。**
- **避免大量资源下载时调用，例如游戏中加载资源或者更新补丁的时候要顺序执行**



调用示例：

```dart
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.getPhoneInfo().then((map) {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
    });

```

返回参数含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | Int | code为1022：成功；其他：失败 |
| result | String | 返回信息 |


<a name="jdF5H"></a>
### 3.拉起授权页

- 调用拉起授权页方法后将会调起运营商授权页面。**已登录状态请勿调用 。**
- **每次调用拉起授权页方法前均需先调用授权页配置方法，否则授权页可能会展示异常。**

调用示例：

```dart
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.openLoginAuth(
      isFinish: false,
    ).then((map) {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
    });
```

参数描述

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| isFinish | boolean  | 点击授权页一键登录按钮有回调时是否自动销毁授权页：<br />true：自动销毁<br />false:不自动销毁，开发者需主动调用销毁授权页方法进行授权页销毁操作  |


返回参数含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | int | code为1000：授权页成功拉起<br />其他：失败 |
| result | String | 返回信息 |



<a name="8a7vq"></a>
### 4.销毁授权页
A.授权页面自动销毁<br />1.在授权登录页面，当用户主动点击左左上角返回按钮时，返回码为1011，SDK将自动销毁授权页；<br />2.安卓 SDK，当用户点击手机的硬件返回键（相当于取消登录），返回码为1011，SDK将自动销毁授权页<br />3.当用户设置一键登录或者其他自定义控件为自动销毁时，得到回调后，授权页面会自动销毁<br />
<br />B.授权页手动销毁<br />1.当设置一键登录为手动销毁时，点击授权页一键登录按钮成功获取token不会自动销毁授权页，**请务必在回调中处理完自己的逻辑后手动调用销毁授权页方法。**<br />2.当设置自定义控件为手动销毁时，**请务必在回调中处理完自己的逻辑后手动调用销毁授权页方法。**<br />**<br />调用示例

```dart
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.finishAuthActivity();
```

<a name="WDkUt"></a>
### 5.授权页点击事件监听

调用示例

```dart
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.setOnClickPrivacyListener();//设置点击协议监听，不需要可以不写
oneKeyLoginManager.setAuthPageOnClickListener((AuthPageOnClickEvent authPageOnClickEvent) {
          Map map = authPageOnClickEvent.toMap();
            _code = map[shanyan_code];
            _result = map[shanyan_result];
        });
```

当code为1000

getOnClickPrivacyStatus(**int **code, String result,String operator)方法返回参数含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | Int | code为0：点击运营商协议<br />code为1：点击自定义协议1<br />code为2：点击自定义协议2<br />code为3：点击自定义协议3<br />code为1000：点击一键登录获取token成功<br />code为其他：点击一键登录获取token失败 |
| result | String | 协议名称 |

**
<a name="EOGka"></a>
### 6.置换手机号
当一键登录外层code为1000时，您将获取到返回的参数，请将这些参数传递给后端开发人员，并参考「[服务端](https://flash.253.com/document/details?lid=300&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档来实现获取手机号码的步骤。

<a name="uPVnk"></a>
### 7.授权页界面配置

调用该方法可实现对三网运营商授权页面个性化设计，**每次调用拉起授权页方法前必须先调用该方法**，否则授权界面会展示异常。（**三网界面配置内部实现逻辑不同，请务必使用移动、联通、电信卡分别测试三网界面**）

调用示例

```dart
ShanYanUIConfig shanYanUIConfig = new ShanYanUIConfig();
    shanYanUIConfig.setLogBtnText = "免密登录";
    shanYanUIConfig.setAppPrivacyOne = ["协议1", "https://baidu.com/"];
    shanYanUIConfig.setAppPrivacyTwo = ["协议2", "https://baidu.com/"];
    shanYanUIConfig.setAppPrivacyThree = ["协议3", "https://baidu.com/"];
    shanYanUIConfig.setPrivacyText = ["登录即同意", "、", "、", "和", "授权"];
    shanYanUIConfig.setDialogTheme = ["120", "150", "0", "0", "false"];
```


ShanYanUIConfig.java配置元素说明<br />授权页背景配置三选一，支持图片，gif图，视频

```dart
  String setAuthBGImgPath; //普通图片
  String setAuthBgGifPath; //GIF图片（只支持本地gif图，需要放置到drawable文件夹中）
  String setAuthBgVideoPath; //视频背景
```

授权页导航栏

```dart
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
```

授权页logo

```dart
  String setLogoImgPath; //设置logo图片
  int setLogoWidth; //设置logo宽度
  int setLogoHeight; //设置logo高度
  int setLogoOffsetY; //设置logo相对于标题栏下边缘y偏移
  int setLogoOffsetBottomY; //设置logo相对于屏幕底部y偏移
  bool setLogoHidden; //设置logo是否隐藏（true：隐藏；false：不隐藏）
  int setLogoOffsetX; //设置logo相对屏幕左侧X偏移

```

授权页号码栏

```dart
  String setNumberColor; //设置号码栏字体颜色
  int setNumFieldOffsetY; //设置号码栏相对于标题栏下边缘y偏移
  int setNumFieldOffsetBottomY; //设置号码栏相对于屏幕底部y偏移
  int setNumFieldWidth; //设置号码栏宽度
  int setNumFieldHeight; //设置号码栏高度
  int setNumberSize; //设置号码栏字体大小
  int setNumFieldOffsetX; //设置号码栏相对屏幕左侧X偏移
```

授权页登录按钮

```dart
  String setLogBtnText; //设置登录按钮文字
  String setLogBtnTextColor; //设置登录按钮文字颜色
  String setLogBtnImgPath; //设置授权登录按钮图片
  int setLogBtnOffsetY; //设置登录按钮相对于标题栏下边缘Y偏移
  int setLogBtnOffsetBottomY; //设置登录按钮相对于屏幕底部Y偏移
  int setLogBtnTextSize; //设置登录按钮字体大小
  int setLogBtnHeight; //设置登录按钮高度
  int setLogBtnWidth; //设置登录按钮宽度
  int setLogBtnOffsetX; //设置登录按钮相对屏幕左侧X偏移
```

授权页隐私栏

```dart
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
```

授权页slogan

```dart
  String setSloganTextColor; //设置slogan文字颜色
  int setSloganTextSize; //设置slogan文字字体大小
  int setSloganOffsetY; //设置slogan相对于标题栏下边缘y偏移
  bool setSloganHidden = false; //设置slogan是否隐藏（true：隐藏；false：不隐藏）
  int setSloganOffsetBottomY; //设置slogan相对屏幕底部Y偏移
  int setSloganOffsetX; //设置slogan相对屏幕左侧X偏移
```

授权页loading

```dart
  String setLoadingView; //设置授权页点击一键登录自定义loading
```

授权页弹窗样式

```dart
  List<String>setDialogTheme; //设置授权页为弹窗样式，包含5个参数：1.弹窗宽度 2.弹窗高度 3.弹窗X偏移量（以屏幕中心为原点） 4.弹窗Y偏移量（以屏幕中心为原点） 5.授权页弹窗是否贴于屏幕底部

```

**注意：**<br />**a.控件X偏移如果不设置默认居中。**

添加自定义控件

调用示例
```dart
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
```

参数说明

```dart
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
```

**注意：如果添加布局为自定义控件，监听实现请参考demo示例。**<br />**
<a name="D9qrI"></a>
## 二、本机认证API使用说明

**注：本机认证同免密登录，需要初始化，本机认证、免密登录可共用初始化，两个功能同时使用时，只需调用一次初始化即可。**<br />**
<a name="C1ZCW"></a>
### 1.初始化

**同免密登录初始化**<br />**
<a name="Lqzq4"></a>
### 2.本机号校验

在初始化执行之后调用，本机号校验界面需自行实现，可以在多个需要校验的页面中调用。

调用示例：

```dart
//闪验SDK 本机号校验获取token (Android+iOS)
Future<Map<dynamic, dynamic>> startAuthentication() async {
  return await _channel.invokeMethod("startAuthentication");
}
```

参数描述：

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| phone（必填） | String | 需要校验的手机号 |


返回参数含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | int | code为2000：成功<br />其他：失败 |
| result | String | 返回信息 |


当外层code为2000时，result的返回为

```dart
{
    "token":""
}
```

含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| token | String | 用来和后台校验手机号。一次有效。 |


**
<a name="ApxrD"></a>
### 3.校验手机号

当本机号校验外层code为2000时，您将获取到返回的参数，请将这些参数传递给后端开发人员，并参考「[服务端](http://flash.253.com/document/details?lid=300&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档来实现校验本机号的步骤
<a name="dCHBW"></a>
## 三、返回码
该返回码为闪验SDK自身的返回码，请注意1003及1023错误内均含有运营商返回码，具体错误在碰到之后查阅「[返回码](http://flash.253.com/document/details?lid=301&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」

<a name="dzDcW"></a>
# iOS部分

<a name="kqt9L"></a>
## 前置条件

- 闪验SDK支持Xcode 9.4.1，iOS8.0+及以上版本。
- 闪验SDK支持中国移动、联通、电信4G的取号能力。
- 闪验SDK支持网络环境为

a.纯数据网络<br />b.数据网络与wifi网络双开

- 对于双卡手机，闪验SDK取当前流量卡号

<a name="ZDrFk"></a>
## 快速体验示例Demo
注：需运行到真机，安装SIM卡，打开手机流量开关，允许网络权限

1. 到闪验官网申请创建应用，提供包名包签名/bundleID，得到对应的appID/appKey
1. 搜索初始化方法shanyan.init,将appID换成自己的appid（appid安卓/iOS不同，分别与包名包签名/bundleID绑定）
1. 用Xcode打开项目工程 (example->ios->Runner.xcworkspace),设置好BundleID,选择开发者账号
1. androidStudio打开example工程，选择iPhone真机设备，运行或Debug

<a name="xu4nA"></a>
## 一、免密登录API使用说明
<a name="PXJUG"></a>
### 1.初始化

```dart
//模块加载
final OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();

//闪验SDK 初始化(Android+iOS)
Future<Map<dynamic, dynamic>> init({String appId}) async {
  _channel.setMethodCallHandler(_handlerMethod);
  return await _channel.invokeMethod("init", {"appId": appId});
}
```

<br />参数描述

|  | 参数 | 是否必填 | 类型 | 说明 |
| :---: | :---: | :---: | :---: | :---: |
| 输入 | appId | **必填** | String | 闪验appID |


<br />**返回初始化回调:Future<Map<dynamic, dynamic>>, code为1000成功，其他失败，result为错误纯文本或错误Json字符串**

**接口作用**<br />初始化SDK :传入用户的appID,获取本机运营商,读取缓存,获取运营商配置,初始化SDK<br />
<br />**使用场景**

- 建议在app启动时调用
- 必须在一键登录前至少调用一次
- 只需调用一次，多次调用不会多次初始化，与一次调用效果一致

**请求示例代码**

```dart
String appId;
if (Platform.isIOS){
  appId = "xxxx";
}else if(Platform.isAndroid){
  appId = "bbbbb";
}
//闪验SDK 初始化
oneKeyLoginManager
    .init(
  appId: appId,
).then((map) {
  _code = map[shanyan_code];
  _result = map[shanyan_result];
  _content = " code===" + _code.toString() + "\n result===" + _result;
  if (1000 == map[shanyan_code]) {
    //初始化成功
  } else {
    //初始化失败
  }
});
```
<a name="dVhPn"></a>
### 
<a name="SwNkr"></a>
### 2.预取号

```dart
/**
 * 预取号（获取临时凭证）
 * 建议在判断当前用户属于未登录状态时使用，已登录状态用户不需要调用该方法
 */
//闪验SDK 预取号(Android+iOS)
Future<Map<dynamic, dynamic>> getPhoneInfo() async {
  return await _channel.invokeMethod("getPhoneInfo");
}
```

<br />**返回**预取号**回调:Future<Map<dynamic, dynamic>>, code为1022成功，其他失败，result为错误纯文本或错误Json字符串**<br />**<br />**接口作用**<br />**电信、联通、移动预取号** :初始化成功后，如果当前为电信/联通/移动，将调用预取号，可以提前获知当前用户的手机网络环境是否符合一键登录的使用条件，成功后将得到用于一键登录使用的临时凭证，默认的凭证有效期10min(电信)/30min(联通)/60min(移动)。<br />**使用场景**

- 建议在执行一键登录的方法前，提前一段时间调用此方法，比如调一键登录的vc的onLoad中，或者rootVC的rootVC中，或者app启动后，此调用将有助于提高闪验拉起授权页的速度和成功率
- 不建议调用后立即调用拉起授权页方法（此方法是异步）
- 此方法需要1~2s的时间取得临时凭证，因此也不建议和拉起授权页方法一起串行调用
- 不建议频繁的多次调用和在拉起授权页后调用
- **建议在判断当前用户属于未登录状态时使用，已登录状态用户请不要调用该方法**


<br />**请求示例代码**

```dart

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
```
<a name="oSi4V"></a>
### 
<a name="VrsW2"></a>
### 3.拉起授权页

```dart
//openLoginAuthListener:调起授权页回调
Future<Map<dynamic, dynamic>> openLoginAuthListener() async{
return await _channel.invokeMethod("openLoginAuthListener");
}    
//oneKeyLoginListener:调起授权页成功，后续回调    
Future<Map<dynamic, dynamic>> oneKeyLoginListener() async{
return await _channel.invokeMethod("oneKeyLoginListener");
}
//调起授权页
Future<void> quickAuthLoginWithConfigure(Map configure){
_channel.invokeMethod("quickAuthLoginWithConfigure",configure);
}
```

**返回回调均为:Future<Map<dynamic, dynamic>>, code为1000成功，其他失败，result为错误纯文本或错误Json字符串**<br />**<br />参数描述

| 参数 | 类型 | 说明 |
| :---: | :---: | :---: |
| clUIConfigure **必填** | CLUIConfigure | 授权页控件属性配置对象 |
| openLoginAuthListener**选填** | function | 拉起授权页的回调，拉起页面成功失败均触发 |
| oneKeyLoginListener **必填** | function | **一键登录回调，用于接收一键登录的结果，点一键登录成功失败均触发，点自带的返回按钮也触发** |

使用场景

- 用户进行一键登录操作时，调用一键登录方法，如果初始化成功，SDK将会拉起授权页面，用户授权后，SDK将返回取号 token给到应用客户端。
- 可以在多处调用
- 需在调用预初始化方法之后调用

一键登录逻辑说明

- 存在调用预初始化时获取的临时凭证，调用一键登录方法将立即拉起授权页面
- openLoginAuthListener 拉起授权页监听回调，拉起成功或失败均触发
- 不存在临时凭证或临时凭证过期时(临时凭证有效期电信10min、联通30min、移动60min)，调用一键登录方法，将有一个很短的时延，待取号成功后拉起授权页面
- 取号失败时，返回失败

请求示例代码

```dart
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
          _content = " code===" + _code.toString() + "\n result===" + _result;
        });
      });
      //调起授权页
      oneKeyLoginManager.quickAuthLoginWithConfigure(this.ios_uiConfigure);

    }
```

一键登录 `oneKeyLoginListenerResult:`正确返回示例

```json
{
  "result":
    {
      "token":"A2-7NA_jWQuN0XsJsZQOY8BtvdKtrhNK9QStebzzyzgh7ElebpB8xGy3rapp4yyxX8-VEVgMhiB3wO4P0PnCZNjtPAZO9KfeODdYxhgn5Qn8vnxOvgk4_Ov_39d56-v1p87-IcFHKlji4nhvCd1VmrxOSHx6KB6i6lZqFYqGgcbKfpG-yaGL6pcY4T9mbrtsOpbUhrdamE7eA1KaruyOdkL1SThGJZt_-8imf91EyrXckg="
    },
  "code":1000
}
```


<a name="z1irV"></a>
### 4.销毁授权页
1.点击授权页一键登录按钮成功获取token不会自动销毁授权页，**请务必在回调中处理完自己的逻辑后手动调用销毁授权页方法。**<br />2.当设置自定义控件为手动销毁时，**请务必在回调中处理完自己的逻辑后手动调用销毁授权页方法。**<br />**<br />调用示例

```dart
//关闭授权页
Future<void> finishAuthControllerCompletion() async{
  return await _channel.invokeMethod("finishAuthControllerCompletion");
}
```

<a name="EX6Se"></a>
### 5.置换手机号
当一键登录oneKeyLoginListenerResult 回调code为1000时，您将获取到返回的参数，请将这些参数传递给后端开发人员，并参考「[服务端](https://flash.253.com/document/details?lid=300&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档来实现获取手机号码的步骤。

<a name="juQcf"></a>
### 6.授权页界面配置

调用该方法可实现对三网运营商授权页面个性化设计。（**三网界面配置内部实现逻辑不同，请务必使用移动、联通、电信卡分别测试三网界面**）

调用示例

<a name="kcUOA"></a>
#### 简单竖屏全屏模式
```dart
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
      }
}
```

<a name="MJQFu"></a>
#### 横竖屏+弹窗+自动旋转模式

```dart
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
```


**注：授权页基本控件均支持上、下、左、右、宽、高、水平中心、竖直中心布局设置，布局通过布局对象设置**<br />**

| 配置字段名 | 类型 | 类型说明 | 描述 |
| --- | --- | --- | --- |
| clBackgroundImg | String | 图片路径 | 授权页-背景图片 |
| <br /> |  |  |  |
| clNavigationBarHidden | Bool | true/false | 导航栏 是否隐藏 |
| clNavigationBackgroundClear | Bool | true/false | 导航栏 背景透明 |
| clNavigationBackBtnImage | String | 图片路径 | 导航栏左侧返回按钮图片 |
| clNavigationBackBtnHidden | Bool | true/false | 导航栏自带返回按钮隐藏 |
| clNavBackBtnAlimentRight | Bool | true/false | 自带返回(关闭)按钮位置居右 |
| clNavigationBottomLineHidden | Bool | true/false | 导航栏分割线 是否隐藏 |
| clNavigationTintColor | Array | [r,g,b,a] | 导航栏 文字颜色 |
| clNavigationBarTintColor | Array | [r,g,b,a] | 导航栏 背景色 |
| clNavigationBackgroundImage | String | 图片路径 | 导航栏 背景图片 |
| clNavigationShadowImage | String | 图片路径 | 导航栏 导航栏底部分割线（图片 |
| clNavigationBarStyle | Number | 枚举值 | UIBarStyleBlack |
| <br /> |  |  |  |
| clLogoImage | String | 图片路径 | LOGO图片 |
| clLogoCornerRadius | Number | float | LOGO图片 |
| clLogoHiden | Bool | true/false | LOGO显隐 |
|  |  |  |  |
| clPhoneNumberColor | Array | [r,g,b,a] | 手机号颜色 |
| clPhoneNumberFont | Number | float | 手机号字体 |
| clPhoneNumberTextAlignment | Number | 枚举值 | 手机号对齐方式 |
|  |  |  |  |
| clLoginBtnText | String | text | 按一键登录钮文字 |
| clLoginBtnTextColor | Array | [r,g,b,a] | 一键登录按钮文字颜色 |
| clLoginBtnBgColor | Array | [r,g,b,a] | 一键登录按钮背景颜色 |
| clLoginBtnTextFont | Number | float | 一键登录按钮文字字体 |
| clLoginBtnNormalBgImage | String | 图片路径 | 一键登录按钮背景图片 |
| clLoginBtnHightLightBgImage | String | 图片路径 | 一键登录按钮背景高亮图片 |
| clLoginBtnBorderColor | Array | [r,g,b,a] | 一键登录按钮边框颜色 |
| clLoginBtnCornerRadius | Number | float | 一键登录按钮圆角 |
| clLoginBtnBorderWidth | Number | float | 一键登录按钮边框 |
|  |  |  |  |
| clAppPrivacyColor | Array | [[r,g,b,a],[r,g,b,a]] | 隐私条款名称颜色：[基础文字颜色rgba,款颜色rgba] eg.[[1,0,1,1],[1,0.8,0.8,1]] |
| clAppPrivacyTextFont | Number | float | 隐私条款文字字体 |
| clAppPrivacyTextAlignment | Number | 枚举值 | 隐私条款文字对齐方式 |
| clAppPrivacyPunctuationMarks | Bool | true/false | 运营商隐私条款书名号 |
| clAppPrivacyLineSpacing | Number | float | 多行时行距 |
| clAppPrivacyNeedSizeToFit | Bool | true/false | 是否需要sizeToFit，设置后与宽高约束的冲突请自行考虑 |
| clAppPrivacyAbbreviatedName | String | text | 隐私条款--APP名称简写 默认取CFBundledisplayname 设置描述文本四后此属性无效 |
| clAppPrivacyFirst | Array | [name,url] | 隐私条款一:需同时设置Name和UrlString |
| clAppPrivacySecond | Array | [name,url] | 隐私条款二:需同时设置Name和UrlString |
| clAppPrivacyNormalDesTextFirst | String | text | 描述文本一 default:"同意" |
| clAppPrivacyNormalDesTextSecond | String | text | 描述文本二 default:"和" |
| clAppPrivacyNormalDesTextThird | String | text | 描述文本三 default:"、" |
| clAppPrivacyNormalDesTextFourth | String | text | 描述文本四 default: "并授权AppName使用认证服务" |
| clAppPrivacyWebBackBtnImage | String | 图片路径 | 隐私协议WEB页面导航返回按钮图片 |
|  |  |  |  |
| clSloganTextFont | Number | float | 运营商品牌标签文字字体 |
| clSloganTextColor | Array | [r,g,b,a] | 运营商品牌标签文字颜色 |
| clSlogaTextAlignment | Number | 枚举值 | 运营商品牌标签文字对齐方式 |
|  |  |  |  |
| clCheckBoxHidden | Bool | true/false | 协议勾选框 |
| clCheckBoxValue | Bool | true/false | 协议勾选框默认值（默认不选中 |
| clCheckBoxSize | Array | [width,height] | 协议勾选框 尺寸 |
| clCheckBoxImageEdgeInsets | Array | [top,left,bottom,right] | 协议勾选框 UIButton.image图片缩进 |
| clCheckBoxVerticalAlignmentToAppPrivacyTop | Bool | true/false | 协议勾选框 设置CheckBox顶部与隐私协议控件顶部对齐 |
| clCheckBoxVerticalAlignmentToAppPrivacyCenterY | Bool | true/false | 协议勾选框 设置CheckBox顶部与隐私协议控件竖向中心对齐 |
| clCheckBoxUncheckedImage | String | 图片路径 | 协议勾选框 非选中状态图片 |
| clCheckBoxCheckedImage | String | 图片路径 | 协议勾选框 选中状态图片 |
|  |  |  |  |
| clLoadingSize | Array | [width,height] | Loading 大小 |
| clLoadingCornerRadius | Number | float | Loading 圆角 |
| clLoadingBackgroundColor | Array | [r,g,b,a] | Loading 背景色 |
| clLoadingTintColor | Array | [r,g,b,a] | Loading Indicator渲染色 |
|  |  |  |  |
| shouldAutorotate | Bool | true/false | 是否支持自动旋转 |
| supportedInterfaceOrientations | Number | 枚举值 | 支持方向 |
| preferredInterfaceOrientationForPresentation | Number | 枚举值 | 默认方向 |
|  |  |  |  |
| clAuthTypeUseWindow | Bool | true/false | 以窗口方式显示 default is NO |
| clAuthWindowCornerRadius | Number | float | 窗口圆角 |
| clAuthWindowModalTransitionStyle | Number | 枚举值 | 弹出方式 |
|  |  |  |  |
| clOrientationLayOutPortrait | Object | CLOrientationLayOut | 布局类（竖屏） |
| clOrientationLayOutLandscape | Object | CLOrientationLayOut | 布局类（横屏） |



**布局类：****CLOrientationLayOut**:

| 配置字段名 | 类型 |
| --- | --- |
| **LOGO图片** |  |
| clLayoutLogoLeft | Number |
| clLayoutLogoTop | Number |
| clLayoutLogoRight | Number |
| clLayoutLogoBottom | Number |
| clLayoutLogoWidth | Number |
| clLayoutLogoHeight | Number |
| clLayoutLogoCenterX | Number |
| clLayoutLogoCenterY | Number |
|  |  |
| **手机号显示控件** |  |
| clLayoutPhoneLeft | Number |
| clLayoutPhoneTop | Number |
| clLayoutPhoneRight | Number |
| clLayoutPhoneBottom | Number |
| clLayoutPhoneWidth | Number |
| clLayoutPhoneHeight | Number |
| clLayoutPhoneCenterX | Number |
| clLayoutPhoneCenterY | Number |
|  |  |
| **一键登录授权按钮  【不得隐藏】** |  |
| clLayoutLoginBtnLeft | Number |
| clLayoutLoginBtnTop | Number |
| clLayoutLoginBtnRight | Number |
| clLayoutLoginBtnBottom | Number |
| clLayoutLoginBtnWidth | Number |
| clLayoutLoginBtnHeight | Number |
| clLayoutLoginBtnCenterX | Number |
| clLayoutLoginBtnCenterY | Number |
|  |  |
| **隐私条款Privacy【运营商隐私条款 不得隐藏， 用户条款不限制】** |  |
| clLayoutAppPrivacyLeft | Number |
| clLayoutAppPrivacyTop | Number |
| clLayoutAppPrivacyRight | Number |
| clLayoutAppPrivacyBottom | Number |
| clLayoutAppPrivacyWidth | Number |
| clLayoutAppPrivacyHeight | Number |
| clLayoutAppPrivacyCenterX | Number |
| clLayoutAppPrivacyCenterY | Number |
|  |  |
| **运营商品牌标签："认证服务由中国移动/联通/电信提供** |  |
| clLayoutSloganLeft | Number |
| clLayoutSloganTop | Number |
| clLayoutSloganRight | Number |
| clLayoutSloganBottom | Number |
| clLayoutSloganWidth | Number |
| clLayoutSloganHeight | Number |
| clLayoutSloganCenterX | Number |
| clLayoutSloganCenterY | Number |
|  |  |
| **窗口模式** |  |
| 窗口中心 |  |
| clAuthWindowOrientationCenter | Number |
| 窗口左上角 |  |
| clAuthWindowOrientationOrigin | Number |
| 窗口大小：宽 |  |
| clAuthWindowOrientationWidth | Number |
| 窗口大小：高 |  |
| clAuthWindowOrientationHeight | Number |

<a name="Xqpeo"></a>
#### 
<a name="GEw0w"></a>
#### 自定义控件 
`widgets`：自定义控件允许自定义导航栏左侧和右侧按钮，将替换sdk自带的返回按钮。允许添加控件到授权页上。

调用示例

```dart
this.ios_uiConfigure = 
{
  clBackgroundImg: "static/a.jpg",
  clOrientationLayOutPortrait: {
    ...
  }
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
  }

 //设置自定义控件点击回调,返回信息带有widgetId
  oneKeyLoginManager.setCustomInterface().then((map) {
    setState(() {
      _content = "自定义控件点击:" + map.toString();
    });
  });


```


| **widget** |  |  |
| :--- | --- | --- |
| **控件通用属性** |  |  |
| widgetId | String | 字符标记 |
| type | String | 自定义控件类型：**Button**：按钮，**ImageView**:图片 **TextView**:文本 |
| backgroundColor | Array | 控件背景色[r,g,b,a] |
| cornerRadius | Number | 圆角，设置圆角时请设置masksToBounds:true |
| masksToBounds | Bool | 圆角相关,设置圆角时请设置true |
|  |  |  |
| **布局相关属性 通用** (相对授权页，全屏，从左至右，从上至下距离为正值，反之为负值) |  |  |
| clLayoutLeft | Number | 控件与授权页左侧距离 |
| clLayoutTop | Number | 控件与授权页顶部距离 |
| clLayoutRight | Number | 控件与授权页右侧距离，一般为负值 |
| clLayoutBottom | Number | 控件与授权页底部距离，一般为负值 |
| clLayoutWidth | Number | 控件宽度 |
| clLayoutHeight | Number | 控件高度 |
| clLayoutCenterX | Number | 控件与授权页水平中心偏移量，0:水平居中，正值:中心向右偏移，负值:中心向左偏移 |
| clLayoutCenterY | Number | 控件与授权页垂直中心偏移量，0:垂直居中，正值:中心向下偏移，负值:中心向上偏移 |
|  |  |  |
| **Button独有属性** |  |  |
| navPosition | String | 按钮位置，navleft:添加到导航栏左侧 ，navright:添加到导航栏右侧，不设置默认添加到授权页上，当设置为导航栏控件时，仅宽高可设置，位置固定在导航栏左右标准位置 |
| textContent | String | 文字 String |
| textFont | Number | 字体大小 |
| textColor | Array | 文字颜色[r,g,b,a] |
| image | String | 按钮左侧图片，非背景图，传图片路径 |
| isFinish | Bool | 点击后自动关闭授权页 |
|  |  |  |
| **TextView独有属性** |  |  |
| textContent | String | 文字 String |
| textFont | Number | 字体大小 |
| textColor | Array | 文字颜色[r,g,b,a] |
| numberOfLines | Number | 行数：默认单行， 0:无限，自动换行，其他：指定行数 |
| textAlignment | Number | 对齐方式，默认居左， 0: center 1: left 2: right  |
|  |  |  |
| **ImageView独有属性** |  |  |
| image | String | 背景图，传图片路径 |



<a name="5Rada"></a>
## 二、本机认证API使用说明

**注：本机认证、免密登录可共用初始化，两个功能同时使用时，只需调用一次初始化即可。**<br />**
<a name="EWiKe"></a>
### 1.初始化

**同免密登录初始化**<br />**
<a name="AUVqT"></a>
### 2.本机号校验

在初始化执行之后调用，本机号校验界面需自行实现，可以在多个需要校验的页面中调用。

调用示例：

```dart
//闪验SDK 本机号校验获取token (Android+iOS)
Future<Map<dynamic, dynamic>> startAuthentication() async {
  return await _channel.invokeMethod("startAuthentication");
}
```

**返回**预取号**回调:Future<Map<dynamic, dynamic>>, code为****2000****成功，其他失败，result为错误纯文本或错误Json字符串**

当result.errorCode不为空时，返回为

```json
{
  "data":
    {
      "token":"A2-7NA_jWQuN0XsJsZQOY8BtvdKtrhNK9QStebzzyzgh7ElebpB8xGy3rapp4yyxX8-VEVgMhiB3wO4P0PnCZNjtPAZO9KfeODdYxhgn5Qn8vnxOvgk4_Ov_39d56-v1p87-IcFHKlji4nhvCd1VmrxOSHx6KB6i6lZqFYqGgcbKfpG-yaGL6pcY4T9mbrtsOpbUhrdamE7eA1KaruyOdkL1SThGJZt_-8imf91EyrXckg="
    },
  "code":2000
}
```

含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| token | String | 用来和后台校验手机号。一次有效。 |

**
<a name="0vPly"></a>
### 3.校验手机号

当本机号校验获取到token时，请将token传递给后端开发人员，并参考「[服务端](http://flash.253.com/document/details?lid=300&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档来实现校验本机号的步骤
<a name="U2y5m"></a>
### 
<a name="N0EDv"></a>
## 三、返回码

| 外层返回码 | 返回码描述 |
| --- | --- |
| 1000 | 一键登录成功，解析result，可得到网络请求参数 |
| 1011 | 用户取消免密登录（点击返回按钮） |
| 1001 | SDK初始化失败 |
| 1023 | 预取号/取号失败 |
| 1003 | 拉起授权页失败/一键登录失败/获取token失败 |
| 1008 | 未开启移动网络 |
| 1009 | 未检测/识别到sim卡 |
| 其他 | 其他错误 |

该返回码为闪验SDK自身的返回码，iOS返回码仅供参考，不建议用于代码逻辑判断，请注意1003及1023错误内均含有运营商返回码，具体错误在碰到之后查阅「[返回码](http://flash.253.com/document/details?lid=301&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」

