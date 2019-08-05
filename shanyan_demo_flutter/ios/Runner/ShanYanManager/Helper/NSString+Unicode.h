//
//  NSString+Unicode.h
//  Runner
//
//  Created by wanglijun on 2019/5/28.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Unicode)
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
@end

NS_ASSUME_NONNULL_END
