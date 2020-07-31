//
//  NSObject+PropertyExchange.m
//  XJTestDemo
//
//  Created by mac on 2020/7/29.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NSObject+PropertyExchange.h"

@implementation NSObject (PropertyExchange)

#pragma mark - Getter&&Setter

- (id(^)(NSString *))em_property {
    
    __weak typeof(self) weakSelf = self;
    id (^icp_block)(NSString *propertyName) = ^id (NSString *propertyName) {
        __strong typeof(self) strongSelf = weakSelf;
        
        SEL sel = NSSelectorFromString(propertyName);
        if ( !sel ) return nil;
        SuppressPerformSelectorLeakWarning(
                                           return [strongSelf performSelector:NSSelectorFromString(propertyName)];
                                           );
    };
    
    return icp_block;
}

@end
