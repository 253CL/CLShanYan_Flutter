//
//  NSString+DecryptUseDES.m
//  ShanYanSDK_Demo
//
//  Created by wanglijun on 2018/11/1.
//  Copyright © 2018 wanglijun. All rights reserved.
//

#import "NSString+DecryptUseDES.h"

#include <CommonCrypto/CommonCryptor.h>
#import<CommonCrypto/CommonDigest.h>

const Byte ives[] = {1,2,3,4,5,6,7,8};

@implementation NSString (DecryptUseDES)
//解密
- (NSString*)decryptUseDESKey:(NSString*)key {
    
    //CBC方式
    NSString *plaintext = nil;
    NSData *cipherdata = [[NSData alloc]initWithBase64EncodedString:self options:0];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          ives,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}
@end
