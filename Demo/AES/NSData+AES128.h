//
//  NSData+AES128.h
//  Lianjiajianzhuang
//
//  Created by 刘然 on 2019/6/6.
//  Copyright © 2019 恋家家装. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES128)

/**
 *  加密
 *
 *  @param key 公钥
 *  @param iv  偏移量
 *
 *  @return 加密之后的NSData
 */
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

/**
 *  解密
 *
 *  @param key 公钥
 *  @param iv  偏移量
 *
 *  @return 解密之后的NSData
 */
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;


@end

NS_ASSUME_NONNULL_END
