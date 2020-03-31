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
    
    baseUIConfigure.clAuthTypeUseWindow = @(NO);
    baseUIConfigure.manualDismiss = @(YES);
    baseUIConfigure.shouldAutorotate = @(NO);
    baseUIConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationPortrait);
    baseUIConfigure.clNavigationBarHidden = @(YES);
    baseUIConfigure.clNavBackBtnAlimentRight = @(YES);
    
    baseUIConfigure.clPhoneNumberColor = UIColor.blackColor;
    baseUIConfigure.clPhoneNumberFont = [UIFont boldSystemFontOfSize:25];
    
    baseUIConfigure.clLoginBtnText = @"一键登录";
    baseUIConfigure.clLoginBtnTextFont = [UIFont systemFontOfSize:14];
    baseUIConfigure.clLoadingBackgroundColor = [UIColor colorWithRed:69/255.0 green:162/255.0 blue:238/255.0 alpha:1];
    baseUIConfigure.clLoginBtnTextColor = UIColor.whiteColor;
    
    CGFloat wibdowCenterYOffset = 80;
    CGFloat wibdowHeight = 400;
    
    CGFloat windowTop = (screenHeight_Portrait - wibdowHeight)*0.5 - wibdowCenterYOffset;
    
    CGFloat tipLabeltop = 20;
    CGFloat tipLabelHeight = 20;

    CGFloat phonetop = 20;
    CGFloat phoneHeight = 20;
    
    CGFloat logButtontop = 20;
    CGFloat logButtonHeight = 20;
    
    CGFloat otherWaytop = 20;
    CGFloat otherWayHeight = 20;
    
    
    //授权页自定义控件
    __weak typeof(self)weakSelf = self;
    baseUIConfigure.customAreaView = ^(UIView * _Nonnull customAreaView) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;

            customAreaView.backgroundColor = UIColor.clearColor;
            
            //白色圆角背景
            UIView * whiteBGView = [[UIView alloc]init];
            whiteBGView.layer.cornerRadius = 10;
            whiteBGView.layer.masksToBounds = YES;
            whiteBGView.backgroundColor = UIColor.whiteColor;
            [customAreaView addSubview:whiteBGView];
            NSDictionary * whiteBGViewContraint = @{
                @"left":@(20),
                @"right":@(-20),
                @"height":@(260),
                @"centerY":@(-wibdowCenterYOffset),
            };
            [ShanyanPlugin setConstraint:customAreaView targetView:whiteBGView contrains:whiteBGViewContraint];

            UILabel * tipLabel = [[UILabel alloc]init];
            tipLabel.text = @"本机号码";
            tipLabel.font = [UIFont systemFontOfSize:18];
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tipLabel.textColor = UIColor.blackColor;
            [customAreaView addSubview:tipLabel];
            NSDictionary * tipLabelContraint = @{
                @"top":@(20),
                @"left":@(00),
                @"height":@(20),
                @"right":@(0),
            };
            [ShanyanPlugin setConstraint:customAreaView targetView:tipLabel contrains:tipLabelContraint];
            
            UIButton * otherWay = [[UIButton alloc]init];
            [otherWay.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [otherWay setTitleColor:[UIColor colorWithRed:69/255.0 green:162/255.0 blue:238/255.0 alpha:1] forState:(UIControlStateNormal)];
            [otherWay setTitle:@"去验证码登录" forState:(UIControlStateNormal)];
            otherWay.widgetId = @"Button_20200331_otherLoginButton";
            [otherWay addTarget:strongSelf action:@selector(customButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            [whiteBGView addSubview:otherWay];
            NSDictionary * otherWayContraint = @{
                @"left":@(0),
                @"right":@(0),
                @"height":@(45),
                @"bottom":@(0),
            };
            [ShanyanPlugin setConstraint:customAreaView targetView:otherWay contrains:otherWayContraint];

            UIButton * cancelButton = [[UIButton alloc]init];
            [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [cancelButton setTitleColor:[UIColor colorWithRed:69/255.0 green:162/255.0 blue:238/255.0 alpha:1] forState:(UIControlStateNormal)];
            [cancelButton setImage:[UIImage imageNamed:@"back" inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdk_oauth" ofType:@"bundle"]] compatibleWithTraitCollection:nil] forState:(UIControlStateNormal)];
            cancelButton.widgetId = @"Button_20200331_cancelButton";
            [cancelButton addTarget:strongSelf action:@selector(customButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            [whiteBGView addSubview:cancelButton];
            NSDictionary * cancelButtonContraint = @{
                @"top":@(10),
                @"right":@(-15),
                @"height":@(45),
                @"width":@(45),
            };
            [ShanyanPlugin setConstraint:customAreaView targetView:cancelButton contrains:cancelButtonContraint];
//                    NSNumber * clLayoutLeft = dict[@"left"];
//                    NSNumber * clLayoutTop = dict[@"top"];
//                    NSNumber * clLayoutRight = dict[@"right"];
//                    NSNumber * clLayoutBottom = dict[@"bottom"];
//                    NSNumber * clLayoutWidth = dict[@"width"];
//                    NSNumber * clLayoutHeight = dict[@"height"];
//                    NSNumber * clLayoutCenterX = dict[@"centerX"];
//                    NSNumber * clLayoutCenterY = dict[@"centerY"];

        });
    };
    

    
     //布局-竖屏
    CLOrientationLayOut * clOrientationLayOutPortrait = [CLOrientationLayOut new];
    
   clOrientationLayOutPortrait.clLayoutPhoneTop = @(windowTop + tipLabeltop + tipLabelHeight + phonetop);
   clOrientationLayOutPortrait.clLayoutPhoneHeight = @(phoneHeight);
   clOrientationLayOutPortrait.clLayoutPhoneLeft = @(40);
   clOrientationLayOutPortrait.clLayoutPhoneRight = @(-40);
    
    //一键登录按钮垂直居中，其他控件以此参考竖直位置
    clOrientationLayOutPortrait.clLayoutLoginBtnTop = @(clOrientationLayOutPortrait.clLayoutPhoneTop.floatValue + phoneHeight + logButtontop);
    clOrientationLayOutPortrait.clLayoutLoginBtnHeight = @(logButtonHeight);
    clOrientationLayOutPortrait.clLayoutLoginBtnLeft = @(30);
    clOrientationLayOutPortrait.clLayoutLoginBtnRight = @(-30);
    
//    clOrientationLayOutPortrait.clLayoutSloganTop = @( screenHeight_Portrait*0.5 + clOrientationLayOutPortrait.clLayoutLoginBtnHeight.floatValue*0.5 + 15 + 40 + 15);//给切换帐号保留空间
//    clOrientationLayOutPortrait.clLayoutSloganLeft = @(0);
//    clOrientationLayOutPortrait.clLayoutSloganRight = @(0);
//    clOrientationLayOutPortrait.clLayoutSloganHeight = @(15);
    
//    clOrientationLayOutPortrait.clLayoutAppPrivacyTop = @(clOrientationLayOutPortrait.clLayoutSloganTop.floatValue + 15 + 5);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyLeft = @(60);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyRight = @(-40);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyHeight = @(60*screenScale);
    
    

//
//    clOrientationLayOutPortrait.clLayoutLoginBtnTop= @(clOrientationLayOutPortrait.clLayoutPhoneTop.floatValue + clOrientationLayOutPortrait.clLayoutPhoneHeight.floatValue + 20*screenScale);
//    clOrientationLayOutPortrait.clLayoutLoginBtnHeight = @(40*screenScale);
//    clOrientationLayOutPortrait.clLayoutLoginBtnLeft = @(20*screenScale);
//    clOrientationLayOutPortrait.clLayoutLoginBtnRight = @(-20*screenScale);
//
//    clOrientationLayOutPortrait.clLayoutAppPrivacyLeft = @(40*screenScale);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyRight = @(-40*screenScale);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyBottom = @(-offSetY_Portrait_bottom);
//    clOrientationLayOutPortrait.clLayoutAppPrivacyHeight = @(60*screenScale);
//
//    clOrientationLayOutPortrait.clLayoutSloganLeft = @(0);
//    clOrientationLayOutPortrait.clLayoutSloganRight = @(0);
//    clOrientationLayOutPortrait.clLayoutSloganHeight = @(15);
//    clOrientationLayOutPortrait.clLayoutSloganBottom = @(clOrientationLayOutPortrait.clLayoutAppPrivacyBottom.floatValue - clOrientationLayOutPortrait.clLayoutAppPrivacyHeight.floatValue);
    
    
    baseUIConfigure.clOrientationLayOutPortrait = clOrientationLayOutPortrait;
    
    return baseUIConfigure;
}

+(NSString * )dictToJson:(NSDictionary *)input{
    NSError *error = nil;
    NSData *jsonData = nil;
    if (!input) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [input enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyString = nil;
        NSString *valueString = nil;
        if ([key isKindOfClass:[NSString class]]) {
            keyString = key;
        }else{
            keyString = [NSString stringWithFormat:@"%@",key];
        }

        if ([obj isKindOfClass:[NSString class]]) {
            valueString = obj;
        }else{
            valueString = [NSString stringWithFormat:@"%@",obj];
        }

        [dict setObject:valueString forKey:keyString];
    }];
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] == 0 || error != nil) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;

}

+ (UIFont *)fontWithSize:(NSNumber *)size blod:(NSNumber *)isBlod name:(NSString *)name{
    if (size == nil) {
        return nil;
    }
//    NSString * fontName = @"PingFang-SC-Medium";
//    if (name) {
//        fontName = fontName;
//    }
    BOOL blod = isBlod ? isBlod.boolValue : false;
    if (blod) {
        return [UIFont boldSystemFontOfSize:size.floatValue];
    }else{
        return [UIFont systemFontOfSize:size.floatValue];
    }
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

-(CLShanYanCustomViewCongifure *)customViewConfigureWithDict:(NSDictionary *)clCustomDict{
    
    if (clCustomDict == nil) {
        return nil;
    }

    @try {
            
            CLShanYanCustomViewCongifure * customViewConfigure = [[CLShanYanCustomViewCongifure alloc]init];
            
        //    NSString * widgetId = clCustomDict[@"widgetId"];
        ////    customViewConfigure.widgetId = widgetId;
        //
        //    NSNumber * isFinish = clCustomDict[@"isFinish"];
        //    if (isFinish) {
        ////        customViewConfigure.isFinish = isFinish.boolValue;
        //    }
            
            /**文字颜色*/
            UIColor  * clTextColor = [ShanyanPlugin colorWithHexStr:clCustomDict[@"textColor"]];
            if (clTextColor) {
                customViewConfigure.button_textColor = clTextColor;
                customViewConfigure.label_textColor = clTextColor;
            }
            NSNumber   * textFont = clCustomDict[@"textFont"];
            if (textFont) {
                customViewConfigure.button_titleLabelFont = [UIFont systemFontOfSize:textFont.floatValue];
                customViewConfigure.label_font = [UIFont systemFontOfSize:textFont.floatValue];
            }
            NSString * textContent = clCustomDict[@"textContent"];
            if (textContent) {
                customViewConfigure.button_textContent = textContent;
                customViewConfigure.label_text = textContent;
            }
            
            NSNumber * numberOfLines = clCustomDict[@"numberOfLines"];
            if (customViewConfigure) {
                customViewConfigure.button_numberOfLines = numberOfLines;
                customViewConfigure.label_numberOfLines = numberOfLines;
            }
            
            NSString * clButtonImage = clCustomDict[@"image"];
            if (clButtonImage) {
                //UIButton
                customViewConfigure.button_image = [UIImage imageNamed:clButtonImage];
                //UIImageView
                customViewConfigure.imageView_image = [UIImage imageNamed:clButtonImage];
            }
            
            
            NSString * clButtonBackgroundImage = clCustomDict[@"backgroundImgPath"];
            if (clButtonBackgroundImage) {
                customViewConfigure.button_backgroundImage = [UIImage imageNamed:clButtonBackgroundImage];
            }

            
            //UIView通用
            UIColor * backgroundColor = [ShanyanPlugin colorWithHexStr: clCustomDict[@"backgroundColor"]];
            if (backgroundColor) {
                customViewConfigure.backgroundColor = backgroundColor;
            }
            
            //UILabel
            NSNumber * textAlignment = clCustomDict[@"textAlignment"];
            if (textAlignment) {
                customViewConfigure.label_textAlignment = textAlignment;
            }
        
            //CALayer通用
            NSNumber * cornerRadius = clCustomDict[@"cornerRadius"];
//            NSNumber * masksToBounds =  clCustomDict[@"masksToBounds"];
            if (cornerRadius) {
                customViewConfigure.layer_cornerRadius = cornerRadius;
                customViewConfigure.layer_masksToBounds = @(YES);
            }
//            if (masksToBounds) {
//                customViewConfigure.layer_masksToBounds = masksToBounds;
//            }
            
            
            return customViewConfigure;
    } @catch (NSException *exception) {
        
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


-(CLOrientationLayOut *)clOrientationLayOutPortraitWithConfigure:(NSDictionary *)layOutPortraitDict{
    if (layOutPortraitDict == nil) {
        return CLOrientationLayOut.clDefaultOrientationLayOut;
    }
    
    CLOrientationLayOut * clOrientationLayOutPortrait = [CLOrientationLayOut new];
    
    NSNumber * clLayoutLogoLeft     = layOutPortraitDict[@"setLogoLeft"];
    NSNumber * clLayoutLogoTop      = layOutPortraitDict[@"setLogoTop"];
    NSNumber * clLayoutLogoRight    = layOutPortraitDict[@"setLogoRight"];
    NSNumber * clLayoutLogoBottom   = layOutPortraitDict[@"setLogoBottom"];
    NSNumber * clLayoutLogoWidth    = layOutPortraitDict[@"setLogoWidth"];
    NSNumber * clLayoutLogoHeight   = layOutPortraitDict[@"setLogoHeight"];
    NSNumber * clLayoutLogoCenterX  = layOutPortraitDict[@"setLogoCenterX"];
    NSNumber * clLayoutLogoCenterY  = layOutPortraitDict[@"setLogoCenterY"];
    
    clOrientationLayOutPortrait.clLayoutLogoLeft = clLayoutLogoLeft;
    clOrientationLayOutPortrait.clLayoutLogoTop = clLayoutLogoTop;
    clOrientationLayOutPortrait.clLayoutLogoRight = clLayoutLogoRight.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutLogoBottom = clLayoutLogoBottom.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutLogoWidth = clLayoutLogoWidth;
    clOrientationLayOutPortrait.clLayoutLogoHeight = clLayoutLogoHeight;
    clOrientationLayOutPortrait.clLayoutLogoCenterX = clLayoutLogoCenterX;
    clOrientationLayOutPortrait.clLayoutLogoCenterY = clLayoutLogoCenterY;

    /**手机号显示控件*/
    //layout 约束均相对vc.view
    NSNumber * clLayoutPhoneLeft    = layOutPortraitDict[@"setNumFieldLeft"];;
    NSNumber * clLayoutPhoneTop     = layOutPortraitDict[@"setNumFieldTop"];;
    NSNumber * clLayoutPhoneRight   = layOutPortraitDict[@"setNumFieldRight"];;
    NSNumber * clLayoutPhoneBottom  = layOutPortraitDict[@"setNumFieldBottom"];;
    NSNumber * clLayoutPhoneWidth   = layOutPortraitDict[@"setNumFieldWidth"];;
    NSNumber * clLayoutPhoneHeight  = layOutPortraitDict[@"setNumFieldHeight"];;
    NSNumber * clLayoutPhoneCenterX = layOutPortraitDict[@"setNumFieldCenterX"];;
    NSNumber * clLayoutPhoneCenterY = layOutPortraitDict[@"setNumFieldCenterY"];;
    clOrientationLayOutPortrait.clLayoutPhoneLeft = clLayoutPhoneLeft;
    clOrientationLayOutPortrait.clLayoutPhoneTop = clLayoutPhoneTop;
    clOrientationLayOutPortrait.clLayoutPhoneRight = clLayoutPhoneRight.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutPhoneBottom = clLayoutPhoneBottom.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutPhoneWidth = clLayoutPhoneWidth;
    clOrientationLayOutPortrait.clLayoutPhoneHeight = clLayoutPhoneHeight;
    clOrientationLayOutPortrait.clLayoutPhoneCenterX = clLayoutPhoneCenterX;
    clOrientationLayOutPortrait.clLayoutPhoneCenterY = clLayoutPhoneCenterY;
    /*一键登录按钮 控件
     注： 一键登录授权按钮 不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutLoginBtnLeft     = layOutPortraitDict[@"setLogBtnLeft"];
    NSNumber * clLayoutLoginBtnTop      = layOutPortraitDict[@"setLogBtnTop"];
    NSNumber * clLayoutLoginBtnRight    = layOutPortraitDict[@"setLogBtnRight"];
    NSNumber * clLayoutLoginBtnBottom   = layOutPortraitDict[@"setLogBtnBottom"];
    NSNumber * clLayoutLoginBtnWidth    = layOutPortraitDict[@"setLogBtnWidth"];
    NSNumber * clLayoutLoginBtnHeight   = layOutPortraitDict[@"setLogBtnHeight"];
    NSNumber * clLayoutLoginBtnCenterX  = layOutPortraitDict[@"setLogBtnCenterX"];
    NSNumber * clLayoutLoginBtnCenterY  = layOutPortraitDict[@"setLogBtnCenterY"];
    clOrientationLayOutPortrait.clLayoutLoginBtnLeft = clLayoutLoginBtnLeft;
    clOrientationLayOutPortrait.clLayoutLoginBtnTop = clLayoutLoginBtnTop;
    clOrientationLayOutPortrait.clLayoutLoginBtnRight = clLayoutLoginBtnRight.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutLoginBtnBottom = clLayoutLoginBtnBottom.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutLoginBtnWidth = clLayoutLoginBtnWidth;
    clOrientationLayOutPortrait.clLayoutLoginBtnHeight = clLayoutLoginBtnHeight;
    clOrientationLayOutPortrait.clLayoutLoginBtnCenterX = clLayoutLoginBtnCenterX;
    clOrientationLayOutPortrait.clLayoutLoginBtnCenterY = clLayoutLoginBtnCenterY;
    /*隐私条款Privacy
     注： 运营商隐私条款 不得隐藏， 用户条款不限制
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutAppPrivacyLeft   = layOutPortraitDict[@"setPrivacyLeft"];
    NSNumber * clLayoutAppPrivacyTop    = layOutPortraitDict[@"setPrivacyTop"];
    NSNumber * clLayoutAppPrivacyRight  = layOutPortraitDict[@"setPrivacyRight"];
    NSNumber * clLayoutAppPrivacyBottom = layOutPortraitDict[@"setPrivacyBottom"];
    NSNumber * clLayoutAppPrivacyWidth  = layOutPortraitDict[@"setPrivacyWidth"];
    NSNumber * clLayoutAppPrivacyHeight = layOutPortraitDict[@"setPrivacyHeight"];
    NSNumber * clLayoutAppPrivacyCenterX= layOutPortraitDict[@"setPrivacyCenterX"];
    NSNumber * clLayoutAppPrivacyCenterY= layOutPortraitDict[@"setPrivacyCenterY"];
    clOrientationLayOutPortrait.clLayoutAppPrivacyLeft = clLayoutAppPrivacyLeft;
    clOrientationLayOutPortrait.clLayoutAppPrivacyTop = clLayoutAppPrivacyTop;
    clOrientationLayOutPortrait.clLayoutAppPrivacyRight = clLayoutAppPrivacyRight.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutAppPrivacyBottom = clLayoutAppPrivacyBottom.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutAppPrivacyWidth = clLayoutAppPrivacyWidth;
    clOrientationLayOutPortrait.clLayoutAppPrivacyHeight = clLayoutAppPrivacyHeight;
    clOrientationLayOutPortrait.clLayoutAppPrivacyCenterX = clLayoutAppPrivacyCenterX;
    clOrientationLayOutPortrait.clLayoutAppPrivacyCenterY = clLayoutAppPrivacyCenterY;
    /*Slogan 运营商品牌标签："认证服务由中国移动/联通/电信提供" label
     注： 运营商品牌标签，不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutSloganLeft   = layOutPortraitDict[@"setSloganLeft"];
    NSNumber * clLayoutSloganTop    = layOutPortraitDict[@"setSloganTop"];
    NSNumber * clLayoutSloganRight  = layOutPortraitDict[@"setSloganRight"];
    NSNumber * clLayoutSloganBottom = layOutPortraitDict[@"setSloganBottom"];
    NSNumber * clLayoutSloganWidth  = layOutPortraitDict[@"setSloganWidth"];
    NSNumber * clLayoutSloganHeight = layOutPortraitDict[@"setSloganHeight"];
    NSNumber * clLayoutSloganCenterX= layOutPortraitDict[@"setSloganCenterX"];
    NSNumber * clLayoutSloganCenterY= layOutPortraitDict[@"setSloganCenterY"];
    clOrientationLayOutPortrait.clLayoutSloganLeft = clLayoutSloganLeft;
    clOrientationLayOutPortrait.clLayoutSloganTop = clLayoutSloganTop;
    clOrientationLayOutPortrait.clLayoutSloganRight = clLayoutSloganRight.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutSloganBottom = clLayoutSloganBottom.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutSloganWidth = clLayoutSloganWidth;
    clOrientationLayOutPortrait.clLayoutSloganHeight = clLayoutSloganHeight;
    clOrientationLayOutPortrait.clLayoutSloganCenterX = clLayoutSloganCenterX;
    clOrientationLayOutPortrait.clLayoutSloganCenterY = clLayoutSloganCenterY;
    
    /*ShanYanSlogan 运营商品牌标签："认证服务由中国移动/联通/电信提供" label
     注： 运营商品牌标签，不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutShanYanSloganLeft   = layOutPortraitDict[@"setShanYanSloganLeft"];
    NSNumber * clLayoutShanYanSloganTop    = layOutPortraitDict[@"setShanYanSloganTop"];
    NSNumber * clLayoutShanYanSloganRight  = layOutPortraitDict[@"setShanYanSloganRight"];
    NSNumber * clLayoutShanYanSloganBottom = layOutPortraitDict[@"setShanYanSloganBottom"];
    NSNumber * clLayoutShanYanSloganWidth  = layOutPortraitDict[@"setShanYanSloganWidth"];
    NSNumber * clLayoutShanYanSloganHeight = layOutPortraitDict[@"setShanYanSloganHeight"];
    NSNumber * clLayoutShanYanSloganCenterX= layOutPortraitDict[@"setShanYanSloganCenterX"];
    NSNumber * clLayoutShanYanSloganCenterY= layOutPortraitDict[@"setShanYanSloganCenterY"];
    clOrientationLayOutPortrait.clLayoutShanYanSloganLeft = clLayoutShanYanSloganLeft;
    clOrientationLayOutPortrait.clLayoutShanYanSloganTop = clLayoutShanYanSloganTop;
    clOrientationLayOutPortrait.clLayoutShanYanSloganRight = clLayoutShanYanSloganRight.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutShanYanSloganBottom = clLayoutShanYanSloganBottom.clShanYanNegative;
    clOrientationLayOutPortrait.clLayoutShanYanSloganWidth = clLayoutShanYanSloganWidth;
    clOrientationLayOutPortrait.clLayoutShanYanSloganHeight = clLayoutShanYanSloganHeight;
    clOrientationLayOutPortrait.clLayoutShanYanSloganCenterX = clLayoutShanYanSloganCenterX;
    clOrientationLayOutPortrait.clLayoutShanYanSloganCenterY = clLayoutShanYanSloganCenterY;
    
    /**窗口模式*/
    /**窗口中心：CGPoint X Y*/
    NSNumber * clAuthWindowOrientationCenterX = layOutPortraitDict[@"setAuthWindowOrientationCenterX"];
    NSNumber * clAuthWindowOrientationCenterY = layOutPortraitDict[@"setAuthWindowOrientationCenterY"];
    if (clAuthWindowOrientationCenterX && clAuthWindowOrientationCenterY) {
        clOrientationLayOutPortrait.clAuthWindowOrientationCenter = [NSValue valueWithCGPoint:CGPointMake(clAuthWindowOrientationCenterX.floatValue, clAuthWindowOrientationCenterY.floatValue)];
    }
    
    /**窗口左上角：frame.origin：CGPoint X Y*/
    NSNumber * clAuthWindowOrientationOriginX = layOutPortraitDict[@"setAuthWindowOrientationOriginX"];
    NSNumber * clAuthWindowOrientationOriginY = layOutPortraitDict[@"setAuthWindowOrientationOriginY"];
    if (clAuthWindowOrientationCenterX && clAuthWindowOrientationOriginY) {
        clOrientationLayOutPortrait.clAuthWindowOrientationOrigin = [NSValue valueWithCGPoint:CGPointMake(clAuthWindowOrientationOriginX.floatValue, clAuthWindowOrientationOriginY.floatValue)];
    }
    /**窗口大小：宽 float */
    NSNumber * clAuthWindowOrientationWidth = layOutPortraitDict[@"setAuthWindowOrientationWidth"];
    {
        clOrientationLayOutPortrait.clAuthWindowOrientationWidth = clAuthWindowOrientationWidth;
    }
    /**窗口大小：高 float */
    NSNumber * clAuthWindowOrientationHeight= layOutPortraitDict[@"setAuthWindowOrientationHeight"];
    {
        clOrientationLayOutPortrait.clAuthWindowOrientationHeight = clAuthWindowOrientationHeight;
    }
    return clOrientationLayOutPortrait;
}

-(CLOrientationLayOut *)clOrientationLayOutLandscapeWithConfigure:(NSDictionary *)layOutLandscapeDict{
    if (layOutLandscapeDict == nil) {
        return CLOrientationLayOut.clDefaultOrientationLayOut;
    }
    
    CLOrientationLayOut * clOrientationLayOutLandscape = [CLOrientationLayOut new];
    
    NSNumber * clLayoutLogoLeft     = layOutLandscapeDict[@"clLayoutLogoLeft"];
    NSNumber * clLayoutLogoTop      = layOutLandscapeDict[@"clLayoutLogoTop"];
    NSNumber * clLayoutLogoRight    = layOutLandscapeDict[@"clLayoutLogoRight"];
    NSNumber * clLayoutLogoBottom   = layOutLandscapeDict[@"clLayoutLogoBottom"];
    NSNumber * clLayoutLogoWidth    = layOutLandscapeDict[@"clLayoutLogoWidth"];
    NSNumber * clLayoutLogoHeight   = layOutLandscapeDict[@"clLayoutLogoHeight"];
    NSNumber * clLayoutLogoCenterX  = layOutLandscapeDict[@"clLayoutLogoCenterX"];
    NSNumber * clLayoutLogoCenterY  = layOutLandscapeDict[@"clLayoutLogoCenterY"];
    
    clOrientationLayOutLandscape.clLayoutLogoLeft = clLayoutLogoLeft;
    clOrientationLayOutLandscape.clLayoutLogoTop = clLayoutLogoTop;
    clOrientationLayOutLandscape.clLayoutLogoRight = clLayoutLogoRight.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutLogoBottom = clLayoutLogoBottom.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutLogoWidth = clLayoutLogoWidth;
    clOrientationLayOutLandscape.clLayoutLogoHeight = clLayoutLogoHeight;
    clOrientationLayOutLandscape.clLayoutLogoCenterX = clLayoutLogoCenterX;
    clOrientationLayOutLandscape.clLayoutLogoCenterY = clLayoutLogoCenterY;
    
    /**手机号显示控件*/
    //layout 约束均相对vc.view
    NSNumber * clLayoutPhoneLeft    = layOutLandscapeDict[@"clLayoutPhoneLeft"];;
    NSNumber * clLayoutPhoneTop     = layOutLandscapeDict[@"clLayoutPhoneTop"];;
    NSNumber * clLayoutPhoneRight   = layOutLandscapeDict[@"clLayoutPhoneRight"];;
    NSNumber * clLayoutPhoneBottom  = layOutLandscapeDict[@"clLayoutPhoneBottom"];;
    NSNumber * clLayoutPhoneWidth   = layOutLandscapeDict[@"clLayoutPhoneWidth"];;
    NSNumber * clLayoutPhoneHeight  = layOutLandscapeDict[@"clLayoutPhoneHeight"];;
    NSNumber * clLayoutPhoneCenterX = layOutLandscapeDict[@"clLayoutPhoneCenterX"];;
    NSNumber * clLayoutPhoneCenterY = layOutLandscapeDict[@"clLayoutPhoneCenterY"];;
    clOrientationLayOutLandscape.clLayoutPhoneLeft = clLayoutPhoneLeft;
    clOrientationLayOutLandscape.clLayoutPhoneTop = clLayoutPhoneTop;
    clOrientationLayOutLandscape.clLayoutPhoneRight = clLayoutPhoneRight.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutPhoneBottom = clLayoutPhoneBottom.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutPhoneWidth = clLayoutPhoneWidth;
    clOrientationLayOutLandscape.clLayoutPhoneHeight = clLayoutPhoneHeight;
    clOrientationLayOutLandscape.clLayoutPhoneCenterX = clLayoutPhoneCenterX;
    clOrientationLayOutLandscape.clLayoutPhoneCenterY = clLayoutPhoneCenterY;
    /*一键登录按钮 控件
     注： 一键登录授权按钮 不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutLoginBtnLeft     = layOutLandscapeDict[@"clLayoutLoginBtnLeft"];
    NSNumber * clLayoutLoginBtnTop      = layOutLandscapeDict[@"clLayoutLoginBtnTop"];
    NSNumber * clLayoutLoginBtnRight    = layOutLandscapeDict[@"clLayoutLoginBtnRight"];
    NSNumber * clLayoutLoginBtnBottom   = layOutLandscapeDict[@"clLayoutLoginBtnBottom"];
    NSNumber * clLayoutLoginBtnWidth    = layOutLandscapeDict[@"clLayoutLoginBtnWidth"];
    NSNumber * clLayoutLoginBtnHeight   = layOutLandscapeDict[@"clLayoutLoginBtnHeight"];
    NSNumber * clLayoutLoginBtnCenterX  = layOutLandscapeDict[@"clLayoutLoginBtnCenterX"];
    NSNumber * clLayoutLoginBtnCenterY  = layOutLandscapeDict[@"clLayoutLoginBtnCenterY"];
    clOrientationLayOutLandscape.clLayoutLoginBtnLeft = clLayoutLoginBtnLeft;
    clOrientationLayOutLandscape.clLayoutLoginBtnTop = clLayoutLoginBtnTop;
    clOrientationLayOutLandscape.clLayoutLoginBtnRight = clLayoutLoginBtnRight.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutLoginBtnBottom = clLayoutLoginBtnBottom.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutLoginBtnWidth = clLayoutLoginBtnWidth;
    clOrientationLayOutLandscape.clLayoutLoginBtnHeight = clLayoutLoginBtnHeight;
    clOrientationLayOutLandscape.clLayoutLoginBtnCenterX = clLayoutLoginBtnCenterX;
    clOrientationLayOutLandscape.clLayoutLoginBtnCenterY = clLayoutLoginBtnCenterY;
    /*隐私条款Privacy
     注： 运营商隐私条款 不得隐藏， 用户条款不限制
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutAppPrivacyLeft   = layOutLandscapeDict[@"clLayoutAppPrivacyLeft"];
    NSNumber * clLayoutAppPrivacyTop    = layOutLandscapeDict[@"clLayoutAppPrivacyTop"];
    NSNumber * clLayoutAppPrivacyRight  = layOutLandscapeDict[@"clLayoutAppPrivacyRight"];
    NSNumber * clLayoutAppPrivacyBottom = layOutLandscapeDict[@"clLayoutAppPrivacyBottom"];
    NSNumber * clLayoutAppPrivacyWidth  = layOutLandscapeDict[@"clLayoutAppPrivacyWidth"];
    NSNumber * clLayoutAppPrivacyHeight = layOutLandscapeDict[@"clLayoutAppPrivacyHeight"];
    NSNumber * clLayoutAppPrivacyCenterX= layOutLandscapeDict[@"clLayoutAppPrivacyCenterX"];
    NSNumber * clLayoutAppPrivacyCenterY= layOutLandscapeDict[@"clLayoutAppPrivacyCenterY"];
    clOrientationLayOutLandscape.clLayoutAppPrivacyLeft = clLayoutAppPrivacyLeft;
    clOrientationLayOutLandscape.clLayoutAppPrivacyTop = clLayoutAppPrivacyTop;
    clOrientationLayOutLandscape.clLayoutAppPrivacyRight = clLayoutAppPrivacyRight.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutAppPrivacyBottom = clLayoutAppPrivacyBottom.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutAppPrivacyWidth = clLayoutAppPrivacyWidth;
    clOrientationLayOutLandscape.clLayoutAppPrivacyHeight = clLayoutAppPrivacyHeight;
    clOrientationLayOutLandscape.clLayoutAppPrivacyCenterX = clLayoutAppPrivacyCenterX;
    clOrientationLayOutLandscape.clLayoutAppPrivacyCenterY = clLayoutAppPrivacyCenterY;
    /*Slogan 运营商品牌标签："认证服务由中国移动/联通/电信提供" label
     注： 运营商品牌标签，不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutSloganLeft   = layOutLandscapeDict[@"clLayoutSloganLeft"];
    NSNumber * clLayoutSloganTop    = layOutLandscapeDict[@"clLayoutSloganTop"];
    NSNumber * clLayoutSloganRight  = layOutLandscapeDict[@"clLayoutSloganRight"];
    NSNumber * clLayoutSloganBottom = layOutLandscapeDict[@"clLayoutSloganBottom"];
    NSNumber * clLayoutSloganWidth  = layOutLandscapeDict[@"clLayoutSloganWidth"];
    NSNumber * clLayoutSloganHeight = layOutLandscapeDict[@"clLayoutSloganHeight"];
    NSNumber * clLayoutSloganCenterX= layOutLandscapeDict[@"clLayoutSloganCenterX"];
    NSNumber * clLayoutSloganCenterY= layOutLandscapeDict[@"clLayoutSloganCenterY"];
    clOrientationLayOutLandscape.clLayoutSloganLeft = clLayoutSloganLeft;
    clOrientationLayOutLandscape.clLayoutSloganTop = clLayoutSloganTop;
    clOrientationLayOutLandscape.clLayoutSloganRight = clLayoutSloganRight.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutSloganBottom = clLayoutSloganBottom.clShanYanNegative;
    clOrientationLayOutLandscape.clLayoutSloganWidth = clLayoutSloganWidth;
    clOrientationLayOutLandscape.clLayoutSloganHeight = clLayoutSloganHeight;
    clOrientationLayOutLandscape.clLayoutSloganCenterX = clLayoutSloganCenterX;
    clOrientationLayOutLandscape.clLayoutSloganCenterY = clLayoutSloganCenterY;

    /**窗口模式*/
    /**窗口中心：CGPoint X Y*/
    NSNumber * clAuthWindowOrientationCenterX = layOutLandscapeDict[@"clAuthWindowOrientationCenterX"];
    NSNumber * clAuthWindowOrientationCenterY = layOutLandscapeDict[@"clAuthWindowOrientationCenterY"];
    if (clAuthWindowOrientationCenterX && clAuthWindowOrientationCenterX) {
        clOrientationLayOutLandscape.clAuthWindowOrientationCenter = [NSValue valueWithCGPoint:CGPointMake(clAuthWindowOrientationCenterX.floatValue, clAuthWindowOrientationCenterY.floatValue)];
    }
    
    /**窗口左上角：frame.origin：CGPoint X Y*/
    NSNumber * clAuthWindowOrientationOriginX = layOutLandscapeDict[@"clAuthWindowOrientationOriginX"];
    NSNumber * clAuthWindowOrientationOriginY = layOutLandscapeDict[@"clAuthWindowOrientationOriginY"];
    if (clAuthWindowOrientationCenterX && clAuthWindowOrientationOriginY) {
        clOrientationLayOutLandscape.clAuthWindowOrientationOrigin = [NSValue valueWithCGPoint:CGPointMake(clAuthWindowOrientationOriginX.floatValue, clAuthWindowOrientationOriginY.floatValue)];
    }
    /**窗口大小：宽 float */
    NSNumber * clAuthWindowOrientationWidth = layOutLandscapeDict[@"clAuthWindowOrientationWidth"];
    {
        clOrientationLayOutLandscape.clAuthWindowOrientationWidth = clAuthWindowOrientationWidth;
    }
    /**窗口大小：高 float */
    NSNumber * clAuthWindowOrientationHeight= layOutLandscapeDict[@"clAuthWindowOrientationHeight"];
    {
        clOrientationLayOutLandscape.clAuthWindowOrientationHeight = clAuthWindowOrientationHeight;
    }
    return clOrientationLayOutLandscape;
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
