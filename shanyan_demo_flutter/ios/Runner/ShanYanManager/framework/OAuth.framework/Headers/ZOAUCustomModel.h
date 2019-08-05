#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ControllerType) {
    PushController,
    PresentController
};

@interface ZOAUCustomModel : NSObject


//MARK:授权页*************

/**授权页背景颜色*/
@property (nonatomic,strong) UIColor *backgroundColor;
/**授权页弹出方式*/
@property (nonatomic,assign) ControllerType controllerType;
/**授权页销毁是否交由app处理*/
@property (nonatomic,assign) BOOL destroyCrollerBySelf;

//MARK:导航栏设置*************

/**隐藏导航栏尾部线条(默认显示)*/
@property (nonatomic,assign) BOOL navBottomLineHidden;
/**导航栏隐藏*/
@property (nonatomic,assign) BOOL navBarHidden;
/**导航栏透明*/
@property (nonatomic,assign) BOOL navTranslucent;
/**导航栏背景颜色*/
@property (nonatomic,strong) UIColor *navBgColor;
/**导航栏背景图片*/
@property (nonatomic,strong) UIImage *navBgImage;
/**导航栏标题*/
@property (nonatomic,strong) NSString *navText;
/**导航栏标题字体*/
@property (nonatomic,strong) UIFont *navTextFont;
/**导航栏标题颜色*/
@property (nonatomic,strong) UIColor *navTextColor;
/**导航返回图标*/
@property (nonatomic,strong) UIImage *navReturnImg;
/**导航栏右侧自定义控件*/
@property (nonatomic,strong) UIBarButtonItem *navControl;


//MARK:自定义区域（导航下方）设置************

/**自定义区域高度*/
@property (nonatomic,assign) CGFloat topCustomHeight;


//MARK:图片设置************

/**LOGO图片*/
@property (nonatomic,strong) UIImage *logoImg;
/**LOGO图片宽度*/
@property (nonatomic,assign) CGFloat logoWidth;
/**LOGO图片高度*/
@property (nonatomic,assign) CGFloat logoHeight;
/**LOGO图片偏移量*/
@property (nonatomic,assign) CGFloat logoOffsetY;

//MARK:应用名称设置************

/**隐藏应用名（默认隐藏）*/
@property (nonatomic,assign) BOOL appNameHidden;
/**应用名字体颜色*/
@property (nonatomic,strong) UIColor *appNameColor;
/**应用名字体*/
@property (nonatomic,strong) UIFont *appNameFont;
/**应用名Y偏移量*/
@property (nonatomic,assign) CGFloat appNameOffsetY;


//MARK:号码框设置************

/**手机号码字体颜色*/
@property (nonatomic,strong) UIColor *numberColor;
/**手机号码Y偏移量*/
@property (nonatomic,assign) CGFloat numberOffsetY;
/**手机号码字体*/
@property (nonatomic,strong) UIFont *numberFont;



//MARK:品牌设置************
/**认证服务品牌文字颜色*/
@property (nonatomic,strong) UIColor *brandColor;
/**认证服务品牌文字字体*/
@property (nonatomic,strong) UIFont *brandFont;
/**认证服务品牌Y偏移量*/
@property (nonatomic,assign) CGFloat brandOffsetY;
/**隐藏认证服务品牌（默认显示）*/
@property (nonatomic,assign) BOOL brandHidden;



//MARK:登录按钮设置************

/**登录按钮文本*/
@property (nonatomic,strong) NSString *logBtnText;
/**登录按钮字体*/
@property (nonatomic,strong) UIFont *logBtnTextFont;
/**登录按钮文本颜色*/
@property (nonatomic,strong) UIColor *logBtnTextColor;
/**登录按钮Y偏移量*/
@property (nonatomic,assign) CGFloat logBtnOffsetY;
/**登录按钮圆角*/
@property (nonatomic,assign) CGFloat logBtnRadius;
/**登录按钮背景颜色(可用状态)*/
@property (nonatomic,strong) UIColor *logBtnUsableBGColor;
/**登录按钮背景颜色(不可用状态)*/
@property (nonatomic,strong) UIColor *logBtnUnusableBGColor;


//MARK:其他登录方式设置************


/**其他登录方式字体颜色*/
@property (nonatomic,strong) UIColor *swithAccTextColor;
/**其他登录方式字体*/
@property (nonatomic,strong) UIFont *swithAccTextFont;
/**其他登录方式Y偏移量*/
@property (nonatomic,assign) CGFloat swithAccOffsetY;
/**其他登录方式X偏移量*/
@property (nonatomic,assign) CGFloat swithAccOffsetX;
/**隐藏其他登录方式按钮（默认显示）*/
@property (nonatomic,assign) BOOL swithAccHidden;



//MARK:隐私条款设置************

/**隐藏复选框（默认显示）*/
@property (nonatomic,assign) BOOL checkBoxHidden;
/**复选框默认值（默认不选中）*/
@property (nonatomic,assign) BOOL checkBoxValue;
/**复选框选中时图片*/
@property (nonatomic,strong) UIImage *checkBoxCheckedImg;
/**复选框未选中时图片*/
@property (nonatomic,strong) UIImage *checkBoxNormalImg;
/**隐私条款Y偏移量*/
@property (nonatomic,assign) CGFloat privacyOffsetY;
/**隐私条款颜色*/
@property (nonatomic,strong) UIColor *privacyTextColor;
/**隐私条款协议颜色*/
@property (nonatomic,strong) UIColor *privacyColor;
/**开发者隐私条款协议名称（第一个协议）*/
@property (nonatomic,strong) NSString *appFPrivacyText;
/**开发者隐私条款协议url（第一个协议）*/
@property (nonatomic,strong) NSString *appFPrivacyUrl;
/**开发者隐私条款协议名称（第二个协议）*/
@property (nonatomic,strong) NSString *appSPrivacyText;
/**开发者隐私条款协议url（第二个协议）*/
@property (nonatomic,strong) NSString *appSPrivacyUrl;



//MARK:loading设置************

/**loading提示文字*/
@property (nonatomic,strong) NSString *loadingText;
/**loading提示文字颜色*/
@property (nonatomic,strong) UIColor *loadingTextColor;
/**loading提示文字字体*/
@property (nonatomic,strong) UIFont *loadingTextFont;
/**loading提示文字高度*/
@property (nonatomic,assign) CGFloat loadingTextHeight;
/**loading背景宽度*/
@property (nonatomic,assign) CGFloat loadingBgWidth;
/**loading背景高度*/
@property (nonatomic,assign) CGFloat loadingBgHeight;
/**loading背景圆角*/
@property (nonatomic,assign) CGFloat loadingBgRadius;
/**loading背景色*/
@property (nonatomic,strong) UIColor *loadingBgColor;


@end
