//
//  ZOAuthManager 能力接入管理者-提供加解密方法
//  OAuthSDKApp
//
//  Created by zhangQY on 2019/5/13.
//  Copyright © 2019 com.zzx.sdk.ios.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZOAuthManager : NSObject

//RSA 加密
+ (NSString*) encryptWithRSA:(NSString*) content key:(NSString*)key;
//RSA 解密
+ (NSString*) decryptWithRSA:(NSString*) content key:(NSString*)key;

/**
 *  aes加密工具
 */
+ (NSString*) encryptWithAES:(NSString*) content  secretKey:(NSString*) key;

/**
 *  aes解密工具
 */
+ (NSString*) decryptWithAES:(NSString*) content  secretKey:(NSString*) key;

/**
 *  md5加密工具
 */
+ (NSString*) encryptWithMD5:(NSString*) content;
/**
 *  base64加密工具
 */
+ (NSString*) encryptWithBase64:(NSString *)content;
/**
 *  base64解密内容
 */
+ (NSString*) decryptWithBase64:(NSString *)content;

/**
 *  是否使用测试环境
 *
 *  @param isDebug true／false
 */
+ (void) setDebug:(Boolean) isDebug ;
@end
