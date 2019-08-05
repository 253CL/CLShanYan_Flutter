//
//  CLCTCCUIConfigure.h
//  CL_ShanYanSDK
//
//  Created by wanglijun on 2018/10/30.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 注： 授权页一键登录按钮、运营商品牌标签、运营商条款必须显示，不得隐藏，否则取号能力可能被运营商关闭
 **/

//授权页UI配置
/*授权页面的各个控件的Y轴默认值都是以375*667屏幕为基准
 基础配置默认三网通用，但由于运营商各自的限制，某些设置效果达不到三网完全一致的，需要各自做微调
**/
@interface CLUIConfigure : NSObject

//要拉起授权页的vc [必填项] (注：SDK不持有接入方VC)
@property (nonatomic,weak)UIViewController * viewController;
/**
 外部手动管理关闭界面
 default is NO
 */
@property (nonatomic,strong)NSNumber * manualDismiss;

//导航栏
//导航栏背景色
@property (nonatomic,strong)UIColor   * clNavBgColor;
/**导航栏标题*/
@property (nonatomic,strong) NSString * clNavText;
/**导航栏标题字体*/
@property (nonatomic,strong) UIFont * clNavTextFont;
/**导航栏标题颜色*/
@property (nonatomic,strong) UIColor * clNavTextColor;
//导航栏右侧自定义按钮
@property (nonatomic,strong)UIBarButtonItem * clNavControl;

//返回按钮
//返回按钮图片
@property (nonatomic,strong)UIImage   * clBackButtonImage;
//返回按钮显隐
@property (nonatomic,strong)NSNumber  * clBackButtonHiden;

//LOGO图片
/**LOGO图片*/
@property (nonatomic,strong)UIImage  * clLogoImage;
/**LOGO高度*/
@property (nonatomic,strong)NSNumber * clLogoHeight;
/**LOGO宽度*/
@property (nonatomic,strong)NSNumber * clLogoWidth;
/**LOGO偏移量*/
@property (nonatomic,strong)NSNumber * clLogoOffsetY;
/**LOGO显隐*/
@property (nonatomic,strong)NSNumber * clLogoHiden;

//手机号显示
/**手机号颜色*/
@property (nonatomic,strong)UIColor  * clPhoneNumberColor;
/**手机号偏移量*/
@property (nonatomic,strong)NSNumber * clPhoneNumberOffsetY;

/*一键登录按钮
注： 一键登录授权按钮 不得隐藏
**/
/**按钮文字*/
@property (nonatomic,copy)NSString  * clLoginBtnText;
/**按钮文字颜色*/
@property (nonatomic,strong)UIColor * clLoginBtnTextColor;
/**按钮背景图片*/
@property (nonatomic,strong)UIImage * clLoginBtnBgImage;
/**按钮偏移量*/
@property (nonatomic,strong)NSNumber * clLoginBtnOffsetY;

/*隐私条款Privacy
注： 运营商隐私条款 不得隐藏
    用户条款不限制
**/
/**条款名颜色*/
@property (nonatomic,strong)UIColor * clAppPrivacyColor;
/**隐私条款Y偏移量(注:此属性为条款顶部与屏幕底部的距离)*/
@property (nonatomic,strong)NSNumber* clAppPrivacyOffsetY;
//需同时设置Name和UrlString
/**条款名*/
@property (nonatomic,copy)NSString  * clAppPrivacyName;
/**条款链接*/
@property (nonatomic,copy)NSString  * clAppPrivacyUrlString;

/*SLOGAN
注： 运营商品牌标签，不得隐藏
**/
/**slogan偏移量Y*/
@property (nonatomic,strong) NSNumber * clSloganOffsetY;
/**slogan文字颜色*/
@property (nonatomic,strong) UIColor * clSloganTextColor;

//添加自定义控件
/**(导航栏以下的页面)*/
@property (nonatomic,copy)void(^customAreaView)(UIView * customAreaView);
@end

//电信配置
@interface CLCTCCUIConfigure : CLUIConfigure
@end

//移动配置
@interface CLCMCCUIConfigure : CLUIConfigure
@end

//联通配置
@interface CLCUCCUIConfigure : CLUIConfigure
@end

NS_ASSUME_NONNULL_END
