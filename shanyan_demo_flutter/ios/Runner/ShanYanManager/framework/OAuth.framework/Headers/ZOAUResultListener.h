//
//  ZOAUResultListener 响应结果监听对象
//  OAuthSDKApp
//
//  Created by zhangQY on 2019/5/13.
//  Copyright © 2019 com.zzx.sdk.ios.test. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ServiceType) {
    ServiceTypeMobile,
    ServiceTypeOAuth,
};


typedef void (^resultListener)(NSDictionary *data);

@interface ZOAUResultListener : NSObject
@end
