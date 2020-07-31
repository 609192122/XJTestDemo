//
//  NSObject+PropertyExchange.h
//  XJTestDemo
//
//  Created by mac on 2020/7/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)

@interface NSObject (PropertyExchange)
/**
 调用替换属性 Invocation property
 */
@property (nonatomic, copy) id(^em_property)(NSString *propertyName);

@end

NS_ASSUME_NONNULL_END
