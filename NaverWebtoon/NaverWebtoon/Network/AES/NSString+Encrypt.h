//
//  NSString+Ecypt.h
//
//  Created by Gyuha Shin on 11. 5. 24..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @category NSString_Encrypt category
 
 @brief String을 Base64로 암복호화
 */
@interface NSString (NSString_Encrypt)

/**
 @brief String을 Base64으로 암호화
 */
- (NSString *)encryptWithKey:(NSString*)key;

/**
 @brief String을 Base64으로 복호화
 */
- (NSString *)decryptWithKey:(NSString*)key;
@end
