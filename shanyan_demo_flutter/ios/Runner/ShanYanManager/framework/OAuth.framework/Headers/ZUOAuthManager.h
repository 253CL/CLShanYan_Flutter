//
//  ZUOAuthManager 联通能力接入管理者
//  OAuthSDKApp
//
//  Created by zhangQY on 2019/5/13.
//  Copyright © 2019 com.zzx.sdk.ios.test. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZOAUResultListener.h"
#import "ZOAuthManager.h"
#import "ZOAUCustomModel.h"


@interface ZUOAuthManager : ZOAuthManager

/**
 *  获取联通能力接入单例对象
 */
+ (instancetype)getInstance;
/**
 *  初始化-联通
 */
- (void) init:(NSString*) apiKey pubKey:(NSString*)pubKey serviceType:(ServiceType) type;

/**
 *  预取号-联通
 */
- (void) loginPre:(double)timeout resultListener:(resultListener)listener;

/**
 * 登录-联通
 */
- (void) login:(UIViewController*)uiController timeout:(double)timeout resultListener:(resultListener)listener;

/**
 *  认证-联通
 */
- (void) oauth:(double)timeout resultListener:(resultListener)listener;

/**
 *  获取登录/认证结果
 *  测试接口
 */
- (void) gmbc:(NSString*)accessCode mobile:(NSString *)mobile listener:(resultListener)listener;


- (void) gmbc:(NSString*)accessCode listener:(resultListener)listener;

//修改UI
-(void) customUIWithParams:(ZOAUCustomModel *)customUIParams topCustomViews:(void(^)(UIView *customView))topCustomViews bottomCustomViews:(void(^)(UIView *customView))bottomCustomViews;


//自定义跳转
-(void)setLoginSuccessPage:(UIViewController *)uiController;

//释放
-(void)ZOAURelease;


@end
