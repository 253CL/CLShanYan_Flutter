# flutter接入文档

<a name="4okOO"></a>
# 配置
<a name="F1IgZ"></a>
## 创建应用

应用的创建流程及APPID的获取，请查看「[账号创建](http://flash.253.com/document/details?lid=292&cid=91&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档<br />**注意：如果应用有多个包名或签名不同的马甲包，须创建多个对应包名和签名的应用，否则马甲包将报包名或签名校验不通过。**<br />**
<a name="yiOft"></a>
## 快速体验demo

在 `/android/app/build.gradle` 中修改下列代码：<br />a.applicationId换成对应的测试包名<br />b.将签名配置改成您的签名配置

```
android: {
  ....
  defaultConfig {
    applicationId "替换成您应用的包名"
    ...
  signingConfigs {
    config {
       keyAlias '***'
       keyPassword '***' 
       storeFile file('../***.jks')
       storePassword '**'    }
}
  }    
}
```
<a name="75ec19c7"></a>
## 
<a name="MmlKp"></a>
## 使用

```
import 'package:shanyan/shanyan.dart';
```

<a name="oxzkQ"></a>
# API使用说明

<a name="64eeb036"></a>
## 1.初始化

使用一键登录功能前，必须先进行初始化操作。

调用示例

```java
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


<a name="43f0e755"></a>
## 2.预取号

- **建议在判断当前用户属于未登录状态时使用，****已登录状态用户请不要调用该方法**
- 建议在执行拉取授权登录页的方法前，提前一段时间调用预取号方法，中间最好有2-3秒的缓冲（因为预取号方法需要1~3s的时间取得临时凭证）
- **请勿频繁的多次调用、请勿与拉起授权登录页同时和之后调用。**
- **避免大量资源下载时调用，例如游戏中加载资源或者更新补丁的时候要顺序执行**



调用示例：

```java
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.getPhoneInfo().then((map) {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
    });

```

返回参数含义如下：<br />

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | Int | code为1022：成功；其他：失败 |
| result | String | 返回信息 |


<a name="c654fd45"></a>
## 3.拉起授权页

- 调用拉起授权页方法后将会调起运营商授权页面。**已登录状态请勿调用 。**
- **每次调用拉起授权页方法前均需先调用授权页配置方法，否则授权页可能会展示异常。**

调用示例：

```java
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



<a name="b57c3e07"></a>
## 4.销毁授权页
A.授权页面自动销毁<br />1.在授权登录页面，当用户主动点击左左上角返回按钮时，返回码为1011，SDK将自动销毁授权页；<br />2.安卓 SDK，当用户点击手机的硬件返回键（相当于取消登录），返回码为1011，SDK将自动销毁授权页<br />3.当用户设置一键登录或者其他自定义控件为自动销毁时，得到回调后，授权页面会自动销毁<br />
<br />B.授权页手动销毁<br />1.当设置一键登录为手动销毁时，点击授权页一键登录按钮成功获取token不会自动销毁授权页，**请务必在回调中处理完自己的逻辑后手动调用销毁授权页方法。**<br />2.当设置自定义控件为手动销毁时，**请务必在回调中处理完自己的逻辑后手动调用销毁授权页方法。**<br />**<br />调用示例

```java
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.finishAuthActivity();
```

<a name="tP7Yk"></a>
## 5.授权页点击事件监听

调用示例

```java
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
<a name="nyjv9"></a>
## 6.置换手机号
当一键登录外层code为1000时，您将获取到返回的参数，请将这些参数传递给后端开发人员，并参考「[服务端](https://flash.253.com/document/details?lid=300&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档来实现获取手机号码的步骤。

<a name="1e4a3243"></a>
# 授权页界面修改

<a name="33d30980"></a>
## 1.设计规范
![image.png](https://cdn.nlark.com/yuque/0/2019/png/245305/1565147589245-2bb0d035-834b-46ba-a772-6df77cc0536d.png#align=left&display=inline&height=1798&name=image.png&originHeight=1798&originWidth=2118&search=&size=1457987&status=done&width=2118)**注意：开发者不得通过任何技术手段，将授权页面的隐私栏、品牌露出内容隐藏、覆盖，对于接入闪验SDK并上线的应用，我方和运营商会对授权页面做审查，如果有出现未按要求设计授权页面，我方有权将应用的登录功能下线。**

<a name="9eed332c"></a>
## 2.授权页配置

调用该方法可实现对三网运营商授权页面个性化设计，**每次调用拉起授权页方法前必须先调用该方法**，否则授权界面会展示异常。（**三网界面配置内部实现逻辑不同，请务必使用移动、联通、电信卡分别测试三网界面**）

调用示例

```java
ShanYanUIConfig shanYanUIConfig = new ShanYanUIConfig();
    shanYanUIConfig.setLogBtnText = "免密登录";
    shanYanUIConfig.setAppPrivacyOne = ["协议1", "https://baidu.com/"];
    shanYanUIConfig.setAppPrivacyTwo = ["协议2", "https://baidu.com/"];
    shanYanUIConfig.setAppPrivacyThree = ["协议3", "https://baidu.com/"];
    shanYanUIConfig.setPrivacyText = ["登录即同意", "、", "、", "和", "授权"];
    shanYanUIConfig.setDialogTheme = ["120", "150", "0", "0", "false"];
```


ShanYanUIConfig.java配置元素说明<br />授权页背景配置三选一，支持图片，gif图，视频

```java
  String setAuthBGImgPath; //普通图片
  String setAuthBgGifPath; //GIF图片（只支持本地gif图，需要放置到drawable文件夹中）
  String setAuthBgVideoPath; //视频背景
```

授权页导航栏

```java
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

```java
  String setLogoImgPath; //设置logo图片
  int setLogoWidth; //设置logo宽度
  int setLogoHeight; //设置logo高度
  int setLogoOffsetY; //设置logo相对于标题栏下边缘y偏移
  int setLogoOffsetBottomY; //设置logo相对于屏幕底部y偏移
  bool setLogoHidden; //设置logo是否隐藏（true：隐藏；false：不隐藏）
  int setLogoOffsetX; //设置logo相对屏幕左侧X偏移

```

授权页号码栏

```java
  String setNumberColor; //设置号码栏字体颜色
  int setNumFieldOffsetY; //设置号码栏相对于标题栏下边缘y偏移
  int setNumFieldOffsetBottomY; //设置号码栏相对于屏幕底部y偏移
  int setNumFieldWidth; //设置号码栏宽度
  int setNumFieldHeight; //设置号码栏高度
  int setNumberSize; //设置号码栏字体大小
  int setNumFieldOffsetX; //设置号码栏相对屏幕左侧X偏移
```

授权页登录按钮

```java
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

```java
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

```java
  String setSloganTextColor; //设置slogan文字颜色
  int setSloganTextSize; //设置slogan文字字体大小
  int setSloganOffsetY; //设置slogan相对于标题栏下边缘y偏移
  bool setSloganHidden = false; //设置slogan是否隐藏（true：隐藏；false：不隐藏）
  int setSloganOffsetBottomY; //设置slogan相对屏幕底部Y偏移
  int setSloganOffsetX; //设置slogan相对屏幕左侧X偏移
```

授权页loading

```java
  String setLoadingView; //设置授权页点击一键登录自定义loading
```

授权页弹窗样式

```java
  List<String>setDialogTheme; //设置授权页为弹窗样式，包含5个参数：1.弹窗宽度 2.弹窗高度 3.弹窗X偏移量（以屏幕中心为原点） 4.弹窗Y偏移量（以屏幕中心为原点） 5.授权页弹窗是否贴于屏幕底部

```

**注意：**<br />**a.控件X偏移如果不设置默认居中。**

<a name="456d1eae"></a>
## 3.添加自定义控件

调用该方法可实现在授权页添加自定义控件。

调用示例
```java
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

```java
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
<a name="3924543b"></a>
# 四.本机认证

**注：本机认证同免密登录，需要初始化，本机认证、免密登录可共用初始化，两个功能同时使用时，只需调用一次初始化即可。**<br />**
<a name="SysXk"></a>
## 1.初始化

**同SDK使用说明-->初始化**<br />**
<a name="D0VdI"></a>
## 2.本机号校验

在初始化执行之后调用，本机号校验界面需自行实现，可以在多个需要校验的页面中调用。

调用示例：

```java
OneKeyLoginManager oneKeyLoginManager = new OneKeyLoginManager();
oneKeyLoginManager.startAuthentication(phoneNum: controllerPHone.text).then((map) {
        _code = map[shanyan_code];
        _result = map[shanyan_result];
        if (2000 == map[shanyan_code]) {
          _toast("本机认证获取token成功");
        }
    });
```

参数描述：

| **参数** | **类型** | **说明** |
| --- | --- | --- |
| phone（必填） | String | 需要校验的手机号 |


返回参数含义如下：<br />

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| code | int | code为2000：成功<br />其他：失败 |
| result | String | 返回信息 |


当外层code为2000时，result的返回为

```json
{
    "token":""
}
```

含义如下：

| **字段** | **类型** | **含义** |
| --- | --- | --- |
| token | String | 用来和后台校验手机号。一次有效。 |


**
<a name="uIxje"></a>
## 3.校验手机号

当本机号校验外层code为2000时，您将获取到返回的参数，请将这些参数传递给后端开发人员，并参考「[服务端](http://flash.253.com/document/details?lid=300&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」文档来实现校验本机号的步骤
<a name="OLuFp"></a>
# 五.返回码
该返回码为闪验SDK自身的返回码，请注意1003及1023错误内均含有运营商返回码，具体错误在碰到之后查阅「[返回码](http://flash.253.com/document/details?lid=301&cid=93&pc=28&pn=%25E9%2597%25AA%25E9%25AA%258CSDK)」

| 返回码 | 返回码描述 |
| :---: | :---: |
| 1000 | 一键登录成功，解析result，可得到网络请求参数 |
| 1001 | 运营商通道关闭 |
| 1002 | 运营商信息获取失败 |
| 1003 | 一键登录获取token失败 |
| 1007 | 网络请求失败 |
| 1011 | 点击返回，用户取消免密登录 |
| 1014 | SDK内部异常 |
| 1016 | APPID为空 |
| 1019 | 其他错误 |
| 1022 | 网络初始化、预取号成功 |
| 1023 | 预初始化失败 |
| 1031 | 请求过于频繁 |
| 1032 | 用户禁用 |
| 2000 | 本机号校验返回成功，解析result，可得到网络请求参数 |
| 2001 | 传入的手机号phone为空 |
| 2003 | 本机号校验返回失败 |
| 2020 | 非三大运营商 |


