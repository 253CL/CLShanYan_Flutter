#import "ShanyanPlugin.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
//Helpers
#import "CLShanYanCustomViewHelper.h"
#import "UIView+CLShanYanWidget.h"
#import "NSNumber+shanyanCategory.h"

@interface ShanyanPlugin ()<CLShanYanSDKManagerDelegate>
@property (nonatomic,strong)id notifObserver;

@property(nonatomic,strong)NSObject<FlutterPluginRegistrar>*registrar;

@property(nonatomic,strong)FlutterMethodChannel* channel;
@end

@implementation ShanyanPlugin

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:_notifObserver];
    _notifObserver = nil;
}


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"shanyan"
            binaryMessenger:[registrar messenger]];
    ShanyanPlugin* instance = [[ShanyanPlugin alloc] init];
    instance.channel = channel;
    instance.registrar = registrar;
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"init" isEqualToString:call.method]){
      [self init:call complete:result];
  }else if ([@"getPhoneInfo" isEqualToString:call.method]){
      [self preGetPhonenumber:result];
  }else if ([@"openLoginAuth" isEqualToString:call.method]){
      [self quickAuthLoginWithConfigure:call.arguments complete:result];
  }else if ([@"setActionListener" isEqualToString:call.method]){
      [self setActionListener];
  }else if ([@"startAuthentication" isEqualToString:call.method]){
      [self startAuthentication:result];
  }else if ([@"finishAuthControllerCompletion" isEqualToString:call.method]){
      [self finishAuthControllerCompletion:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
    
//    else if ([@"setCustomInterface" isEqualToString:call.method]){
//        [self setCustomInterface:result];
//    }else if ([@"openLoginAuthListener" isEqualToString:call.method]){
//        [self openLoginAuthListener:result];
//    }else if ([@"oneKeyLoginListener" isEqualToString:call.method]){
//        [self oneKeyLoginListener:result];
//    }else if ([@"quickAuthLoginWithConfigure" isEqualToString:call.method]){
//        [self quickAuthLoginWithConfigure:call.arguments];
//    }else if ([@"finishAuthControllerCompletion" isEqualToString:call.method]){
//        [self finishAuthControllerCompletion:result];
//    }else if ([@"startAuthentication" isEqualToString:call.method]){
//        [self startAuthentication:result];
//    }
}

-(void)setActionListener{
    [CLShanYanSDKManager setCLShanYanSDKManagerDelegate:self];
}
#pragma mark - CLShanYanSDKManagerDelegate
-(void)clShanYanActionListener:(NSInteger)type code:(NSInteger)code  message:(NSString *_Nullable)message{
    NSMutableDictionary * result = [NSMutableDictionary dictionary];
    result[@"type"] = @(type);
    result[@"code"] = @(code);
    result[@"message"] = message;
    if (self.channel) {
        [self.channel invokeMethod:@"onReceiveAuthEvent" arguments:result];
    }
}


- (void)init:(FlutterMethodCall*)call complete:(FlutterResult)complete{
    
    NSDictionary * argv = call.arguments;
    if (argv == nil || ![argv isKindOfClass:[NSDictionary class]]) {
        if (complete) {
            NSMutableDictionary * result = [NSMutableDictionary new];
            result[@"code"] = @(1001);
            result[@"message"] = @"请设置参数";
            complete(result);
        }
        return;
    }
    
    NSString * appId = argv[@"appId"];

    [CLShanYanSDKManager initWithAppId:appId complete:^(CLCompleteResult * _Nonnull completeResult) {
        
        if (complete) {
            complete([ShanyanPlugin completeResultToJson:completeResult]);
        }
    }];
}

- (void)preGetPhonenumber:(FlutterResult)complete{
    
    [CLShanYanSDKManager preGetPhonenumber:^(CLCompleteResult * _Nonnull completeResult) {
        
        NSLog(@"%@",completeResult.message);
        
        if (complete) {
            complete([ShanyanPlugin completeResultToJson:completeResult]);
        }
    }];
}

-(void)quickAuthLoginWithConfigure:(NSDictionary *)clUIConfigure complete:(FlutterResult)complete{
    
    CLUIConfigure * baseUIConfigure = [[CLUIConfigure alloc]init];
    baseUIConfigure.viewController = [self findVisibleVC];;
    
    
    NSArray * setAppPrivacyFirstArray = clUIConfigure[@"setAppPrivacyFirst"];
    if (setAppPrivacyFirstArray != nil && setAppPrivacyFirstArray.count == 2) {
        NSString * clAppPrivacyFirstString = setAppPrivacyFirstArray.firstObject;
        NSString * clAppPrivacyFirstUrl = setAppPrivacyFirstArray.lastObject;
        
        baseUIConfigure.clAppPrivacyFirst = @[clAppPrivacyFirstString,clAppPrivacyFirstUrl];
    }
    NSArray * setAppPrivacySecondArray = clUIConfigure[@"setAppPrivacySecond"];
    if (setAppPrivacySecondArray != nil && setAppPrivacySecondArray.count == 2) {
        NSString * clAppPrivacySecondString = setAppPrivacySecondArray.firstObject;
        NSString * clAppPrivacySecondUrl = setAppPrivacySecondArray.lastObject;
        
        baseUIConfigure.clAppPrivacySecond = @[clAppPrivacySecondString,clAppPrivacySecondUrl];
    }
    baseUIConfigure.clAppPrivacyNormalDesTextSecond = @"、";
    baseUIConfigure.clAppPrivacyNormalDesTextThird = @"、";

    
    
    [self configureWithSet:baseUIConfigure];
    
    
    __weak typeof(self) weakSelf = self;
    
     [CLShanYanSDKManager quickAuthLoginWithConfigure:baseUIConfigure openLoginAuthListener:^(CLCompleteResult * _Nonnull completeResult) {
         
        NSLog(@"%@",completeResult.message);
         
        if (complete) {
            complete([ShanyanPlugin completeResultToJson:completeResult]);
        }

     } oneKeyLoginListener:^(CLCompleteResult * _Nonnull completeResult) {
         
        __strong typeof(weakSelf) strongSelf = weakSelf;

         //一键登录回调
         if (strongSelf.channel) {
             [strongSelf.channel invokeMethod:@"onReceiveAuthPageEvent" arguments:[ShanyanPlugin completeResultToJson:completeResult]];
         }
     }];
}

//定制
-(CLUIConfigure *)configureWithSet:(CLUIConfigure *)baseUIConfigure{
    
    CGFloat screenWidth_Portrait;
    CGFloat screenHeight_Portrait;

    screenWidth_Portrait = UIScreen.mainScreen.bounds.size.width;
    screenHeight_Portrait = UIScreen.mainScreen.bounds.size.height;
    
    UIColor * themeColor = [UIColor colorWithRed:0/255.0 green:97/255.0 blue:234/255.0 alpha:1];;
    
    baseUIConfigure.clAuthTypeUseWindow = @(NO);
    baseUIConfigure.manualDismiss = @(YES);
    baseUIConfigure.shouldAutorotate = @(NO);
    baseUIConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskPortrait);
    baseUIConfigure.clNavigationBarHidden = @(YES);
    baseUIConfigure.clNavBackBtnAlimentRight = @(YES);
    baseUIConfigure.clPrefersStatusBarHidden = @(YES);
    
    baseUIConfigure.clPhoneNumberColor = UIColor.blackColor;
    baseUIConfigure.clPhoneNumberFont = [UIFont boldSystemFontOfSize:30];
    
    baseUIConfigure.clLoginBtnText = @"一键登录";
    baseUIConfigure.clLoginBtnTextFont = [UIFont systemFontOfSize:15];
    baseUIConfigure.clLoginBtnBgColor = themeColor;
    baseUIConfigure.clLoginBtnTextColor = UIColor.whiteColor;
    baseUIConfigure.clLoginBtnCornerRadius = @(5);
    
    baseUIConfigure.clShanYanSloganHidden = @(YES);
    baseUIConfigure.clAuthWindowModalPresentationStyle = @(UIModalPresentationFullScreen);
    
    baseUIConfigure.clCheckBoxValue = @(YES);
    
    baseUIConfigure.clAppPrivacyColor = @[[UIColor lightGrayColor],themeColor];

    baseUIConfigure.clLoadingTintColor = themeColor;
    baseUIConfigure.clLoadingCornerRadius = @(8);
    baseUIConfigure.clLoadingSize = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
    baseUIConfigure.clLoadingBackgroundColor = UIColor.whiteColor;
    baseUIConfigure.clLoadingIndicatorStyle = @(UIActivityIndicatorViewStyleWhite);
    
    CGFloat wibdowCenterYOffset = 0;
    CGFloat wibdowHeight = 350;
    CGFloat windowPadding = 40;

    CGFloat windowTop = (screenHeight_Portrait - wibdowHeight)*0.5 - wibdowCenterYOffset;
    
    CGFloat tipLabeltop = 30;
    CGFloat tipLabelHeight = 20;

    CGFloat phonetop = 30;
    CGFloat phoneHeight = 30;
    
    CGFloat logButtontop = 30;
    CGFloat logButtonHeight = 45;
    
    CGFloat otherWaytop = 5;
    CGFloat otherWayHeight = 40;
    
    CGFloat appPrivacyTop = 20;
    CGFloat appPrivacyHeight = 60;

    //授权页自定义控件
    __weak typeof(self)weakSelf = self;
    baseUIConfigure.customAreaView = ^(UIView * _Nonnull customAreaView) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;

        //蒙版颜色
        customAreaView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        
        //白色圆角背景
        UIView * whiteBGView = [[UIView alloc]init];
        whiteBGView.layer.cornerRadius = 10;
        whiteBGView.layer.masksToBounds = YES;
        whiteBGView.backgroundColor = UIColor.whiteColor;
        [customAreaView addSubview:whiteBGView];
        
        NSDictionary * whiteBGViewContraint = @{
            @"left":@(windowPadding),
            @"right":@(windowPadding),
            @"height":@(wibdowHeight),
            @"centerY":@(-wibdowCenterYOffset),
        };
        [ShanyanPlugin setConstraint:customAreaView targetView:whiteBGView contrains:whiteBGViewContraint];

        UILabel * tipLabel = [[UILabel alloc]init];
        tipLabel.text = @"本机号码";
        tipLabel.font = [UIFont systemFontOfSize:18];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.textColor = UIColor.blackColor;
        [whiteBGView addSubview:tipLabel];
        NSDictionary * tipLabelContraint = @{
            @"top":@(tipLabeltop),
            @"left":@(0),
        @"height":@(tipLabelHeight),
            @"right":@(0),
        };
        [ShanyanPlugin setConstraint:whiteBGView targetView:tipLabel contrains:tipLabelContraint];
        
        UIButton * otherWay = [[UIButton alloc]init];
        [otherWay.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [otherWay setTitleColor:themeColor forState:(UIControlStateNormal)];
        [otherWay setTitle:@"去验证码登录>" forState:(UIControlStateNormal)];
        otherWay.widgetId = @"Button_20200331_otherLoginButton";
        otherWay.isFinish = YES;
        [otherWay addTarget:strongSelf action:@selector(customButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [whiteBGView addSubview:otherWay];
        NSDictionary * otherWayContraint = @{
            @"left":@(0),
            @"right":@(0),
            @"height":@(45),
        @"top":@(tipLabeltop+tipLabelHeight+phonetop+phoneHeight+logButtontop+logButtonHeight+otherWaytop),
        };
        [ShanyanPlugin setConstraint:whiteBGView targetView:otherWay contrains:otherWayContraint];

        UIButton * cancelButton = [[UIButton alloc]init];
//            cancelButton.backgroundColor = UIColor.greenColor;
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelButton setTitleColor:themeColor forState:(UIControlStateNormal)];
        [cancelButton setImage:[UIImage imageNamed:@"back" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdk_oauth" ofType:@"bundle"]] compatibleWithTraitCollection:nil] forState:(UIControlStateNormal)];
        cancelButton.widgetId = @"Button_20200331_cancelButton";
        cancelButton.isFinish = YES;
        [cancelButton addTarget:strongSelf action:@selector(customButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [whiteBGView addSubview:cancelButton];
        NSDictionary * cancelButtonContraint = @{
            @"top":@(0),
            @"right":@(0),
            @"height":@(50),
            @"width":@(50),
        };
        [ShanyanPlugin setConstraint:whiteBGView targetView:cancelButton contrains:cancelButtonContraint];
    };
    

    
     //布局-竖屏
    CLOrientationLayOut * clOrientationLayOutPortrait = [CLOrientationLayOut new];
    
   clOrientationLayOutPortrait.clLayoutPhoneTop = @(windowTop + tipLabeltop + tipLabelHeight + phonetop);
   clOrientationLayOutPortrait.clLayoutPhoneHeight = @(phoneHeight);
   clOrientationLayOutPortrait.clLayoutPhoneLeft = @(windowPadding);
   clOrientationLayOutPortrait.clLayoutPhoneRight = @(-windowPadding);
    
    //一键登录按钮垂直居中，其他控件以此参考竖直位置
    clOrientationLayOutPortrait.clLayoutLoginBtnTop = @(clOrientationLayOutPortrait.clLayoutPhoneTop.floatValue + phoneHeight + logButtontop);
    clOrientationLayOutPortrait.clLayoutLoginBtnHeight = @(logButtonHeight);
    clOrientationLayOutPortrait.clLayoutLoginBtnLeft = @(30 + windowPadding);
    clOrientationLayOutPortrait.clLayoutLoginBtnRight = @(-30 - windowPadding);
    
    //Hide
    clOrientationLayOutPortrait.clLayoutSloganWidth = @(0);
    clOrientationLayOutPortrait.clLayoutSloganHeight = @(0);
    
    clOrientationLayOutPortrait.clLayoutAppPrivacyTop = @(clOrientationLayOutPortrait.clLayoutLoginBtnTop.floatValue + logButtonHeight + otherWaytop + otherWayHeight + appPrivacyTop);
    clOrientationLayOutPortrait.clLayoutAppPrivacyLeft = @(30 + windowPadding);
    clOrientationLayOutPortrait.clLayoutAppPrivacyRight = @(-30 - windowPadding);
    clOrientationLayOutPortrait.clLayoutAppPrivacyHeight = @(appPrivacyHeight);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyBottom = @(-20);
    
    baseUIConfigure.clOrientationLayOutPortrait = clOrientationLayOutPortrait;
    
    return baseUIConfigure;
}


+ (UIColor *)colorWithHexStr:(NSString *)hexString {
    if (hexString == nil) {
        return nil;
    }
    if (![hexString isKindOfClass:NSString.class]) {
        return nil;
    }
    if (hexString.length == 0) {
        return nil;
    }
    @try {
        NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
         CGFloat alpha, red, blue, green;
         switch ([colorString length]) {
             case 3: // #RGB
                 alpha = 1.0f;
                 red   = [self colorComponentFrom: colorString start: 0 length: 1];
                 green = [self colorComponentFrom: colorString start: 1 length: 1];
                 blue  = [self colorComponentFrom: colorString start: 2 length: 1];
                 break;
            case 4: // #ARGB
                alpha = [self colorComponentFrom: colorString start: 0 length: 1];
                red   = [self colorComponentFrom: colorString start: 1 length: 1];
                green = [self colorComponentFrom: colorString start: 2 length: 1];
                blue  = [self colorComponentFrom: colorString start: 3 length: 1];
                break;
            case 6: // #RRGGBB
                alpha = 1.0f;
                red   = [self colorComponentFrom: colorString start: 0 length: 2];
                green = [self colorComponentFrom: colorString start: 2 length: 2];
                blue  = [self colorComponentFrom: colorString start: 4 length: 2];
                break;
            case 8: // #AARRGGBB
                alpha = [self colorComponentFrom: colorString start: 0 length: 2];
                red   = [self colorComponentFrom: colorString start: 2 length: 2];
                green = [self colorComponentFrom: colorString start: 4 length: 2];
                blue  = [self colorComponentFrom: colorString start: 6 length: 2];
                break;
            default:
                return nil;
                break;
        }
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    } @catch (NSException *exception) {
        return UIColor.whiteColor;
    }
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

/**
 *int code; //返回码
 String message; //描述
 String innerCode; //内层返回码
 String innerDesc; //内层事件描述
 String token; //token
 */
+(NSDictionary *)completeResultToJson:(CLCompleteResult *)completeResult{
    NSMutableDictionary * result = [NSMutableDictionary new];
    if (completeResult.error != nil) {
        result[@"code"] = @(completeResult.code);
        result[@"message"] = completeResult.message;
        if (completeResult.innerCode != 0) {
            result[@"innerCode"] = @(completeResult.innerCode);
        }
        if ([completeResult.innerDesc isKindOfClass:NSString.class] && completeResult.innerDesc.length > 0) {
            result[@"innerDesc"] = completeResult.innerDesc;
        }
    }else{
        result[@"code"] = @(1000);
        result[@"message"] = completeResult.message;
        if (completeResult.innerCode != 0) {
            result[@"innerCode"] = @(completeResult.innerCode);
        }
        if ([completeResult.innerDesc isKindOfClass:NSString.class] && completeResult.innerDesc.length > 0) {
            result[@"innerDesc"] = completeResult.innerDesc;
        }
        if ([completeResult.data isKindOfClass:NSDictionary.class] && completeResult.data.count > 0) {
            result[@"token"] = completeResult.data[@"token"];
        }
    }
    return result;
}

-(NSString * )assetPathWithConfig:(NSString *)configureDicPath{
    NSString * key = [self.registrar lookupKeyForAsset:configureDicPath];
    NSString * path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
    if (path == nil) {
        path = @"";
    }
    return path;
}

//自定义控件事件
-(void)customButtonClicked:(UIButton *)sender{
    
    NSMutableDictionary * result = [NSMutableDictionary new];
    result[@"widgetId"] = sender.widgetId;
    result[@"isFinish"] = @(sender.isFinish);
    if (self.channel) {
        [self.channel invokeMethod:@"onReceiveClickWidgetEvent" arguments:result];
    }
    

    if (sender.isFinish) {
        [CLShanYanSDKManager finishAuthControllerCompletion:nil];
    }
}

+(void)setConstraint:(UIView * )superView targetView:(UIView *)subView contrains:(NSDictionary * )dict{
    
    @try {
        NSNumber * clLayoutLeft = dict[@"left"];
        NSNumber * clLayoutTop = dict[@"top"];
        NSNumber * clLayoutRight = dict[@"right"];
        NSNumber * clLayoutBottom = dict[@"bottom"];
        NSNumber * clLayoutWidth = dict[@"width"];
        NSNumber * clLayoutHeight = dict[@"height"];
        NSNumber * clLayoutCenterX = dict[@"centerX"];
        NSNumber * clLayoutCenterY = dict[@"centerY"];
        
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        
        if (clLayoutWidth != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:clLayoutWidth.floatValue];
            c.active = YES;
        }
        
        if (clLayoutHeight != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:clLayoutHeight.floatValue];
            c.active = YES;
        }
        
        if (clLayoutLeft != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:clLayoutLeft.floatValue];
            c.active = YES;
        }
        
        if (clLayoutTop != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0f constant:clLayoutTop.floatValue];
            c.active = YES;
        }
        
        if (clLayoutRight != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0f constant:clLayoutRight.clShanYanNegative.floatValue];
            c.active = YES;
        }
        
        if (clLayoutBottom != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:clLayoutBottom.clShanYanNegative.floatValue];
            c.active = YES;
        }
        
        if (clLayoutCenterX != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:clLayoutCenterX.floatValue];
            c.active = YES;
        }
        
        if (clLayoutCenterY != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:clLayoutCenterY.floatValue];
            c.active = YES;
        }
        
        [superView updateConstraintsIfNeeded];
    } @catch (NSException *exception) {
        
    }
}


- (void)finishAuthControllerCompletion:(FlutterResult)completion{
    [CLShanYanSDKManager finishAuthControllerAnimated:YES
                                           Completion:^{
                                               if (completion) {
                                                   completion(nil);
                                               }
                                           }];
}


-(void)startAuthentication:(FlutterResult)authenticationListener{
    [CLShanYanSDKManager mobileCheckWithLocalPhoneNumberComplete:^(CLCompleteResult * _Nonnull completeResult) {
        if (authenticationListener) {
            authenticationListener([ShanyanPlugin completeResultToJson:completeResult]);
        }
    }];
}


// 获取栈顶 UIViewController
- (UIViewController *)findVisibleVC {
    UIViewController *visibleVc = nil;
    UIWindow *visibleWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (!window.hidden && !visibleWindow) {
            visibleWindow = window;
        }
        if ([UIWindow instancesRespondToSelector:@selector(rootViewController)]) {
            if ([window rootViewController]) {
                visibleVc = window.rootViewController;
                break;
            }
        }
    }
    
    return visibleVc ?: [[UIApplication sharedApplication].delegate window].rootViewController;
}
@end
