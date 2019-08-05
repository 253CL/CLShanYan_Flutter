//
//  ShanYanManager.m
//  Runner
//
//  Created by wanglijun on 2019/4/26.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ShanYanManager.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
#import "NSString+DecryptUseDES.h"
#import "NSString+Unicode.h"


static NSString *const SHANYAN_CHANNEL_NAME = @"shanyan.flutter.quickLogin";

#define shanyanAppID  @"eWWfA2KJ"
#define shanyanAppKey @"tDo3Ml2K"

@interface ShanYanManager ()
@property(nonatomic, retain) FlutterMethodChannel *channel;
@end

@implementation ShanYanManager
{
    FlutterResult _result;
}

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry{
    [ShanYanManager registerWithRegistrar:[registry registrarForPlugin:@"ShanYanManager"]];
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar{
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:SHANYAN_CHANNEL_NAME binaryMessenger:[registrar messenger]];
    ShanYanManager *instance = [[ShanYanManager alloc] init];
    instance.channel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}


- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if([call.method isEqualToString: @"shanyanQuicklogin"]) {

        
        FlutterViewController * currentVC = [[[UIApplication sharedApplication]delegate]window].rootViewController;
        
        CLUIConfigure * clbaseUI = [CLUIConfigure new];
        clbaseUI.viewController = currentVC;
        clbaseUI.clLogoImage = [UIImage imageNamed:@"icon_flash253"];
        
        //手动管理关闭授权页
        clbaseUI.manualDismiss = @(YES);
        
        __weak typeof(self) weakSelf = self;
        
        [CLShanYanSDKManager quickAuthLoginWithConfigureCTCC:clbaseUI CMCC:clbaseUI CUCC:clbaseUI timeOut:4 complete:^(CLCompleteResult * _Nonnull completeResult) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if (completeResult.error) {
                if (completeResult.code == 1011) {
                    //点击返回，sdk强制关闭页面
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //出错返回
                        [currentVC dismissViewControllerAnimated:YES completion:nil];
                    });
                }
                
                if (result) {
                    result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)completeResult.code]
                                               message:completeResult.message
                                               details:completeResult.error.userInfo]);
                }

            }else{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //返回原页面
                    [currentVC dismissViewControllerAnimated:YES completion:nil];
                    
                    [ShanYanManager getRealPhoneNumberWithToken:completeResult.data complete:^(NSDictionary * responseObject, NSError * error) {
                        if (error) {
                            if (result) {
                                result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)error.code]
                                                           message:error.domain
                                                           details:error.userInfo]);
                            }
                        }else{
                            
                            //响应code码。200000：成功，其他失败，来源：闪验后台接入文档
                            NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
                            if (code == 200000) {
                                NSString * mobileName = responseObject[@"data"][@"mobileName"];
                                mobileName = [NSString replaceUnicode:mobileName];
                                NSString * mobileCode = [mobileName decryptUseDESKey:shanyanAppKey];
                                
                                NSLog(@"免密登录成功,手机号：%@",mobileCode);
                                
                                NSMutableDictionary * data = [NSMutableDictionary dictionary];
                                data[@"phoneNumber"] = mobileCode;
                                data[@"data"] = responseObject;

                                //结果返回给flutter
                                [strongSelf.channel invokeMethod:@"shanyanQuickloginCallBack" arguments:data];
                                
                            } else {
                                NSString * retMsg = [responseObject valueForKey:@"retMsg"];
                                NSString * code = [responseObject valueForKey:@"code"];
                                NSString * chargeStatus = [responseObject valueForKey:@"chargeStatus"];
                                
                                if (!retMsg) {
                                    retMsg = @"免密登录失败";
                                }
                                if (!code) {
                                    code = [NSString stringWithFormat:@"%@",chargeStatus];
                                }
                                
                                if (result) {
                                    result([FlutterError errorWithCode:code message:retMsg details:responseObject]);
                                }
                            }
                        }
                    }];
                });
//                result(completeResult.data);
            }
        }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

//App启动
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [CLShanYanSDKManager initWithAppId:shanyanAppID AppKey:shanyanAppKey timeOut:5 complete:^(CLCompleteResult * _Nonnull completeResult) {
        
    }];
    
    return YES;
}

+(void)getRealPhoneNumberWithToken:(NSDictionary *)token complete:(void(^)(NSDictionary *,NSError *))complete{
    
    NSString * cl_SDK_URL = @"https://api.253.com/";
    
    NSString * telecom = [token valueForKey:@"telecom"];
    
    NSString * urlStr = nil;
    if ([telecom isEqualToString:@"CMCC"]) {
        urlStr = [cl_SDK_URL stringByAppendingString:@"open/flashsdk/mobile-query-m"];
    }else if ([telecom isEqualToString:@"CUCC"]) {
        urlStr = [cl_SDK_URL stringByAppendingString:@"open/flashsdk/mobile-query-u"];
    }else if ([telecom isEqualToString:@"CTCC"]) {
        urlStr = [cl_SDK_URL stringByAppendingString:@"open/flashsdk/mobile-query-t"];
    }else{
        //失败
        if (complete) {
            complete(nil,[NSError errorWithDomain:@"此手机无SIM卡或非三大运营商卡号" code:1003 userInfo:nil]);
        }
        return;
    }
    
    //原生NSURLSession:
    NSURL *nsurl = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    request.HTTPMethod = @"POST";
    //URLEncode
    NSString *charactersToEscape = @"#[]@!$'()*+,;\"<>%{}|^~`";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSMutableString *formDataString = [NSMutableString new];
    [token enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * objString = [NSString stringWithFormat:@"%@",obj];
        [formDataString appendString:[NSString stringWithFormat:@"%@=%@&", key, [objString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]]];
    }];
    request.HTTPBody = [formDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 10;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    __weak typeof(session) weakSession = session;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (complete) {
                complete(nil,error);
            }
        } else {
            if (complete) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                complete(dic,nil);
            }
        }
        
        [weakSession invalidateAndCancel];
    }];
    [dataTask resume];

}

@end
