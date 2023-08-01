//
//  NSString+Ecypt.m
//
//  Created by Gyuha Shin on 11. 5. 24..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "NSString+Encrypt.h"
#import "NSDataAdditions.h"
#import "NSData+AES256.h"

@implementation NSString (NSString_Encrypt)

/**
 @brief String을 Base64으로 암호화
 */
- (NSString *)encryptWithKey:(NSString*)key
{
    NSData *data = [self dataUsingEncoding: NSUTF8StringEncoding];
    data = [data AES256EncryptWithKey:key];
//    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *result = [data base64Encoding];
    return result;
}
/**
 @brief String을 Base64으로 복호화
 */
- (NSString *)decryptWithKey:(NSString *)key
{
//    NSData *decodedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodedData = [NSData dataWithBase64EncodedString:self];
    decodedData = [decodedData AES256DecryptWithKey:key];
    NSString *result = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return result;
}

@end
