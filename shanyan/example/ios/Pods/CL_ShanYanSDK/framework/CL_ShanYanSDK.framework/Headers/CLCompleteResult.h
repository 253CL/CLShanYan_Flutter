//
//  CLCompleteResult.h
//  CL_ShanYanSDK
//
//  Created by wanglijun on 2018/10/29.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CLSDKPrepareStutas) {
    CLSDKPrepareStutasERRORIniting,//失败-未完成（正在进行中）
    CLSDKPrepareStutasERRORTimeOut,//失败-超时
    CLSDKPrepareStutasERRORFailure,//失败-出错
    CLSDKPrepareStutasERRORNil,//失败-没有预取号
    CLSDKPrepareStutasSUCCESS,//成功
};

NS_ASSUME_NONNULL_BEGIN

@class CLCompleteResult;
typedef void(^CLComplete)(CLCompleteResult * completeResult);

@interface CLCompleteResult : NSObject
@property (nonatomic,assign)NSInteger code;//SDK外层code
@property (nonatomic,nullable,copy)NSString * message;//SDK外层msg
@property (nonatomic,nullable,copy)NSDictionary * data;//SDK外层data
@property (nonatomic,nullable,strong)NSError * error;//Error

//@property (nonatomic,nullable,strong)id clModel;

//内层
@property (nonatomic,assign)NSInteger innerCode;//SDK内层code
@property (nonatomic,nullable,copy)NSString * innerDesc;//SDK内层msg
@property (nonatomic,nullable,copy)NSDictionary * innerData;//SDK外层data
@property (nonatomic,nullable,strong)NSError * innerError;//Error

/**
 是否已经拉起授权页
 default is NO
 */
@property (nonatomic,assign)BOOL authPagePresented;

+(instancetype)cl_CompleteWithCode:(NSInteger)code message:(NSString *)message data:(nullable NSDictionary *)data  error:(nullable NSError *)error;
-(void)fillPropertyInfo;
@end

NS_ASSUME_NONNULL_END
