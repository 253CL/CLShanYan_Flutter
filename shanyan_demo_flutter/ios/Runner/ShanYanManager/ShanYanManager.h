//
//  ShanYanManager.h
//  Runner
//
//  Created by wanglijun on 2019/4/26.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShanYanManager : NSObject<FlutterPlugin>
+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry;
@end

NS_ASSUME_NONNULL_END
