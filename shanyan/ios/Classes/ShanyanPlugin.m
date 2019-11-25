#import "ShanyanPlugin.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
//Helpers
#import "CLShanYanCustomViewHelper.h"
#import "UIView+CLShanYanWidget.h"

@interface ShanyanPlugin ()
@property (nonatomic,strong)id notifObserver;
@property (nonatomic,copy)FlutterResult openLoginAuthListener;
@property (nonatomic,copy)FlutterResult oneKeyLoginListener;
@property (nonatomic,copy)FlutterResult customInterface ;
@property(nonatomic,weak)NSObject<FlutterPluginRegistrar>*registrar;
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
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)init:(FlutterMethodCall*)call complete:(FlutterResult)complete{
    
    NSDictionary * argv = call.arguments;
    if (argv == nil || ![argv isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString * appId = argv[@"appId"];
    NSString * appKey = argv[@"appkey"];

    [CLShanYanSDKManager initWithAppId:appId AppKey:appKey complete:^(CLCompleteResult * _Nonnull completeResult) {
        
        if (complete) {
            
            NSMutableDictionary * result = [NSMutableDictionary new];
            
            
            if (completeResult.error) {
                result[@"code"] = @(completeResult.error.code);
                if (completeResult.error.userInfo != nil && completeResult.error.userInfo.count > 0) {
                    result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.error.userInfo];
                }else if (completeResult.error.domain != nil){
                    result[@"result"] = completeResult.error.domain;
                }else{
                    result[@"result"] = completeResult.message;
                }
            }else{
                result[@"code"] = @(1000);
                if (completeResult.data != nil  && completeResult.data.count > 0) {
                    result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.data];
                }else{
                    result[@"result"] = completeResult.message;
                }
            }
            complete(result);
        }
    }];
}

- (void)preGetPhonenumber:(FlutterResult)complete{
    
    [CLShanYanSDKManager preGetPhonenumber:^(CLCompleteResult * _Nonnull completeResult) {
        
        NSLog(@"%@",completeResult.message);
        
        if (complete) {
            
            NSMutableDictionary * result = [NSMutableDictionary new];
                       
                       
                       if (completeResult.error) {
                           result[@"code"] = @(completeResult.error.code);
                           if (completeResult.error.userInfo != nil && completeResult.error.userInfo.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.error.userInfo];
                           }else if (completeResult.error.domain != nil){
                               result[@"result"] = completeResult.error.domain;
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }else{
                           result[@"code"] = @(1022);
                           if (completeResult.data != nil  && completeResult.data.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.data];
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }
                       complete(result);
        }
    }];
}

-(void)openLoginAuthListener:(FlutterResult)openLoginAuthListener{
    self.oneKeyLoginListener = nil;
    self.openLoginAuthListener = openLoginAuthListener;
}
-(void)oneKeyLoginListener:(FlutterResult)oneKeyLoginListener{
    self.oneKeyLoginListener = nil;
    self.oneKeyLoginListener = oneKeyLoginListener;
}

-(void)quickAuthLoginWithConfigure:(NSDictionary *)clUIConfigure{
    
    CLUIConfigure * baseUIConfigure = [self configureWithConfig:clUIConfigure];
    baseUIConfigure.viewController = [self findVisibleVC];;
    baseUIConfigure.manualDismiss = @(YES);
    
    [CLShanYanSDKManager quickAuthLoginWithConfigure:baseUIConfigure openLoginAuthListener:^(CLCompleteResult * _Nonnull completeResult) {
        
        NSLog(@"%@",completeResult.message);
    
                    NSMutableDictionary * result = [NSMutableDictionary new];
                       
                       
                       if (completeResult.error) {
                           result[@"code"] = @(completeResult.error.code);
                           if (completeResult.error.userInfo != nil && completeResult.error.userInfo.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.error.userInfo];
                           }else if (completeResult.error.domain != nil){
                               result[@"result"] = completeResult.error.domain;
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }else{
                           result[@"code"] = @(1000);
                           if (completeResult.data != nil  && completeResult.data.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.data];
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }
            if (self.openLoginAuthListener) {
                self.openLoginAuthListener(result);
                self.openLoginAuthListener = nil;
            }
    } oneKeyLoginListener:^(CLCompleteResult * _Nonnull completeResult) {
            NSMutableDictionary * result = [NSMutableDictionary new];
                       
                       
                       if (completeResult.error) {
                           result[@"code"] = @(completeResult.error.code);
                           if (completeResult.error.userInfo != nil && completeResult.error.userInfo.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.error.userInfo];
                           }else if (completeResult.error.domain != nil){
                               result[@"result"] = completeResult.error.domain;
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }else{
                           result[@"code"] = @(1000);
                           if (completeResult.data != nil  && completeResult.data.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.data];
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }
            if (self.oneKeyLoginListener) {
                self.oneKeyLoginListener(result);
                self.oneKeyLoginListener = nil;
            }
    }];
}

-(NSString * )assetPathWithConfig:(NSString *)configureDicPath{
    NSString * key = [self.registrar lookupKeyForAsset:configureDicPath];
    NSString * path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
    return path;
}

-(CLUIConfigure *)configureWithConfig:(NSDictionary *)configureDic{
    
    
    
    CLUIConfigure * baseConfigure = [CLUIConfigure new];

    @try {
    
        NSString * clBackgroundImg = configureDic[@"clBackgroundImg"];
        {

            NSData * clBackgroundImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clBackgroundImg]]];
            UIImage * clBackgroundImg_value = [UIImage imageWithData:clBackgroundImgData];
            baseConfigure.clBackgroundImg = clBackgroundImg_value;
        }
        
        NSNumber * clNavigationBarHidden = configureDic[@"clNavigationBarHidden"];
        {
            baseConfigure.clNavigationBarHidden = clNavigationBarHidden;
        }
        NSNumber * clNavigationBackgroundClear = configureDic[@"clNavigationBackgroundClear"];
        {
            baseConfigure.clNavigationBackgroundClear = clNavigationBackgroundClear;
        }
        
        NSAttributedString * clNavigationAttributesTitleText;
        UIBarButtonItem * clNavigationRightControl;
        UIBarButtonItem * clNavigationLeftControl;
        
        NSString   * clNavigationBackBtnImage = configureDic[@"clNavigationBackBtnImage"];
        {
            NSData * clNavigationBackBtnImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clNavigationBackBtnImage]]];
            UIImage * clNavigationBackBtnImage_value = [UIImage imageWithData:clNavigationBackBtnImageData];
            baseConfigure.clNavigationBackBtnImage = clNavigationBackBtnImage_value;
        }
        
        NSNumber  * clNavigationBackBtnHidden = configureDic[@"clNavigationBackBtnHidden"];
        {
            baseConfigure.clNavigationBackBtnHidden = clNavigationBackBtnHidden;
        }
        NSValue * clNavBackBtnImageInsets;
        NSNumber * clNavBackBtnAlimentRight = configureDic[@"clNavBackBtnAlimentRight"];
        {
            baseConfigure.clNavBackBtnAlimentRight = clNavBackBtnAlimentRight;
        };;
        NSNumber * clNavigationBottomLineHidden = configureDic[@"clNavigationBottomLineHidden"];
        {
            baseConfigure.clNavigationBottomLineHidden = clNavigationBottomLineHidden;
        }
        NSArray  * clNavigationTintColor  = configureDic[@"clNavigationTintColor"];;
        {
            if (clNavigationTintColor && clNavigationTintColor.count == 4) {
                baseConfigure.clNavigationTintColor = [UIColor colorWithRed:[clNavigationTintColor[0] floatValue] green:[clNavigationTintColor[1] floatValue] blue:[clNavigationTintColor[2] floatValue] alpha:[clNavigationTintColor[3] floatValue]];
            }
        };
        NSArray  * clNavigationBarTintColor = configureDic[@"clNavigationBarTintColor"];;
        {
            if (clNavigationBarTintColor && clNavigationBarTintColor.count == 4) {
                baseConfigure.clNavigationBarTintColor = [UIColor colorWithRed:[clNavigationBarTintColor[0] floatValue] green:[clNavigationBarTintColor[1] floatValue] blue:[clNavigationBarTintColor[2] floatValue] alpha:[clNavigationBarTintColor[3] floatValue]];
            }
        };
        NSString  * clNavigationBackgroundImage = configureDic[@"clNavigationBackgroundImage"];
        {
            NSData * clNavigationBackgroundImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clNavigationBackgroundImage]]];
            UIImage * clNavigationBackgroundImage_value = [UIImage imageWithData:clNavigationBackgroundImageData];
            baseConfigure.clNavigationBackgroundImage = clNavigationBackgroundImage_value;
        };
        NSNumber * clNavigationBarMetrics = configureDic[@"clNavigationBarMetrics"];
        {
            baseConfigure.clNavigationBarMetrics = clNavigationBarMetrics;
        };
        NSString  * clNavigationShadowImage = configureDic[@"clNavigationShadowImage"];
        {
            NSData * clNavigationShadowImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clNavigationShadowImage]]];
            UIImage * clNavigationShadowImage_value = [UIImage imageWithData:clNavigationShadowImageData];
            baseConfigure.clNavigationShadowImage = clNavigationShadowImage_value;
        };
        NSNumber * clNavigationBarStyle = configureDic[@"clNavigationBarStyle"];
        {
            baseConfigure.clNavigationBarStyle = clNavigationBarStyle;
        };
        
        /**Logo*/
        NSString * clLogoImage = configureDic[@"clLogoImage"];
        {
            NSData * clLogoImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clLogoImage]]];
            UIImage * clLogoImage_value = [UIImage imageWithData:clLogoImageData];
            baseConfigure.clLogoImage = clLogoImage_value;
        }
        NSNumber * clLogoCornerRadius = configureDic[@"clLogoCornerRadius"];
        {
            baseConfigure.clLogoCornerRadius = clLogoCornerRadius;
        };
        NSNumber * clLogoHiden  = configureDic[@"clLogoHiden"];
        {
            baseConfigure.clLogoHiden = clLogoHiden;
        };
        
        NSArray  * clPhoneNumberColor  = configureDic[@"clPhoneNumberColor"];;
        {
            if (clPhoneNumberColor && clPhoneNumberColor.count == 4) {
                baseConfigure.clPhoneNumberColor = [UIColor colorWithRed:[clPhoneNumberColor[0] floatValue] green:[clPhoneNumberColor[1] floatValue] blue:[clPhoneNumberColor[2] floatValue] alpha:[clPhoneNumberColor[3] floatValue]];
            }
        };
        
        NSNumber   * clPhoneNumberFont = configureDic[@"clPhoneNumberFont"];
        {
            if (clPhoneNumberFont) {
                baseConfigure.clPhoneNumberFont = [UIFont systemFontOfSize:clPhoneNumberFont.floatValue];
            }
        };
        NSNumber * clPhoneNumberTextAlignment = configureDic[@"clPhoneNumberTextAlignment"];
        {
            //0: center 1: left 2: right
            if (clPhoneNumberTextAlignment) {
                switch (clPhoneNumberTextAlignment.integerValue) {
                    case 0:
                        baseConfigure.clPhoneNumberTextAlignment = @(NSTextAlignmentCenter);
                        break;
                    case 1:
                        baseConfigure.clPhoneNumberTextAlignment = @(NSTextAlignmentLeft);
                        break;
                    case 2:
                        baseConfigure.clPhoneNumberTextAlignment = @(NSTextAlignmentRight);
                        break;
                    default:
                        break;
                }
            }
        };
        
        /**按钮文字*/
        NSString   * clLoginBtnText = configureDic[@"clLoginBtnText"];
        {
            baseConfigure.clLoginBtnText = clLoginBtnText;
        }
        /**按钮文字颜色*/
        NSArray  * clLoginBtnTextColor = configureDic[@"clLoginBtnTextColor"];;
        {
            if (clLoginBtnTextColor && clLoginBtnTextColor.count == 4) {
                baseConfigure.clLoginBtnTextColor = [UIColor colorWithRed:[clLoginBtnTextColor[0] floatValue] green:[clLoginBtnTextColor[1] floatValue] blue:[clLoginBtnTextColor[2] floatValue] alpha:[clLoginBtnTextColor[3] floatValue]];
            }
        }
        /**按钮背景颜色*/
        NSArray  * clLoginBtnBgColor = configureDic[@"clLoginBtnBgColor"];;
        {
            if (clLoginBtnBgColor && clLoginBtnBgColor.count == 4) {
                baseConfigure.clLoginBtnBgColor = [UIColor colorWithRed:[clLoginBtnBgColor[0] floatValue] green:[clLoginBtnBgColor[1] floatValue] blue:[clLoginBtnBgColor[2] floatValue] alpha:[clLoginBtnBgColor[3] floatValue]];
            }
        }
        /**按钮文字字体*/
        NSNumber   * clLoginBtnTextFont = configureDic[@"clLoginBtnTextFont"];
        {
            if (clLoginBtnTextFont) {
                baseConfigure.clLoginBtnTextFont = [UIFont systemFontOfSize:clLoginBtnTextFont.floatValue];
            }
        }
        
        /**按钮背景图片*/
        NSString  * clLoginBtnNormalBgImage = configureDic[@"clLoginBtnNormalBgImage"];
        {
            NSData * clLoginBtnNormalBgImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clLoginBtnNormalBgImage]]];
            UIImage * clLoginBtnNormalBgImage_value = [UIImage imageWithData:clLoginBtnNormalBgImageData];
            baseConfigure.clLoginBtnNormalBgImage = clLoginBtnNormalBgImage_value;
        };
        /**按钮背景高亮图片*/
        NSString  * clLoginBtnHightLightBgImage = configureDic[@"clLoginBtnHightLightBgImage"];
        {
            NSData * clLoginBtnHightLightBgImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clLoginBtnHightLightBgImage]]];
            UIImage * clLoginBtnHightLightBgImage_value = [UIImage imageWithData:clLoginBtnHightLightBgImageData];
            baseConfigure.clLoginBtnHightLightBgImage = clLoginBtnHightLightBgImage_value;
        };
        /**按钮边框颜色*/
        NSArray  * clLoginBtnBorderColor = configureDic[@"clLoginBtnBorderColor"];;
        {
            if (clLoginBtnBorderColor && clLoginBtnBorderColor.count == 4) {
                baseConfigure.clLoginBtnBgColor = [UIColor colorWithRed:[clLoginBtnBorderColor[0] floatValue] green:[clLoginBtnBorderColor[1] floatValue] blue:[clLoginBtnBorderColor[2] floatValue] alpha:[clLoginBtnBorderColor[3] floatValue]];
            }
        };
        /**按钮圆角 CGFloat eg.@(5)*/
        NSNumber * clLoginBtnCornerRadius = configureDic[@"clLoginBtnCornerRadius"];
        {
            baseConfigure.clLoginBtnCornerRadius = clLoginBtnCornerRadius;
        }
        /**按钮边框 CGFloat eg.@(2.0)*/
        NSNumber * clLoginBtnBorderWidth = configureDic[@"clLoginBtnBorderWidth"];;
        {
            baseConfigure.clLoginBtnBorderWidth = clLoginBtnBorderWidth;
        }
        /*隐私条款Privacy
         注： 运营商隐私条款 不得隐藏
         用户条款不限制
         **/
        /**隐私条款名称颜色：@[基础文字颜色UIColor*,条款颜色UIColor*] eg.@[[UIColor lightGrayColor],[UIColor greenColor]]*/
        NSArray<NSArray*> *clAppPrivacyColor = configureDic[@"clAppPrivacyColor"];
        {
            if (clAppPrivacyColor && clAppPrivacyColor.count == 2) {
                NSArray * commomTextColors = clAppPrivacyColor.firstObject;
                NSArray * appPrivacyColors = clAppPrivacyColor.lastObject;
                
                if (commomTextColors && commomTextColors.count == 4 && appPrivacyColors && appPrivacyColors.count == 4) {
                    UIColor * commomTextColor = [UIColor colorWithRed:[commomTextColors[0] floatValue] green:[commomTextColors[1] floatValue] blue:[commomTextColors[2] floatValue] alpha:[commomTextColors[3] floatValue]];
                    UIColor * appPrivacyColor = [UIColor colorWithRed:[appPrivacyColors[0] floatValue] green:[appPrivacyColors[1] floatValue] blue:[appPrivacyColors[2] floatValue] alpha:[appPrivacyColors[3] floatValue]];
                    if (commomTextColor && appPrivacyColor) {
                        baseConfigure.clAppPrivacyColor = @[commomTextColor,appPrivacyColor];
                    }
                }
            }
        }
        /**隐私条款文字字体*/
        NSNumber  * clAppPrivacyTextFont = configureDic[@"clAppPrivacyTextFont"];
        {
            if (clAppPrivacyTextFont) {
                baseConfigure.clAppPrivacyTextFont = [UIFont systemFontOfSize:clAppPrivacyTextFont.floatValue];
            }
        };
        /**隐私条款文字对齐方式 NSTextAlignment eg.@(NSTextAlignmentCenter)*/
        NSNumber * clAppPrivacyTextAlignment = configureDic[@"clAppPrivacyTextAlignment"];;
        {
            //0: center 1: left 2: right
            if (clAppPrivacyTextAlignment) {
                switch (clAppPrivacyTextAlignment.integerValue) {
                    case 0:
                        baseConfigure.clAppPrivacyTextAlignment = @(NSTextAlignmentCenter);
                        break;
                    case 1:
                        baseConfigure.clAppPrivacyTextAlignment = @(NSTextAlignmentLeft);
                        break;
                    case 2:
                        baseConfigure.clAppPrivacyTextAlignment = @(NSTextAlignmentRight);
                        break;
                    default:
                        break;
                }
            }
            
        };
        /**运营商隐私条款书名号 默认NO 不显示 BOOL eg.@(YES)*/
        NSNumber * clAppPrivacyPunctuationMarks = configureDic[@"clAppPrivacyPunctuationMarks"];;
        {
            baseConfigure.clAppPrivacyPunctuationMarks = clAppPrivacyPunctuationMarks;
        };
        /**多行时行距 CGFloat eg.@(2.0)*/
        NSNumber* clAppPrivacyLineSpacing = configureDic[@"clAppPrivacyLineSpacing"];;
        {
            baseConfigure.clAppPrivacyLineSpacing = clAppPrivacyLineSpacing;
        };
        /**是否需要sizeToFit,设置后与宽高约束的冲突请自行考虑 BOOL eg.@(YES)*/
        NSNumber* clAppPrivacyNeedSizeToFit = configureDic[@"clAppPrivacyNeedSizeToFit"];;
        {
            baseConfigure.clAppPrivacyNeedSizeToFit = clAppPrivacyNeedSizeToFit;
        };
        /**隐私条款--APP名称简写 默认取CFBundledisplayname 设置描述文本四后此属性无效*/
        NSString  * clAppPrivacyAbbreviatedName = configureDic[@"clAppPrivacyAbbreviatedName"];;
        {
            baseConfigure.clAppPrivacyAbbreviatedName = clAppPrivacyAbbreviatedName;
        };
        /*
         *隐私条款Y一:需同时设置Name和UrlString eg.@[@"条款一名称",条款一URL]
         *@[NSSting,NSURL];
         */
        NSArray * clAppPrivacyFirst = configureDic[@"clAppPrivacyFirst"];
        {
            if (clAppPrivacyFirst && clAppPrivacyFirst.count == 2) {
                NSString * name = clAppPrivacyFirst.firstObject;
                NSString * url = clAppPrivacyFirst.lastObject;
                baseConfigure.clAppPrivacyFirst = @[name,[NSURL URLWithString:url]];
            }
        }
        /*
         *隐私条款二:需同时设置Name和UrlString eg.@[@"条款一名称",条款一URL]
         *@[NSSting,NSURL];
         */
        NSArray * clAppPrivacySecond = configureDic[@"clAppPrivacySecond"];
        {
            if (clAppPrivacySecond && clAppPrivacySecond.count == 2) {
                baseConfigure.clAppPrivacySecond = clAppPrivacySecond;
            }
        };
        /*
         隐私协议文本拼接: DesTextFirst+运营商条款+DesTextSecond+隐私条款一+DesTextThird+隐私条款二+DesTextFourth
         **/
        /**描述文本一 default:"同意"*/
        NSString *clAppPrivacyNormalDesTextFirst = configureDic[@"clAppPrivacyNormalDesTextFirst"];;
        {
            baseConfigure.clAppPrivacyNormalDesTextFirst = clAppPrivacyNormalDesTextFirst;
        };;
        /**描述文本二 default:"和"*/
        NSString *clAppPrivacyNormalDesTextSecond = configureDic[@"clAppPrivacyNormalDesTextSecond"];;
        {
            baseConfigure.clAppPrivacyNormalDesTextSecond = clAppPrivacyNormalDesTextSecond;
        };;
        /**描述文本三 default:"、"*/
        NSString *clAppPrivacyNormalDesTextThird = configureDic[@"clAppPrivacyNormalDesTextThird"];;
        {
            baseConfigure.clAppPrivacyNormalDesTextThird = clAppPrivacyNormalDesTextThird;
        };;
        /**描述文本四 default: "并授权AppName使用认证服务"*/
        NSString *clAppPrivacyNormalDesTextFourth = configureDic[@"clAppPrivacyNormalDesTextFourth"];;
        {
            baseConfigure.clAppPrivacyNormalDesTextFourth = clAppPrivacyNormalDesTextFourth;
        };
        /**用户隐私协议WEB页面导航栏标题 默认显示用户条款名称*/
        NSAttributedString * clAppPrivacyWebAttributesTitle;
        /**运营商隐私协议WEB页面导航栏标题 默认显示运营商条款名称*/
        NSAttributedString * clAppPrivacyWebNormalAttributesTitle;
        /**隐私协议WEB页面导航返回按钮图片*/
        NSString * clAppPrivacyWebBackBtnImage = configureDic[@"clAppPrivacyWebBackBtnImage"];;;
        {
            NSData * clAppPrivacyWebBackBtnImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clAppPrivacyWebBackBtnImage]]];
            UIImage * clAppPrivacyWebBackBtnImage_value = [UIImage imageWithData:clAppPrivacyWebBackBtnImageData];
            baseConfigure.clAppPrivacyWebBackBtnImage = clAppPrivacyWebBackBtnImage_value;
        }
        
        /*SLOGAN
         注： 运营商品牌标签("中国**提供认证服务")，不得隐藏
         **/
        /**slogan文字字体*/
        NSNumber   * clSloganTextFont = configureDic[@"clSloganTextFont"];
        {
            if (clSloganTextFont) {
                baseConfigure.clSloganTextFont = [UIFont systemFontOfSize:clSloganTextFont.floatValue];
            }
        };;
        /**slogan文字颜色*/
        NSArray  * clSloganTextColor = configureDic[@"clSloganTextColor"];;
        {
            if (clSloganTextColor && clSloganTextColor.count == 4) {
                baseConfigure.clSloganTextColor = [UIColor colorWithRed:[clSloganTextColor[0] floatValue] green:[clSloganTextColor[1] floatValue] blue:[clSloganTextColor[2] floatValue] alpha:[clSloganTextColor[3] floatValue]];
            }
        };
        /**slogan文字对齐方式 NSTextAlignment eg.@(NSTextAlignmentCenter)*/
        NSNumber * clSlogaTextAlignment = configureDic[@"clSlogaTextAlignment"];;
        {
            //0: center 1: left 2: right
            if (clSlogaTextAlignment) {
                switch (clSlogaTextAlignment.integerValue) {
                    case 0:
                        baseConfigure.clSlogaTextAlignment = @(NSTextAlignmentCenter);
                        break;
                    case 1:
                        baseConfigure.clSlogaTextAlignment = @(NSTextAlignmentLeft);
                        break;
                    case 2:
                        baseConfigure.clSlogaTextAlignment = @(NSTextAlignmentRight);
                        break;
                    default:
                        break;
                }
            }
        };
        
        
        /*CheckBox
         *协议勾选框，默认选中且在协议前显示
         *可在sdk_oauth.bundle中替换checkBox_unSelected、checkBox_selected图片
         *也可以通过属性设置选中和未选择图片
         **/
        /**协议勾选框（默认显示,放置在协议之前）BOOL eg.@(YES)*/
        NSNumber *clCheckBoxHidden = configureDic[@"clCheckBoxHidden"];;
        {
            baseConfigure.clCheckBoxHidden = clCheckBoxHidden;
        };
        /**协议勾选框默认值（默认不选中）BOOL eg.@(YES)*/
        NSNumber *clCheckBoxValue = configureDic[@"clCheckBoxValue"];;
        {
            baseConfigure.clCheckBoxValue = clCheckBoxValue;
        };
        /**协议勾选框 尺寸 NSValue->CGSize eg.[NSValue valueWithCGSize:CGSizeMake(25, 25)]*/
        NSArray *clCheckBoxSize = configureDic[@"clCheckBoxSize"];
        {
            if (clCheckBoxSize && clCheckBoxSize.count == 2) {
                CGFloat width = [clCheckBoxSize.firstObject floatValue];
                CGFloat height = [clCheckBoxSize.lastObject floatValue];
                baseConfigure.clCheckBoxSize = [NSValue valueWithCGSize:CGSizeMake(width, height)];
            }
        }
        /**协议勾选框 UIButton.image图片缩进 UIEdgeInset eg.[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)]*/
        NSArray *clCheckBoxImageEdgeInsets = configureDic[@"clCheckBoxImageEdgeInsets"];
        {
            if (clCheckBoxImageEdgeInsets && clCheckBoxImageEdgeInsets.count == 4) {
                CGFloat top = [clCheckBoxImageEdgeInsets[0] floatValue];
                CGFloat left = [clCheckBoxImageEdgeInsets[1]  floatValue];
                CGFloat bottom = [clCheckBoxImageEdgeInsets[2]  floatValue];
                CGFloat right = [clCheckBoxImageEdgeInsets[3]  floatValue];
                baseConfigure.clCheckBoxImageEdgeInsets = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
            }
        }
        /**协议勾选框 设置CheckBox顶部与隐私协议控件顶部对齐 YES或大于0生效 eg.@(YES)*/
        NSNumber *clCheckBoxVerticalAlignmentToAppPrivacyTop = configureDic[@"clCheckBoxVerticalAlignmentToAppPrivacyTop"];;
        {
            baseConfigure.clCheckBoxVerticalAlignmentToAppPrivacyTop = clCheckBoxVerticalAlignmentToAppPrivacyTop;
        };
        /**协议勾选框 设置CheckBox顶部与隐私协议控件竖向中心对齐 YES或大于0生效 eg.@(YES)*/
        NSNumber *clCheckBoxVerticalAlignmentToAppPrivacyCenterY = configureDic[@"clCheckBoxVerticalAlignmentToAppPrivacyCenterY"];
        {
            baseConfigure.clCheckBoxVerticalAlignmentToAppPrivacyCenterY = clCheckBoxVerticalAlignmentToAppPrivacyCenterY;
        };
        /**协议勾选框 非选中状态图片*/
        NSString  *clCheckBoxUncheckedImage = configureDic[@"clCheckBoxUncheckedImage"];
        {
            NSData * clCheckBoxUncheckedImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clCheckBoxUncheckedImage]]];
            UIImage * clCheckBoxUncheckedImage_value = [UIImage imageWithData:clCheckBoxUncheckedImageData];
            baseConfigure.clCheckBoxUncheckedImage = clCheckBoxUncheckedImage_value;
        };
        /**协议勾选框 选中状态图片*/
        NSString  *clCheckBoxCheckedImage = configureDic[@"clCheckBoxCheckedImage"];
        {
            NSData * clCheckBoxCheckedImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clCheckBoxCheckedImage]]];
            UIImage * clCheckBoxCheckedImage_value = [UIImage imageWithData:clCheckBoxCheckedImageData];
            baseConfigure.clCheckBoxCheckedImage = clCheckBoxCheckedImage_value;
        };
        
        /*Loading*/
        /**Loading 大小 CGSize eg.[NSValue valueWithCGSize:CGSizeMake(50, 50)]*/
        NSArray *clLoadingSize = configureDic[@"clLoadingSize"];
        {
            if (clLoadingSize && clLoadingSize.count == 2) {
                CGFloat width = [clLoadingSize.firstObject floatValue];
                CGFloat height = [clLoadingSize.lastObject floatValue];
                baseConfigure.clLoadingSize = [NSValue valueWithCGSize:CGSizeMake(width, height)];
            }
        };
        /**Loading 圆角 float eg.@(5) */
        NSNumber *clLoadingCornerRadius = configureDic[@"clLoadingCornerRadius"];
        {
            baseConfigure.clLoadingCornerRadius = clLoadingCornerRadius;
        };
        /**Loading 背景色 UIColor eg.[UIColor colorWithRed:0.8 green:0.5 blue:0.8 alpha:0.8]; */
        NSArray *clLoadingBackgroundColor = configureDic[@"clLoadingBackgroundColor"];;
        {
            if (clLoadingBackgroundColor && clLoadingBackgroundColor.count == 4) {
                baseConfigure.clLoadingBackgroundColor = [UIColor colorWithRed:[clLoadingBackgroundColor[0] floatValue] green:[clLoadingBackgroundColor[1] floatValue] blue:[clLoadingBackgroundColor[2] floatValue] alpha:[clLoadingBackgroundColor[3] floatValue]];
            }
        };
        /**UIActivityIndicatorViewStyle eg.@(UIActivityIndicatorViewStyleWhiteLarge)*/
    //    NSNumber *clLoadingIndicatorStyle = configureDic[@"clLoadingIndicatorStyle"];
    //    {
    //        baseConfigure.clLoadingIndicatorStyle = clLoadingIndicatorStyle;
    //    };
        baseConfigure.clLoadingIndicatorStyle = @(UIActivityIndicatorViewStyleWhite);
        
        /**Loading Indicator渲染色 UIColor eg.[UIColor greenColor]; */
        NSArray *clLoadingTintColor = configureDic[@"clLoadingTintColor"];;
        {
            if (clLoadingTintColor && clLoadingTintColor.count == 4) {
                baseConfigure.clLoadingTintColor = [UIColor colorWithRed:[clLoadingTintColor[0] floatValue] green:[clLoadingTintColor[1] floatValue] blue:[clLoadingTintColor[2] floatValue] alpha:[clLoadingTintColor[3] floatValue]];
            }
        };
        
        /**横竖屏*/
        /*是否支持自动旋转 BOOL*/
        NSNumber * shouldAutorotate = configureDic[@"shouldAutorotate"];
        {
            baseConfigure.shouldAutorotate = shouldAutorotate;
        };
        /*支持方向 UIInterfaceOrientationMask
         - 如果设置只支持竖屏，只需设置clOrientationLayOutPortrait竖屏布局对象
         - 如果设置只支持横屏，只需设置clOrientationLayOutLandscape横屏布局对象
         - 横竖屏均支持，需同时设置clOrientationLayOutPortrait和clOrientationLayOutLandscape
         */
        NSNumber * supportedInterfaceOrientations = configureDic[@"supportedInterfaceOrientations"];
        {
            /**支持方向
             * 0:UIInterfaceOrientationMaskPortrait
             * 1:UIInterfaceOrientationMaskLandscapeLeft
             * 2:UIInterfaceOrientationMaskLandscapeRight
             * 3:UIInterfaceOrientationMaskPortraitUpsideDown
             * 4:UIInterfaceOrientationMaskLandscape
             * 5:UIInterfaceOrientationMaskAll
             * 6:UIInterfaceOrientationMaskAllButUpsideDown
             * */
            if (supportedInterfaceOrientations) {
                switch (supportedInterfaceOrientations.integerValue) {
                    case 0:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskPortrait);
                        break;
                    case 1:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskLandscapeLeft);
                        break;
                    case 2:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskLandscapeRight);
                        break;
                    case 3:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskPortraitUpsideDown);
                        break;
                    case 4:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskLandscape);
                        break;
                    case 5:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskAll);
                        break;
                    case 6:
                        baseConfigure.supportedInterfaceOrientations = @(UIInterfaceOrientationMaskAllButUpsideDown);
                        break;
                    default:
                        break;
                }
            }
        };
        /*默认方向 UIInterfaceOrientation*/
        NSNumber * preferredInterfaceOrientationForPresentation = configureDic[@"preferredInterfaceOrientationForPresentation"];
        {
            /**偏好方向
             * -1:UIInterfaceOrientationUnknown
             * 0:UIInterfaceOrientationPortrait
             * 1:UIInterfaceOrientationPortraitUpsideDown
             * 2:UIInterfaceOrientationLandscapeLeft
             * 3:UIInterfaceOrientationLandscapeRight
             * */
            //偏好方向默认Portrait preferredInterfaceOrientationForPresentation: Number(5),
            if (preferredInterfaceOrientationForPresentation) {
                switch (preferredInterfaceOrientationForPresentation.integerValue) {
                    case -1:
                        baseConfigure.preferredInterfaceOrientationForPresentation = @(UIInterfaceOrientationUnknown);
                        break;
                    case 0:
                        baseConfigure.preferredInterfaceOrientationForPresentation = @(UIInterfaceOrientationPortrait);
                        break;
                    case 1:
                        baseConfigure.preferredInterfaceOrientationForPresentation = @(UIInterfaceOrientationPortraitUpsideDown);
                        break;
                    case 2:
                        baseConfigure.preferredInterfaceOrientationForPresentation = @(UIInterfaceOrientationLandscapeLeft);
                        break;
                    case 3:
                        baseConfigure.preferredInterfaceOrientationForPresentation = @(UIInterfaceOrientationLandscapeRight);
                        break;
                    default:
                        break;
                }
            }
        };
        
        /**以窗口方式显示授权页
         */
        /**以窗口方式显示 BOOL, default is NO */
        NSNumber * clAuthTypeUseWindow  = configureDic[@"clAuthTypeUseWindow"];
        {
            baseConfigure.clAuthTypeUseWindow = clAuthTypeUseWindow;
        };
        /**窗口圆角 float*/
        NSNumber * clAuthWindowCornerRadius = configureDic[@"clAuthWindowCornerRadius"];
        {
            baseConfigure.clAuthWindowCornerRadius = clAuthWindowCornerRadius;
        };
        
        /**clAuthWindowModalTransitionStyle系统自带的弹出方式 仅支持以下三种
         UIModalTransitionStyleCoverVertical 底部弹出
         UIModalTransitionStyleCrossDissolve 淡入
         UIModalTransitionStyleFlipHorizontal 翻转显示
         */
        NSNumber * clAuthWindowModalTransitionStyle = configureDic[@"clAuthWindowModalTransitionStyle"];
        {
            baseConfigure.clAuthWindowModalTransitionStyle = clAuthWindowModalTransitionStyle;
        };
        
        /**弹窗的MaskLayer，用于自定义窗口形状*/
        CALayer * clAuthWindowMaskLayer;
        
        NSDictionary * clOrientationLayOutPortraitDict = configureDic[@"clOrientationLayOutPortrait"];
        NSDictionary * clOrientationLayOutLandscapeDict = configureDic[@"clOrientationLayOutLandscape"];

        CLOrientationLayOut * clOrientationLayOutPortrait = [self clOrientationLayOutPortraitWithConfigure:clOrientationLayOutPortraitDict];
        
        CLOrientationLayOut * clOrientationLayOutLandscape = [self clOrientationLayOutLandscapeWithConfigure:clOrientationLayOutLandscapeDict];
        
        baseConfigure.clOrientationLayOutPortrait = clOrientationLayOutPortrait;
        baseConfigure.clOrientationLayOutLandscape = clOrientationLayOutLandscape;
    
        //自定义控件
        NSDictionary * clCustomViewDicts = configureDic[@"widgets"];
        if (clCustomViewDicts) {
            
            
            //导航栏控件
            for (NSDictionary * clCustomDict in clCustomViewDicts.allValues) {
                NSString * type = clCustomDict[@"type"];
                NSString * navPosition = clCustomDict[@"navPosition"];
                if ([navPosition isEqualToString:@"navleft"] || [navPosition isEqualToString:@"navright"]) {
                    //导航栏控件
                    
                    NSString * widgetId = clCustomDict[@"widgetId"];
                    NSNumber * isFinish = clCustomDict[@"isFinish"];
                    
                    CLShanYanCustomViewCongifure * customViewConfigure = [self customViewConfigureWithDict:clCustomDict];
                    
                    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]init];
                    
                    if ([type isEqualToString:@"TextView"]) {
                        
                        UILabel * customLabel = [CLShanYanCustomViewHelper customLabelWithCongifure:customViewConfigure];
                        
                        customLabel.widgetId = widgetId;

                        NSNumber * clLayoutWidth = clCustomDict[@"clLayoutWidth"];
                        NSNumber * clLayoutHeight = clCustomDict[@"clLayoutHeight"];
                        
                        customLabel.frame = CGRectMake(0, 0, clLayoutWidth.floatValue, clLayoutHeight.floatValue);
                        
                        [barButtonItem setCustomView:customLabel];
                                                                
                    }else if ([type isEqualToString:@"ImageView"]){
                        
                        UIImageView * customImageView = [CLShanYanCustomViewHelper customImageViewWithCongifure:customViewConfigure];
                        
                        customImageView.widgetId = widgetId;

                        NSNumber * clLayoutWidth = clCustomDict[@"clLayoutWidth"];
                        NSNumber * clLayoutHeight = clCustomDict[@"clLayoutHeight"];
                        
                        customImageView.frame = CGRectMake(0, 0, clLayoutWidth.floatValue, clLayoutHeight.floatValue);
                        
                        [barButtonItem setCustomView:customImageView];
                        
                    }else if ([type isEqualToString:@"Button"]){
                        
                        UIButton * custonButton = [CLShanYanCustomViewHelper customButtonWithCongifure:customViewConfigure];
                        
                        custonButton.widgetId = widgetId;
                        custonButton.isFinish = isFinish.boolValue;
                        
                        [custonButton addTarget:self action:@selector(customButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
                        
                        NSNumber * clLayoutWidth = clCustomDict[@"clLayoutWidth"];
                        NSNumber * clLayoutHeight = clCustomDict[@"clLayoutHeight"];
                        
                        custonButton.frame = CGRectMake(0, 0, clLayoutWidth.floatValue, clLayoutHeight.floatValue);
                        
                        [barButtonItem setCustomView:custonButton];
                    }
                    
                    if (barButtonItem.customView) {
                        if ([navPosition isEqualToString:@"navleft"]) {
                            baseConfigure.clNavigationLeftControl = barButtonItem;
                        }
                        if ([navPosition isEqualToString:@"navright"]) {
                            baseConfigure.clNavigationRightControl = barButtonItem;
                        }
                    }
                    
                }
            }
            
            //授权页自定义控件
            __weak typeof(self)weakSelf = self;
            baseConfigure.customAreaView = ^(UIView * _Nonnull customAreaView) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    for (NSDictionary * clCustomDict in clCustomViewDicts.allValues) {
                                    
                        NSString * type = clCustomDict[@"type"];
                        NSString * navPosition = clCustomDict[@"navPosition"];
                        if ([navPosition isEqualToString:@"navleft"] || [navPosition isEqualToString:@"navright"]) {
                            //导航栏控件跳过
                            continue;
                        }
                        NSString * widgetId = clCustomDict[@"widgetId"];
                        NSNumber * isFinish = clCustomDict[@"isFinish"];

                        CLShanYanCustomViewCongifure * customViewConfigure = [strongSelf customViewConfigureWithDict:clCustomDict];
                        
                        if ([type isEqualToString:@"TextView"]) {
                            
                            UILabel * customLabel = [CLShanYanCustomViewHelper customLabelWithCongifure:customViewConfigure];
                            
                            customLabel.widgetId = widgetId;

                            [customAreaView addSubview:customLabel];
                                                
                            [ShanyanPlugin setConstraint:customAreaView targetView:customLabel contrains:clCustomDict];
                            
                        }else if ([type isEqualToString:@"ImageView"]){
                            
                            UIImageView * customImageView = [CLShanYanCustomViewHelper customImageViewWithCongifure:customViewConfigure];
                            
                            customImageView.widgetId = widgetId;

                            [customAreaView addSubview:customImageView];
                                                
                            [ShanyanPlugin setConstraint:customAreaView targetView:customImageView contrains:clCustomDict];
                            
                        }else if ([type isEqualToString:@"Button"]){
                            
                            UIButton * custonButton = [CLShanYanCustomViewHelper customButtonWithCongifure:customViewConfigure];
                            
                            custonButton.widgetId = widgetId;
                            custonButton.isFinish = isFinish.boolValue;
                            
                            [custonButton addTarget:strongSelf action:@selector(customButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];

                            [customAreaView addSubview:custonButton];
                                                
                            [ShanyanPlugin setConstraint:customAreaView targetView:custonButton contrains:clCustomDict];

                        }
                    }
                });
            };
        }
    } @catch (NSException *exception) {
    }
    return baseConfigure;
}

//自定义控件事件
-(void)setCustomInterface:(FlutterResult)customInterface{
    _customInterface = customInterface;
}

-(void)customButtonClicked:(UIButton *)sender{
    if (self.customInterface) {
        NSMutableDictionary * result = [NSMutableDictionary new];
        result[@"widgetId"] = sender.widgetId;
        result[@"isFinish"] = @(sender.isFinish);
        self.customInterface(result);
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
            UIColor  * clTextColor = [CLShanYanCustomViewHelper rgbaToUIColor:clCustomDict[@"textColor"]];
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
            {
                NSData * clBackgroundImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clButtonImage]]];
                UIImage * clBackgroundImg_value = [UIImage imageWithData:clBackgroundImgData];
                //UIButton
                customViewConfigure.button_image = clBackgroundImg_value;
                //UIImageView
                customViewConfigure.imageView_image = clBackgroundImg_value;
            }
            
            
            NSString * clButtonBackgroundImage = clCustomDict[@"backgroundImage"];
            {
                NSData * clBackgroundImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self assetPathWithConfig:clButtonBackgroundImage]]];
                UIImage * clBackgroundImg_value = [UIImage imageWithData:clBackgroundImgData];
                customViewConfigure.button_backgroundImage = clBackgroundImg_value;
            }
            
            //UIView通用
            UIColor * backgroundColor = [CLShanYanCustomViewHelper rgbaToUIColor: clCustomDict[@"backgroundColor"]];
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
            NSNumber * masksToBounds =  clCustomDict[@"masksToBounds"];
            if (cornerRadius) {
                customViewConfigure.layer_cornerRadius = cornerRadius;
            }
            if (masksToBounds) {
                customViewConfigure.layer_masksToBounds = masksToBounds;
            }
            
            
            return customViewConfigure;
    } @catch (NSException *exception) {
        
    }
}


+(void)setConstraint:(UIView * )superView targetView:(UIView *)subView contrains:(NSDictionary * )dict{
    
    @try {
        NSNumber * clLayoutLeft = dict[@"clLayoutLeft"];
        NSNumber * clLayoutTop = dict[@"clLayoutTop"];
        NSNumber * clLayoutRight = dict[@"clLayoutRight"];
        NSNumber * clLayoutBottom = dict[@"clLayoutBottom"];
        NSNumber * clLayoutWidth = dict[@"clLayoutWidth"];
        NSNumber * clLayoutHeight = dict[@"clLayoutHeight"];
        NSNumber * clLayoutCenterX = dict[@"clLayoutCenterX"];
        NSNumber * clLayoutCenterY = dict[@"clLayoutCenterY"];
        
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
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0f constant:clLayoutRight.floatValue];
            c.active = YES;
        }
        
        if (clLayoutBottom != nil) {
            NSLayoutConstraint * c = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:clLayoutBottom.floatValue];
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
    
    NSNumber * clLayoutLogoLeft     = layOutPortraitDict[@"clLayoutLogoLeft"];
    NSNumber * clLayoutLogoTop      = layOutPortraitDict[@"clLayoutLogoTop"];
    NSNumber * clLayoutLogoRight    = layOutPortraitDict[@"clLayoutLogoRight"];
    NSNumber * clLayoutLogoBottom   = layOutPortraitDict[@"clLayoutLogoBottom"];
    NSNumber * clLayoutLogoWidth    = layOutPortraitDict[@"clLayoutLogoWidth"];
    NSNumber * clLayoutLogoHeight   = layOutPortraitDict[@"clLayoutLogoHeight"];
    NSNumber * clLayoutLogoCenterX  = layOutPortraitDict[@"clLayoutLogoCenterX"];
    NSNumber * clLayoutLogoCenterY  = layOutPortraitDict[@"clLayoutLogoCenterY"];
    
    clOrientationLayOutPortrait.clLayoutLogoLeft = clLayoutLogoLeft;
    clOrientationLayOutPortrait.clLayoutLogoTop = clLayoutLogoTop;
    clOrientationLayOutPortrait.clLayoutLogoRight = clLayoutLogoRight;
    clOrientationLayOutPortrait.clLayoutLogoBottom = clLayoutLogoBottom;
    clOrientationLayOutPortrait.clLayoutLogoWidth = clLayoutLogoWidth;
    clOrientationLayOutPortrait.clLayoutLogoHeight = clLayoutLogoHeight;
    clOrientationLayOutPortrait.clLayoutLogoCenterX = clLayoutLogoCenterX;
    clOrientationLayOutPortrait.clLayoutLogoCenterY = clLayoutLogoCenterY;

    /**手机号显示控件*/
    //layout 约束均相对vc.view
    NSNumber * clLayoutPhoneLeft    = layOutPortraitDict[@"clLayoutPhoneLeft"];;
    NSNumber * clLayoutPhoneTop     = layOutPortraitDict[@"clLayoutPhoneTop"];;
    NSNumber * clLayoutPhoneRight   = layOutPortraitDict[@"clLayoutPhoneRight"];;
    NSNumber * clLayoutPhoneBottom  = layOutPortraitDict[@"clLayoutPhoneBottom"];;
    NSNumber * clLayoutPhoneWidth   = layOutPortraitDict[@"clLayoutPhoneWidth"];;
    NSNumber * clLayoutPhoneHeight  = layOutPortraitDict[@"clLayoutPhoneHeight"];;
    NSNumber * clLayoutPhoneCenterX = layOutPortraitDict[@"clLayoutPhoneCenterX"];;
    NSNumber * clLayoutPhoneCenterY = layOutPortraitDict[@"clLayoutPhoneCenterY"];;
    clOrientationLayOutPortrait.clLayoutPhoneLeft = clLayoutPhoneLeft;
    clOrientationLayOutPortrait.clLayoutPhoneTop = clLayoutPhoneTop;
    clOrientationLayOutPortrait.clLayoutPhoneRight = clLayoutPhoneRight;
    clOrientationLayOutPortrait.clLayoutPhoneBottom = clLayoutPhoneBottom;
    clOrientationLayOutPortrait.clLayoutPhoneWidth = clLayoutPhoneWidth;
    clOrientationLayOutPortrait.clLayoutPhoneHeight = clLayoutPhoneHeight;
    clOrientationLayOutPortrait.clLayoutPhoneCenterX = clLayoutPhoneCenterX;
    clOrientationLayOutPortrait.clLayoutPhoneCenterY = clLayoutPhoneCenterY;
    /*一键登录按钮 控件
     注： 一键登录授权按钮 不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutLoginBtnLeft     = layOutPortraitDict[@"clLayoutLoginBtnLeft"];
    NSNumber * clLayoutLoginBtnTop      = layOutPortraitDict[@"clLayoutLoginBtnTop"];
    NSNumber * clLayoutLoginBtnRight    = layOutPortraitDict[@"clLayoutLoginBtnRight"];
    NSNumber * clLayoutLoginBtnBottom   = layOutPortraitDict[@"clLayoutLoginBtnBottom"];
    NSNumber * clLayoutLoginBtnWidth    = layOutPortraitDict[@"clLayoutLoginBtnWidth"];
    NSNumber * clLayoutLoginBtnHeight   = layOutPortraitDict[@"clLayoutLoginBtnHeight"];
    NSNumber * clLayoutLoginBtnCenterX  = layOutPortraitDict[@"clLayoutLoginBtnCenterX"];
    NSNumber * clLayoutLoginBtnCenterY  = layOutPortraitDict[@"clLayoutLoginBtnCenterY"];
    clOrientationLayOutPortrait.clLayoutLoginBtnLeft = clLayoutLoginBtnLeft;
    clOrientationLayOutPortrait.clLayoutLoginBtnTop = clLayoutLoginBtnTop;
    clOrientationLayOutPortrait.clLayoutLoginBtnRight = clLayoutLoginBtnRight;
    clOrientationLayOutPortrait.clLayoutLoginBtnBottom = clLayoutLoginBtnBottom;
    clOrientationLayOutPortrait.clLayoutLoginBtnWidth = clLayoutLoginBtnWidth;
    clOrientationLayOutPortrait.clLayoutLoginBtnHeight = clLayoutLoginBtnHeight;
    clOrientationLayOutPortrait.clLayoutLoginBtnCenterX = clLayoutLoginBtnCenterX;
    clOrientationLayOutPortrait.clLayoutLoginBtnCenterY = clLayoutLoginBtnCenterY;
    /*隐私条款Privacy
     注： 运营商隐私条款 不得隐藏， 用户条款不限制
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutAppPrivacyLeft   = layOutPortraitDict[@"clLayoutAppPrivacyLeft"];
    NSNumber * clLayoutAppPrivacyTop    = layOutPortraitDict[@"clLayoutAppPrivacyTop"];
    NSNumber * clLayoutAppPrivacyRight  = layOutPortraitDict[@"clLayoutAppPrivacyRight"];
    NSNumber * clLayoutAppPrivacyBottom = layOutPortraitDict[@"clLayoutAppPrivacyBottom"];
    NSNumber * clLayoutAppPrivacyWidth  = layOutPortraitDict[@"clLayoutAppPrivacyWidth"];
    NSNumber * clLayoutAppPrivacyHeight = layOutPortraitDict[@"clLayoutAppPrivacyHeight"];
    NSNumber * clLayoutAppPrivacyCenterX= layOutPortraitDict[@"clLayoutAppPrivacyCenterX"];
    NSNumber * clLayoutAppPrivacyCenterY= layOutPortraitDict[@"clLayoutAppPrivacyCenterY"];
    clOrientationLayOutPortrait.clLayoutAppPrivacyLeft = clLayoutAppPrivacyLeft;
    clOrientationLayOutPortrait.clLayoutAppPrivacyTop = clLayoutAppPrivacyTop;
    clOrientationLayOutPortrait.clLayoutAppPrivacyRight = clLayoutAppPrivacyRight;
    clOrientationLayOutPortrait.clLayoutAppPrivacyBottom = clLayoutAppPrivacyBottom;
    clOrientationLayOutPortrait.clLayoutAppPrivacyWidth = clLayoutAppPrivacyWidth;
    clOrientationLayOutPortrait.clLayoutAppPrivacyHeight = clLayoutAppPrivacyHeight;
    clOrientationLayOutPortrait.clLayoutAppPrivacyCenterX = clLayoutAppPrivacyCenterX;
    clOrientationLayOutPortrait.clLayoutAppPrivacyCenterY = clLayoutAppPrivacyCenterY;
    /*Slogan 运营商品牌标签："认证服务由中国移动/联通/电信提供" label
     注： 运营商品牌标签，不得隐藏
     **/
    //layout 约束均相对vc.view
    NSNumber * clLayoutSloganLeft   = layOutPortraitDict[@"clLayoutSloganLeft"];
    NSNumber * clLayoutSloganTop    = layOutPortraitDict[@"clLayoutSloganTop"];
    NSNumber * clLayoutSloganRight  = layOutPortraitDict[@"clLayoutSloganRight"];
    NSNumber * clLayoutSloganBottom = layOutPortraitDict[@"clLayoutSloganBottom"];
    NSNumber * clLayoutSloganWidth  = layOutPortraitDict[@"clLayoutSloganWidth"];
    NSNumber * clLayoutSloganHeight = layOutPortraitDict[@"clLayoutSloganHeight"];
    NSNumber * clLayoutSloganCenterX= layOutPortraitDict[@"clLayoutSloganCenterX"];
    NSNumber * clLayoutSloganCenterY= layOutPortraitDict[@"clLayoutSloganCenterY"];
    clOrientationLayOutPortrait.clLayoutSloganLeft = clLayoutSloganLeft;
    clOrientationLayOutPortrait.clLayoutSloganTop = clLayoutSloganTop;
    clOrientationLayOutPortrait.clLayoutSloganRight = clLayoutSloganRight;
    clOrientationLayOutPortrait.clLayoutSloganBottom = clLayoutSloganBottom;
    clOrientationLayOutPortrait.clLayoutSloganWidth = clLayoutSloganWidth;
    clOrientationLayOutPortrait.clLayoutSloganHeight = clLayoutSloganHeight;
    clOrientationLayOutPortrait.clLayoutSloganCenterX = clLayoutSloganCenterX;
    clOrientationLayOutPortrait.clLayoutSloganCenterY = clLayoutSloganCenterY;
    /**窗口模式*/
    /**窗口中心：CGPoint X Y*/
    NSNumber * clAuthWindowOrientationCenterX = layOutPortraitDict[@"clAuthWindowOrientationCenterX"];
    NSNumber * clAuthWindowOrientationCenterY = layOutPortraitDict[@"clAuthWindowOrientationCenterY"];
    if (clAuthWindowOrientationCenterX && clAuthWindowOrientationCenterY) {
        clOrientationLayOutPortrait.clAuthWindowOrientationCenter = [NSValue valueWithCGPoint:CGPointMake(clAuthWindowOrientationCenterX.floatValue, clAuthWindowOrientationCenterY.floatValue)];
    }
    
    /**窗口左上角：frame.origin：CGPoint X Y*/
    NSNumber * clAuthWindowOrientationOriginX = layOutPortraitDict[@"clAuthWindowOrientationOriginX"];
    NSNumber * clAuthWindowOrientationOriginY = layOutPortraitDict[@"clAuthWindowOrientationOriginY"];
    if (clAuthWindowOrientationCenterX && clAuthWindowOrientationOriginY) {
        clOrientationLayOutPortrait.clAuthWindowOrientationOrigin = [NSValue valueWithCGPoint:CGPointMake(clAuthWindowOrientationOriginX.floatValue, clAuthWindowOrientationOriginY.floatValue)];
    }
    /**窗口大小：宽 float */
    NSNumber * clAuthWindowOrientationWidth = layOutPortraitDict[@"clAuthWindowOrientationWidth"];
    {
        clOrientationLayOutPortrait.clAuthWindowOrientationWidth = clAuthWindowOrientationWidth;
    }
    /**窗口大小：高 float */
    NSNumber * clAuthWindowOrientationHeight= layOutPortraitDict[@"clAuthWindowOrientationHeight"];
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
    clOrientationLayOutLandscape.clLayoutLogoRight = clLayoutLogoRight;
    clOrientationLayOutLandscape.clLayoutLogoBottom = clLayoutLogoBottom;
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
    clOrientationLayOutLandscape.clLayoutPhoneRight = clLayoutPhoneRight;
    clOrientationLayOutLandscape.clLayoutPhoneBottom = clLayoutPhoneBottom;
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
    clOrientationLayOutLandscape.clLayoutLoginBtnRight = clLayoutLoginBtnRight;
    clOrientationLayOutLandscape.clLayoutLoginBtnBottom = clLayoutLoginBtnBottom;
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
    clOrientationLayOutLandscape.clLayoutAppPrivacyRight = clLayoutAppPrivacyRight;
    clOrientationLayOutLandscape.clLayoutAppPrivacyBottom = clLayoutAppPrivacyBottom;
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
    clOrientationLayOutLandscape.clLayoutSloganRight = clLayoutSloganRight;
    clOrientationLayOutLandscape.clLayoutSloganBottom = clLayoutSloganBottom;
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
            NSMutableDictionary * result = [NSMutableDictionary new];
                       
                       
                       if (completeResult.error) {
                           result[@"code"] = @(completeResult.error.code);
                           if (completeResult.error.userInfo != nil && completeResult.error.userInfo.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.error.userInfo];
                           }else if (completeResult.error.domain != nil){
                               result[@"result"] = completeResult.error.domain;
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }else{
                           result[@"code"] = @(completeResult.code);
                           if (completeResult.data != nil  && completeResult.data.count > 0) {
                               result[@"result"] = [NSString stringWithFormat:@"%@",completeResult.data];
                           }else{
                               result[@"result"] = completeResult.message;
                           }
                       }
            authenticationListener(result);
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
