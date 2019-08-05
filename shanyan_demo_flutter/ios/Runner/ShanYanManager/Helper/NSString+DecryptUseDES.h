//
//  NSString+DecryptUseDES.h
//  ShanYanSDK_Demo
//
//  Created by wanglijun on 2018/11/1.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DecryptUseDES)
//解密
- (NSString*)decryptUseDESKey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
