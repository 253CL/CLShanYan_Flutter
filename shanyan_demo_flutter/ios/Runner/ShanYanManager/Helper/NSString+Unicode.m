//
//  NSString+Unicode.m
//  Runner
//
//  Created by wanglijun on 2019/5/28.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "NSString+Unicode.h"

@implementation NSString (Unicode)
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    if (unicodeStr == nil || unicodeStr.length == 0) {
        return unicodeStr;
    }
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    if (tempData == nil) {
        tempData  = [NSData data];
    }
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
@end
