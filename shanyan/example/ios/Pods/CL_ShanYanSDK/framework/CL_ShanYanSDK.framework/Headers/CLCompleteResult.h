//
//  CLCompleteResult.h
//  CL_ShanYanSDK
//
//  Created by wanglijun on 2018/10/29.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class CLCompleteResult;
typedef void(^CLComplete)(CLCompleteResult * completeResult);

@interface CLCompleteResult : NSObject
@property (nonatomic,assign)NSInteger code;//SDK外层code
@property (nonatomic,nullable,copy)NSString * message;//SDK外层msg
@property (nonatomic,nullable,copy)NSDictionary * data;//SDK外层data
@property (nonatomic,nullable,strong)NSError * error;//Error

//内层
@property (nonatomic,assign)NSInteger innerCode;//SDK内层code
@property (nonatomic,nullable,copy)NSString * innerDesc;//SDK内层msg

#ifdef DEBUG
@property (nonatomic,assign)NSTimeInterval debug_createTime;
#endif
///**
// 是否已经拉起授权页
// default is NO
// */
//@property (nonatomic,assign)BOOL authPagePresented;

@property (nonatomic,assign)NSInteger clShanYanReportTag;

+(instancetype)cl_CompleteWithCode:(NSInteger)code message:(NSString *)message data:(nullable NSDictionary *)data  error:(nullable NSError *)error;
-(void)fillPropertyInfo;
@end

NS_ASSUME_NONNULL_END
