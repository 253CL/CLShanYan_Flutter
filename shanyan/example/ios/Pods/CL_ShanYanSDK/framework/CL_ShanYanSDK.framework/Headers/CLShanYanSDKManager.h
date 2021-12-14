//
//  CLShanYanSDKManager.h
//  CL_ShanYanSDK
//
//  Created by wanglijun on 2018/10/29.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CLCompleteResult.h"
#import "CLUIConfigure.h"

@protocol CLShanYanSDKManagerDelegate <NSObject>
@optional
/**
 * 授权页面协议点击回调
 * @param privacyName 协议名称
 * @param index       协议位置--0:运营商协议--1:用户协议一--2:用户协议二
 * @param telecom     当前运营商类型
*/
-(void)clShanYanSDKManagerWebPrivacyClicked:(NSString *_Nonnull)privacyName privacyIndex:(NSInteger)index currentTelecom:(NSString *_Nullable)telecom DEPRECATED_MSG_ATTRIBUTE("Method deprecated. Use `clShanYanActionListner:code:message:`");

/**
 * 授权页面已经显示的回调
 * ViewDidAppear
 * @param telecom     当前运营商类型
 */
-(void)clShanYanSDKManagerAuthPageAfterViewDidLoad:(UIView *_Nonnull)authPageView currentTelecom:(NSString *_Nullable)telecom ;

/**
 * 授权页面将要显示的回调 ViewDidLoad即将全部执行完毕的最后时机
 * ViewDidLoad  did complete
 * @param telecom     当前运营商类型
 */
-(void)clShanYanSDKManagerAuthPageCompleteViewDidLoad:(UIViewController *_Nonnull)authPageVC currentTelecom:(NSString *_Nullable)telecom object:(NSObject*_Nullable)object userInfo:(NSDictionary*_Nullable)userInfo;
/**
 * 授权页面将要显示的回调
 * ViewWillAppear
 * @param telecom     当前运营商类型
 */
-(void)clShanYanSDKManagerAuthPageCompleteViewWillAppear:(UIViewController *_Nonnull)authPageVC currentTelecom:(NSString *_Nullable)telecom object:(NSObject*_Nullable)object userInfo:(NSDictionary*_Nullable)userInfo;
/**
 * 授权页vc alloc init
 * init，注：此时authPageVC.navigationController为nil
 * @param telecom     当前运营商类型
 */
-(void)clShanYanSDKManagerAuthPageCompleteInit:(UIViewController *_Nonnull)authPageVC currentTelecom:(NSString *_Nullable)telecom object:(NSObject*_Nullable)object userInfo:(NSDictionary*_Nullable)userInfo;
/**
 * 授权页vc 将要被present
 * 将要调用[uiconfigure.viewcontroller  present:authPageVC animation:completion:]
 * @param telecom     当前运营商类型
 */
-(void)clShanYanSDKManagerAuthPageWillPresent:(UIViewController *_Nonnull)authPageVC currentTelecom:(NSString *_Nullable)telecom object:(NSObject*_Nullable)object userInfo:(NSDictionary*_Nullable)userInfo;

/**
 * 统一事件监听方法
 * type：事件类型（1，2，3）
 * 1：隐私协议点击
 * - 同-clShanYanSDKManagerWebPrivacyClicked:privacyIndex:currentTelecom
 * code：0,1,2,3（协议页序号），message：协议名_当前运营商类型
 * 2：协议勾选框点击
 * code：0,1（0为未选中，1为选中）
 * 3："一键登录"按钮点击
 * code：0,1（0为协议勾选框未选中，1为选中）
*/
-(void)clShanYanActionListener:(NSInteger)type code:(NSInteger)code  message:(NSString *_Nullable)message;
@end

NS_ASSUME_NONNULL_BEGIN
@interface CLShanYanSDKManager : NSObject

/// 设置点击协议代理
/// @param delegate 代理
+ (void)setCLShanYanSDKManagerDelegate:(id<CLShanYanSDKManagerDelegate>)delegate;

/**
 初始化
 @param appId 闪验后台申请的appId
 @param complete 预初始化回调block 
 */
+(void)initWithAppId:(NSString *)appId complete:(nullable CLComplete)complete;

///**
// 设置初始化超时 单位:s
// 大于0有效
// 建议4s左右，默认4s
// */
//+ (void)setInitTimeOut:(NSTimeInterval)initTimeOut;

/**
 设置预取号超时 单位:s
 大于0有效
 建议4s左右，默认4s
 */
+ (void)setPreGetPhonenumberTimeOut:(NSTimeInterval)preGetPhoneTimeOut;

/// 当无蜂窝网络（拔出SIM卡/切换SIM卡,网络切换期间/或者直接关闭流量开关）是否使用之前的取号缓存
/// @param isUseCache YES/NO  默认YES   设置为NO  获取SIM实时的预取号，无蜂窝网络、或者蜂窝网络不稳定则无法取号成功
+ (void)setPreGetPhonenumberUseCacheIfNoCellularNetwork:(BOOL)isUseCache;

/**
 * 预取号
 * 此调用将有助于提高闪验拉起授权页的速度和成功率
 * 建议在一键登录前提前调用此方法，比如调一键登录的vc的viewdidload中
 * 不建议在拉起授权页后调用
 * ⚠️‼️以 if (completeResult.error == nil) 为判断成功的依据，而非返回码
 * ⚠️‼️此方法回调队列为dispatch_get_global_queue(0, 0)，回调中如需UI操作，请自行切到主线程
 */
+(void)preGetPhonenumber:(nullable CLComplete)complete;

/**
 * 一键登录拉起内置授权页&获取Token
 @param clUIConfigure 闪验授权页参数配置
 @param complete 回调block
 * 回调中如需UI操作，建议自行切到主线程
 */
+(void)quickAuthLoginWithConfigure:(CLUIConfigure *)clUIConfigure
                          complete:(nonnull CLComplete)complete;


/**
 一键登录拉起内置授权页&获取Token( 区分拉起授权页之前和之后的回调)
 
 @param clUIConfigure 闪验授权页参数配置
 @param openLoginAuthListener 拉起授权页监听：拉起授权页面成功或失败的回调，拉起成功或失败均触发。当拉起失败时，oneKeyLoginListener不会触发。此回调的内部触发时机是viewDidAppear
    
 @param oneKeyLoginListener 一键登录监听：拉起授权页成功后的后续操作回调，包括点击SDK内置的(非外部自定义)取消登录按钮，以及点击本机号码一键登录的回调。点击授权页自定义按钮不触发此回调
 
 * 回调中如需UI操作，建议自行切到主线程
 */
+(void)quickAuthLoginWithConfigure:(CLUIConfigure *)clUIConfigure
           openLoginAuthListener:(CLComplete)openLoginAuthListener
                          oneKeyLoginListener:(CLComplete)oneKeyLoginListener;


/**
 关闭授权页
 注：若授权页未拉起或已经提前关闭，此方法调用无效果，complete不触发。内部实现为调用系统方法dismissViewcontroller:Complete
 @param flag dismissViewcontroller`Animated, default is YES.
 @param completion dismissViewcontroller`completion
 */
+(void)finishAuthControllerCompletion:(void(^_Nullable)(void))completion;
+(void)finishAuthControllerAnimated:(BOOL)flag Completion:(void(^_Nullable)(void))completion;

//设置checkBox勾选状态
+(void)setCheckBoxValue:(BOOL)isSelect;

+(void)hideLoading;



///**************一键登录获取Token***************/
///// 注：此方法回调队列为dispatch_get_global_queue(0, 0)，如需UI操作请自行切入主线程
//+(void)loginAuth:(CLComplete)complete;



/**************本机认证(本机号码校验)***************/
+ (void)mobileCheckWithLocalPhoneNumberComplete:(CLComplete)complete;




/**************SDK功能方法***************/
/**
 模式控制台日志输出控制（默认关闭）
 @param enable 开关参数
 */
+ (void)printConsoleEnable:(BOOL)enable;


/// 获取当前流量卡运营商，结果仅供参考
// CTCC：电信、CMCC：移动、CUCC：联通、UNKNOW：未知
+ (NSString *)getOperatorType;

+ (void)clearScripCache;

/**
 禁止日志上报(默认开启)
 ****此接口需要在初始化之前调用,否则配置不生效****
 @param forbidden YES:禁止上报 NO:允许上报
 */
+ (void)forbiddenFullLogReport:(BOOL)forbidden;

+(void)sdkInit:(NSString *)appId complete:(nullable CLComplete)complete;

+ (BOOL)checkAuthEnable;

/**
 * 当前SDK版本号
 */
+ (NSString *)clShanYanSDKVersion;
@end

NS_ASSUME_NONNULL_END
