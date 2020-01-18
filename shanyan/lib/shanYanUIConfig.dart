/*
* 闪验SDK 授权页UI 配置类
* */

import 'package:json_annotation/json_annotation.dart';
part 'shanYanUIConfig.g.dart';

/// 修改UI属性后，需删除shanyan.g.dart,再执行`flutter packages pub run build_runner build`，会生成新的 shanyan.g.dart; 运行 ` flutter packages pub run build_runner clean ` 清空文件

@JsonSerializable(explicitToJson: true)
class ShanYanUIConfig {

  ShanYanUIConfigIOS _ios; //iOS
  // ignore: unnecessary_getters_setters
  set ios(ShanYanUIConfigIOS ios) => _ios;
  // ignore: unnecessary_getters_setters
  ShanYanUIConfigIOS get ios {
    if (_ios == null) {
      _ios = new ShanYanUIConfigIOS();
    }
    return _ios;
  }

  ShanYanUIConfigAndroid _androidPortrait ; //Android竖屏
  ShanYanUIConfigAndroid _androidLandscape ; //Android横屏

  // ignore: unnecessary_getters_setters,
  set androidPortrait(ShanYanUIConfigAndroid androidPortrait) => _androidPortrait;
  // ignore: unnecessary_getters_setters
  ShanYanUIConfigAndroid get androidPortrait {
    if (_androidPortrait == null) {
      _androidPortrait = new ShanYanUIConfigAndroid();
    }
    return _androidPortrait;
  }

  // ignore: unnecessary_getters_setters
  set androidLandscape(ShanYanUIConfigAndroid androidLandscape) => _androidLandscape;
  // ignore: unnecessary_getters_setters
  ShanYanUIConfigAndroid get androidLandscape {
    if (_androidLandscape == null) {
      _androidLandscape = new ShanYanUIConfigAndroid();
    }
    return _androidLandscape;
  }


  ShanYanUIConfig();

  //反序列化
  factory ShanYanUIConfig.fromJson(Map<String, dynamic> json) => _$ShanYanUIConfigFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$ShanYanUIConfigToJson(this);
}

/**
 * -class ShanYanUIConfig {
//    -  bool isFinish; //是否自动销毁
//    -  // 授权页背景
//    -  String setAuthBGImgPath; //普通图片
    -  String setAuthBgGifPath; //GIF图片（只支持本地gif图，需要放置到drawable文件夹中）
    -
    -  String setAuthBgVideoPath; //视频背景
    -
    -  //授权页 状态栏
    -  String setStatusBarColor; //设置状态栏背景颜色
    -  bool setLightColor; //设置状态栏字体颜色是否为白色

//    -  bool setStatusBarHidden; //设置状态栏是否隐藏

    -  bool setVirtualKeyTransparent; //设置虚拟键是否透明
    -
    -  //授权页 导航栏
    -  bool setFullScreen; //设置是否全屏显示（true：全屏；false：不全屏）默认不全屏
    -  String setNavColor; //设置导航栏背景颜色
    -  String setNavText; //设置导航栏标题文字
    -  String setNavTextColor; //设置导航栏标题文字颜色
    -  int setNavTextSize; //设置导航栏标题文字大小
    -  String setNavReturnImgPath; //设置导航栏返回按钮图标
    -  bool setNavReturnImgHidden = false; //设置导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）
    -  int setNavReturnBtnWidth; //设置导航栏返回按钮宽度
    -  int setNavReturnBtnHeight; //设置导航栏返回按钮高度
    -  int setNavReturnBtnOffsetRightX; //设置导航栏返回按钮距离屏幕右侧X偏移
    -  int setNavReturnBtnOffsetX; //设置导航栏返回按钮距离屏幕左侧X偏移
    -  int setNavReturnBtnOffsetY; //设置导航栏返回按钮距离屏幕上侧Y偏移
    -  bool setAuthNavHidden; //设置导航栏是否隐藏（true：隐藏；false：不隐藏）
    -  bool setAuthNavTransparent; //设置导航栏是否透明（true：透明；false：不透明）
    -  bool setNavTextBold; //设置导航栏字体是否加粗（true：加粗；false：不加粗）

    -  // 授权页logo
    -  String setLogoImgPath; //设置logo图片
    -  int setLogoWidth; //设置logo宽度
    -  int setLogoHeight; //设置logo高度
    -  int setLogoOffsetY; //设置logo相对于标题栏下边缘y偏移
    -  int setLogoOffsetBottomY; //设置logo相对于屏幕底部y偏移
    -  bool setLogoHidden; //设置logo是否隐藏（true：隐藏；false：不隐藏）
    -  int setLogoOffsetX; //设置logo相对屏幕左侧X偏移
    +//  final ShanYanEventHandlers _instance =  ShanYanEventHandlers._internal();

    -  // 授权页 号码栏
    -  String setNumberColor; //设置号码栏字体颜色
    -  int setNumFieldOffsetY; //设置号码栏相对于标题栏下边缘y偏移
    -  int setNumFieldOffsetBottomY; //设置号码栏相对于屏幕底部y偏移
    -  int setNumFieldWidth; //设置号码栏宽度
    -  int setNumFieldHeight; //设置号码栏高度
    -  int setNumberSize; //设置号码栏字体大小
    -  int setNumFieldOffsetX; //设置号码栏相对屏幕左侧X偏移
    -  bool setNumberBold; //设置号码栏字体是否加粗（true：加粗；false：不加粗）
    +//  ShanYanEventHandlers._internal();

    -  //授权页 登录按钮
    -  String setLogBtnText; //设置登录按钮文字
    -  String setLogBtnTextColor; //设置登录按钮文字颜色
    -  String setLogBtnImgPath; //设置授权登录按钮图片
    -  int setLogBtnOffsetY; //设置登录按钮相对于标题栏下边缘Y偏移
    -  int setLogBtnOffsetBottomY; //设置登录按钮相对于屏幕底部Y偏移
    -  int setLogBtnTextSize; //设置登录按钮字体大小
    -  int setLogBtnHeight; //设置登录按钮高度
    -  int setLogBtnWidth; //设置登录按钮宽度
    -  int setLogBtnOffsetX; //设置登录按钮相对屏幕左侧X偏移
    -  bool setLogBtnTextBold; //设置登录按钮字体是否加粗（true：加粗；false：不加粗）
    -
    -  //授权页 隐私协议栏
    -  List<String> setAppPrivacyOne; //设置开发者隐私条款1，包含两个参数：1.名称 2.URL
    -  List<String> setAppPrivacyTwo; //设置开发者隐私条款2，包含两个参数：1.名称 2.URL
    -  List<String> setAppPrivacyThree; //设置开发者隐私条款3，包含两个参数：1.名称 2.URL
    -  bool setPrivacySmhHidden; //设置协议名称是否显示书名号《》，默认显示书名号（true：不显示；false：显示）
    -  int setPrivacyTextSize; //设置隐私栏字体大小
    -  List<String> setAppPrivacyColor; //设置隐私条款文字颜色，包含两个参数：1.基础文字颜色 2.协议文字颜色
    -  int setPrivacyOffsetBottomY; //设置隐私条款相对于授权页面底部下边缘y偏移
    -  int setPrivacyOffsetY; //设置隐私条款相对于授权页面标题栏下边缘y偏移
    -  int setPrivacyOffsetX; //设置隐私条款相对屏幕左侧X偏移
    -  bool setPrivacyOffsetGravityLeft; //设置隐私条款文字左对齐（true：左对齐；false：居中）
    -  bool setPrivacyState; //设置隐私条款的CheckBox是否选中（true：选中；false：未选中）
    -  String setUncheckedImgPath; //设置隐私条款的CheckBox未选中时图片
    -  String setCheckedImgPath; //设置隐私条款的CheckBox选中时图片
    -  bool setCheckBoxHidden; //设置隐私条款的CheckBox是否隐藏（true：隐藏；false：不隐藏）
    -  List<int> setCheckBoxWH; //设置checkbox的宽高，包含两个参数：1.宽 2.高
    -  List<int> setCheckBoxMargin; //设置checkbox的间距，包含四个参数：1.左间距 2.上间距 3.右间距 4.下间距
    -  List<String> setPrivacyText; //设置隐私条款名称外的文字,包含五个参数
    -  bool setPrivacyTextBold; //设置协议栏字体是否加粗（true：加粗；false：不加粗）
    -
    -  //授权页 slogan（***提供认证服务）
    -  String setSloganTextColor; //设置slogan文字颜色
    -  int setSloganTextSize; //设置slogan文字字体大小
    -  int setSloganOffsetY; //设置slogan相对于标题栏下边缘y偏移
    -  bool setSloganHidden = false; //设置slogan是否隐藏（true：隐藏；false：不隐藏）
    -  int setSloganOffsetBottomY; //设置slogan相对屏幕底部Y偏移
    -  int setSloganOffsetX; //设置slogan相对屏幕左侧X偏移
    -  bool setSloganTextBold; //设置slogan文字字体是否加粗（true：加粗；false：不加粗）
    -
    -  //创蓝slogan设置
    -  int setShanYanSloganTextColor; //设置创蓝slogan文字颜色
    -  int setShanYanSloganTextSize; //设置创蓝slogan文字字体大小
    -  int setShanYanSloganOffsetY; //设置创蓝slogan相对于标题栏下边缘y偏移
    -  bool setShanYanSloganHidden; //设置创蓝slogan是否隐藏（true：隐藏；false：不隐藏）
    -  int setShanYanSloganOffsetBottomY; //设置创蓝slogan相对屏幕底部Y偏移
    -  int setShanYanSloganOffsetX; //设置创蓝slogan相对屏幕左侧X偏移
    -  bool setShanYanSloganTextBold; //设置创蓝slogan文字字体是否加粗（true：加粗；false：不加粗）
    -
    -  //协议页导航栏
    -  int setPrivacyNavColor; //设置协议页导航栏背景颜色
    -  bool setPrivacyNavTextBold; //设置协议页导航栏标题文字是否加粗（true：加粗；false：不加粗）
    -  int setPrivacyNavTextColor; //设置协议页导航栏标题文字颜色
    -  int setPrivacyNavTextSize; //设置协议页导航栏标题文字大小
    -  String setPrivacyNavReturnImgPath; //设置协议页导航栏返回按钮图标
    -  bool setPrivacyNavReturnImgHidden; //设置协议页导航栏返回按钮是否隐藏（true：隐藏；false：不隐藏）
    -  int setPrivacyNavReturnBtnWidth; //设置协议页导航栏返回按钮宽度
    -  int setPrivacyNavReturnBtnHeight; //设置协议页导航栏返回按钮高度
    -  int setPrivacyNavReturnBtnOffsetRightX; //设置协议页导航栏返回按钮距离屏幕右侧X偏移
    -  int setPrivacyNavReturnBtnOffsetX; //设置协议页导航栏返回按钮距离屏幕左侧X偏移
    -  int setPrivacyNavReturnBtnOffsetY; //设置协议页导航栏返回按钮距离屏幕上侧Y偏移
    -
    -  String addCustomPrivacyAlertView; //添加授权页上显示隐私协议弹框
    -  String setLoadingView; //设置授权页点击一键登录自定义loading
    -  List<String>
    -      setDialogTheme; //设置授权页为弹窗样式，包含5个参数：1.弹窗宽度 2.弹窗高度 3.弹窗X偏移量（以屏幕中心为原点） 4.弹窗Y偏移量（以屏幕中心为原点） 5.授权页弹窗是否贴于屏幕底部
    -  List<ShanYanCustomWidgetLayout> widgetLayout; //添加自定义布局layout
    -  List<ShanYanCustomWidget> widgets; //添加自定义控件 暂时只支持textview

 * */


///*iOS独有*/
@JsonSerializable(explicitToJson: true)
class ShanYanUIConfigIOS {

  ShanYanUIConfigIOS();

  ///外部手动管理关闭界面
  ///BOOL,default is NO
  bool isFinish;

  /// 授权页-背景图片*/
  String setAuthBGImgPath;

  /// 状态栏样式
  iOSStatusBarStyle setPreferredStatusBarStyle;
  ///*状态栏隐藏
  bool setStatusBarHidden;

  //导航栏
  /// 导航栏 是否隐藏 BOOL default is NO
  bool setAuthNavHidden;
  /// 导航栏样式
  iOSBarStyle clNavigationBarStyle;

  /// 导航栏 背景透明 BOOL
  bool setAuthNavTransparent;

  /// 导航栏标题*/
//  @property (nonatomic,strong)NSAttributedString * clNavigationAttributesTitleText;

  String setNavText; //设置导航栏标题文字
  String setNavTextColor; //设置导航栏标题文字颜色
  int setNavTextSize; //设置导航栏标题文字大小

  /**导航栏右侧自定义按钮*/
//  @property (nonatomic,strong)UIBarButtonItem * clNavigationRightControl;
  /**导航栏左侧自定义按钮*/
//  @property (nonatomic,strong)UIBarButtonItem * clNavigationLeftControl;

// 返回按钮
  /// 导航栏左侧返回按钮图片*/
  String setNavReturnImgPath;
  /// 导航栏自带返回按钮隐藏，默认显示 BOOL*/
  bool setNavReturnImgHidden;

  /// 返回按钮图片缩进 btn.imageInsets = UIEdgeInsetsMake(0, 0, 20, 20)*/
//  @property (nonatomic,strong)NSValue * clNavBackBtnImageInsets;

  /// 自带返回(关闭)按钮位置 默认NO 居左,设置为YES居右显示*/
  bool setNavBackBtnAlimentRight;


  /// 导航栏分割线 是否隐藏
  /// set backgroundImage=UIImage.new && shadowImage=UIImage.new
  /// BOOL, default is NO
  /// eg.@(YES)
  bool setNavigationBottomLineHidden;
  /// 导航栏 渲染色*/
  String setNavigationTintColor;
  /// 导航栏 背景色 default is white*/
  String setNavigationBarTintColor;
  /// 导航栏 背景图片*/
  String setNavigationBackgroundImage;

  /**导航栏 配合背景图片设置，用来控制在不同状态下导航栏的显示(横竖屏是否显示) UIBarMetrics eg.@(UIBarMetricsCompact)*/
//  @property (nonatomic,strong)NSNumber * clNavigationBarMetrics;

  /// 导航栏 导航栏底部分割线（图片）*/
  String setNavigationShadowImage;




//LOGO图片

  String setLogoImgPath;    /// LOGO图片

  num setLogoCornerRadius;  /// LOGO圆角

  bool setLogoHidden;       /// LOGO显隐

//手机号显示控件
  String  setNumberColor;   /// 号码栏字体颜色
  num     setNumberSize;    /// 号码栏字体
  bool    setNumberBold;    /// 号码栏字体是否加粗（true：加粗；false：不加粗）

  iOSTextAlignment setPhoneNumberTextAlignment; /// 手机号对齐方式

//一键登录按钮 !不得隐藏
  String  setLogBtnText;          /// 按钮文字
  String  setLogBtnTextColor;     /// 按钮文字颜色
  num     setLoginBtnTextSize;    /// 号码栏字体
  bool    setLoginBtnTextBold;    /// 号码栏字体是否加粗
  String setLoginBtnBgColor;           /// 按钮背景颜色
  String setLoginBtnNormalBgImage;     /// 按钮背景图片
  String setLoginBtnHightLightBgImage; /// 按钮背景高亮图片
  String setLoginBtnDisabledBgImage;   /// 按钮背景不可用图片
  String setLoginBtnBorderColor;       /// 按钮边框颜色
  num setLoginBtnCornerRadius;         /// 按钮圆角
  num setLoginBtnBorderWidth;          /// 按钮边框线框


/*隐私条款Privacy
 注： 运营商隐私条款 不得隐藏
 用户条款不限制
 **/
  /**隐私条款名称颜色：@[基础文字颜色UIColor*,条款颜色UIColor*] eg.@[[UIColor lightGrayColor],[UIColor greenColor]]*/
//  @property (nonatomic,strong) NSArray<UIColor*> *clAppPrivacyColor;

  /**隐私条款文字字体*/
  num setPrivacyTextSize;   /// 设置隐私栏字体大小
  bool setPrivacyTextBold;  /// 设置协议栏字体是否加粗

  iOSTextAlignment setAppPrivacyTextAlignment;  /// 隐私条款文字对齐方式
  bool setPrivacySmhHidden;                     /// 运营商隐私条款书名号
  num setAppPrivacyLineSpacing;                 /// 多行时行距
  bool setAppPrivacyNeedSizeToFit;               /// 是否需要sizeToFit,设置后与宽高约束的冲突请自行考虑
  /**UITextView.textContainerInset 文字与TextView控件内边距 UIEdgeInset  eg.[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)]*/
//  @property (nonatomic,strong)NSValue* clAppPrivacyTextContainerInset;
  num clAppPrivacyLineFragmentPadding;          /// 文字与TextView控件左右内边距
  /**UITextView.contentInset UIEdgeInset eg.[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)]*/
//  @property (nonatomic,strong)NSValue* clAppPrivacyContentInset;
  String setAppPrivacyAbbreviatedName;           /// 隐私条款--APP名称简写 默认取CFBundledisplayname 设置描述文本四后此属性无效
/*
 *隐私条款Y一:需同时设置Name和UrlString eg.@[@"条款一名称",条款一URL]
 *@[NSSting,NSURL];
 */
//  @property (nonatomic,strong)NSArray * clAppPrivacyFirst;
/*
 *隐私条款二:需同时设置Name和UrlString eg.@[@"条款一名称",条款一URL]
 *@[NSSting,NSURL];
 */
//  @property (nonatomic,strong)NSArray * clAppPrivacySecond;
/*
 *隐私条款三:需同时设置Name和UrlString eg.@[@"条款一名称",条款一URL]
 *@[NSSting,NSURL];
 */
//  @property (nonatomic,strong)NSArray * clAppPrivacyThird;
/*
 隐私协议文本拼接: DesTextFirst+运营商条款+DesTextSecond+隐私条款一+DesTextThird+隐私条款二+DesTextFourth+隐私条款三+DesTextLast
 **/
  /**描述文本 首部 default:"同意"*/
  String setAppPrivacyNormalDesTextFirst;
  /**描述文本二 default:"和"*/
  String setAppPrivacyNormalDesTextSecond;
  /**描述文本三 default:"、"*/
  String setAppPrivacyNormalDesTextThird;
  /**描述文本四 default:"、"*/
  String setAppPrivacyNormalDesTextFourth;
  /**描述文本 尾部 default: "并授权AppName使用认证服务"*/
  String setAppPrivacyNormalDesTextLast;

  bool setOperatorPrivacyAtLast;  /// 运营商协议后置

  String setPrivacyNavText;       /// 协议页导航栏统一标题，默认显示条款名称
  String setPrivacyNavTextColor;  /// 协议页导航栏标题文字颜色
  bool setPrivacyNavTextBold;     /// 协议页标题文字是否加粗

  /**隐私协议WEB页面导航返回按钮图片*/
  String setPrivacyNavReturnImgPath;

  iOSStatusBarStyle setAppPrivacyWebPreferredStatusBarStyle;  /// 协议页状态栏样式
  iOSBarStyle setAppPrivacyWebNavigationBarStyle;             /// 协议页导航栏样式

  ///导航栏其他属性
  String setAppPrivacyWebNavigationTintColor;
  String setAppPrivacyWebNavigationBarTintColor;
  String setAppPrivacyWebNavigationBackgroundImage;
  /**UINavigationBarMetrics*/
//  @property (nonatomic,strong)NSNumber * clAppPrivacyWebNavigationBarMetrics;
  String setAppPrivacyWebNavigationShadowImage;

//运营商品牌标签("中国**提供认证服务")，不得隐藏
  num setSloganTextSize;    /// slogan文字字体大小
  bool setSloganTextBold;   /// slogan文字字体是否加粗
  String setSloganTextColor; /// slogan文字颜色
  iOSTextAlignment setSlogaTextAlignment;   /// slogan文字对齐方式

//供应商品牌标签("创蓝253提供认技术支持")
  num setShanYanSloganTextSize;    /// slogan文字字体大小
  bool setShanYanSloganTextBold;   /// slogan文字字体是否加粗
  String setShanYanSloganTextColor; /// slogan文字颜色
  iOSTextAlignment setShanYanSlogaTextAlignment;   /// slogan文字对齐方式
  bool setShanYanSloganHidden;                     /// slogan是否隐藏


/*CheckBox
 *协议勾选框，默认选中且在协议前显示
 *可在sdk_oauth.bundle中替换checkBox_unSelected、checkBox_selected图片
 *也可以通过属性设置选中和未选择图片
 **/
  /**协议勾选框（默认显示,放置在协议之前）BOOL eg.@(YES)*/
  bool setCheckBoxHidden;
  /**协议勾选框默认值（默认选中）BOOL eg.@(YES)*/
  bool setPrivacyState;
  /**协议勾选框 尺寸 NSValue->CGSize eg.[NSValue valueWithCGSize:CGSizeMake(25, 25)]*/
//  @property (nonatomic,strong) NSValue *clCheckBoxSize;
  /**协议勾选框 UIButton.image图片缩进 UIEdgeInset eg.[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)]*/
//  @property (nonatomic,strong) NSValue *clCheckBoxImageEdgeInsets;
  /**协议勾选框 设置CheckBox顶部与隐私协议控件顶部对齐 YES或大于0生效 eg.@(YES)*/
  bool clCheckBoxVerticalAlignmentToAppPrivacyTop;
  /**协议勾选框 设置CheckBox顶部与隐私协议控件竖向中心对齐 YES或大于0生效 eg.@(YES)*/
  bool clCheckBoxVerticalAlignmentToAppPrivacyCenterY;
  /**协议勾选框 非选中状态图片*/
  String setUncheckedImgPath;
  /**协议勾选框 选中状态图片*/
  String setCheckedImgPath;

  /**授权页自定义 "请勾选协议"提示框
      - containerView为loading的全屏蒙版view
      - 请自行在containerView添加自定义提示
   */
//  @property (nonatomic,copy)void(^checkBoxTipView)(UIView * containerView);


/*Loading*/
  /**Loading 大小 CGSize eg.[NSValue valueWithCGSize:CGSizeMake(50, 50)]*/
//  @property (nonatomic,strong) NSValue *clLoadingSize;
  /**Loading 圆角 float eg.@(5) */
  num clLoadingCornerRadius;
  /**Loading 背景色 UIColor eg.[UIColor colorWithRed:0.8 green:0.5 blue:0.8 alpha:0.8]; */
  String clLoadingBackgroundColor;
  /**UIActivityIndicatorViewStyle eg.@(UIActivityIndicatorViewStyleWhiteLarge)*/
//  @property (nonatomic,strong) NSNumber *clLoadingIndicatorStyle;
  /**Loading Indicator渲染色 UIColor eg.[UIColor greenColor]; */
  String clLoadingTintColor;
  /**授权页自定义Loading
      - containerView为loading的全屏蒙版view
      - 请自行在containerView添加自定义loading
      - 设置block后，上述loading属性将无效
   */
//  @property (nonatomic,copy)void(^loadingView)(UIView * containerView);

//添加自定义控件
  /**可设置背景色及添加控件*/
//  @property (nonatomic,copy)void(^customAreaView)(UIView * customAreaView);
  /**设置隐私协议弹窗*/
//  @property (nonatomic,copy)void(^customPrivacyAlertView)(UIViewController * authPageVC);

  /**横竖屏*/
/*是否支持自动旋转 BOOL*/
  bool shouldAutorotate;
/*支持方向 UIInterfaceOrientationMask
 - 如果设置只支持竖屏，只需设置clOrientationLayOutPortrait竖屏布局对象
 - 如果设置只支持横屏，只需设置clOrientationLayOutLandscape横屏布局对象
 - 横竖屏均支持，需同时设置clOrientationLayOutPortrait和clOrientationLayOutLandscape
 */
//  @property (nonatomic,strong) NSNumber * supportedInterfaceOrientations;
/*默认方向 UIInterfaceOrientation*/
//  @property (nonatomic,strong) NSNumber * preferrednumerfaceOrientationForPresentation;

  /**以窗口方式显示授权页
   */
  /**以窗口方式显示 BOOL, default is NO */
  bool clAuthTypeUseWindow;
  /**窗口圆角 float*/
  num clAuthWindowCornerRadius;

  /**clAuthWindowModalTransitionStyle系统自带的弹出方式 仅支持以下三种
      UIModalTransitionStyleCoverVertical 底部弹出
      UIModalTransitionStyleCrossDissolve 淡入
      UIModalTransitionStyleFlipHorizontal 翻转显示
   */
//  @property (nonatomic,strong) NSNumber * clAuthWindowModalTransitionStyle;

/* UIModalPresentationStyle
 * 若使用窗口模式，请设置为UIModalPresentationOverFullScreen 或不设置
 * iOS13强制全屏，请设置为UIModalPresentationFullScreen
 * UIModalPresentationAutomatic API_AVAILABLE(ios(13.0)) = -2
 * 默认UIModalPresentationFullScreen
 * eg. @(UIModalPresentationOverFullScreen)
 */
/*授权页 ModalPresentationStyle*/
//  @property (nonatomic,strong) NSNumber * clAuthWindowModalPresentationStyle;
/*协议页 ModalPresentationStyle （授权页使用窗口模式时，协议页强制使用模态弹出）*/
//  @property (nonatomic,strong) NSNumber * clAppPrivacyWebModalPresentationStyle;

/* UIUserInterfaceStyle
 * UIUserInterfaceStyleUnspecified - 不指定样式，跟随系统设置进行展示
 * UIUserInterfaceStyleLight       - 明亮
 * UIUserInterfaceStyleDark,       - 暗黑 仅对iOS13+系统有效
 */
/*授权页 UIUserInterfaceStyle,默认:UIUserInterfaceStyleLight,eg. @(UIUserInterfaceStyleLight)*/
//  @property (nonatomic,strong) NSNumber * clAuthWindowOverrideUserInterfaceStyle;

  /**
   * 授权页面present弹出时animate动画设置，默认带动画，eg. @(YES)
   */
  bool clAuthWindowPresentingAnimate;

  /**弹窗的MaskLayer，用于自定义窗口形状*/
//  @property (nonatomic,strong) CALayer * clAuthWindowMaskLayer;


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
  num setLogoWidth;
  num setLogoHeight;
  num setLogoLeft;
  num setLogoRight;
  num setLogoTop;
  num setLogoBottom;
  num setLogoCenterX;
  num setLogoCenterY;

  //脱敏手机号
  num setNumFieldWidth;
  num setNumFieldHeight;
  num setNumFieldLeft;
  num setNumFieldRight;
  num setNumFieldTop;
  num setNumFieldBottom;
  num setNumFieldCenterX;
  num setNumFieldCenterY;

  //一键登录按钮
  num setLogBtnHeight;
  num setLogBtnWidth;
  num setLogBtnLeft;
  num setLogBtnRight;
  num setLogBtnTop;
  num setLogBtnBottom;
  num setLogBtnCenterX;
  num setLogBtnCenterY;

  //隐私协议
  num setPrivacyHeight;
  num setPrivacyWidth;
  num setPrivacyLeft;
  num setPrivacyRight;
  num setPrivacyTop;
  num setPrivacyBottom;
  num setPrivacyCenterX;
  num setPrivacyCenterY;

  //授权页 slogan（***提供认证服务）
  num setSloganHeight;
  num setSloganWidth;
  num setSloganLeft;
  num setSloganRight;
  num setSloganTop;
  num setSloganBottom;
  num setSloganCenterX;
  num setSloganCenterY;

  //授权页 创蓝slogan（创蓝253提供认证服务）
  num setShanYanSloganHeight;
  num setShanYanSloganWidth;
  num setShanYanSloganLeft;
  num setShanYanSloganRight;
  num setShanYanSloganTop;
  num setShanYanSloganBottom;
  num setShanYanSloganCenterX;
  num setShanYanSloganCenterY;

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

///iOS 文字对齐方式
enum iOSTextAlignment  {

  left, // Visually left aligned 居左
  center, // Visually centered 居中
  right, // Visually right aligned 居右

/* !TARGET_ABI_USES_IOS_VALUES */
// Visually right aligned
// Visually centered
  justified, // Fully-justified. The last line in a paragraph is natural-aligned. 自动

  natural, // Indicates the default alignment for script 自然段落
}

/// iOS 状态栏样式
/// Xcode工程内的Info.plist文件配置需设置为YES，即运行单个页面自行管理状态栏: View controller-based status bar appearance = YES
enum iOSStatusBarStyle{
  styleDefault,        // 状态栏显示 黑
  styleLightContent,   // 状态栏显示 白
  styleDarkContent     // 状态栏显示 黑 API_AVAILABLE(ios(13.0)) = 3
}

/// iOS 导航栏样式，也可用于修改状态栏样式
enum iOSBarStyle{
  styleDefault, // 状态栏显示 黑
  styleBlack    // 状态栏显示 白
}
