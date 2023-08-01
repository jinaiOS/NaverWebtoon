//
//  NSData+AES256.h
//

#import <Foundation/Foundation.h>


/**
 @category NSData_AES256 category
 
 @brief String을 AES256으로 암복호화
 */
@interface NSData (NSData_AES256)

/**
 @brief String을 AES256으로 암호화
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;
/**
 @brief String을 AES256으로 복호화
 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end
