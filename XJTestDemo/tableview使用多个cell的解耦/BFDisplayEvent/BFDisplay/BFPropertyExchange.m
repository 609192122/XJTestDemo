//
//  BFPropertyExchange.m
//  XJTestDemo
//
//  Created by mac on 2020/7/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BFPropertyExchange.h"
#import "objc/runtime.h"
#import "objc/message.h"

static void *kPropertyNameKey = &kPropertyNameKey;

@implementation BFPropertyExchange

- (NSDictionary *)em_exchangeKeyFromPropertyName{
    return nil;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

/**
 消息转发
 
 @param aSelector 方法
 @return 调用方法的描述签名
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSString *propertyName = NSStringFromSelector(aSelector);
    
    NSDictionary *propertyDic = [self em_exchangeKeyFromPropertyName];
    
    NSMethodSignature* (^doGetMethodSignature)(NSString *propertyName) = ^(NSString *propertyName){
        //创建新签名
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        objc_setAssociatedObject(methodSignature, kPropertyNameKey, propertyName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return  methodSignature;
    };
    

    if ( [propertyDic.allKeys containsObject:propertyName] ) {
        NSString *targetPropertyName = [NSString stringWithFormat:@"em_%@",propertyName];
        if ( ![self respondsToSelector:NSSelectorFromString(targetPropertyName)] ) {
            // 如果没有em_重写属性，则用转换字典中属性替换
            targetPropertyName = [propertyDic objectForKey:propertyName];
        }
        
        return doGetMethodSignature(targetPropertyName);
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSString *originalPropertyName = objc_getAssociatedObject(anInvocation.methodSignature, kPropertyNameKey);
    if ( originalPropertyName ) {
        //NSInvocation对原来签名的方法执行新的方法，必须指定Selector和Target，invoke或invokeWithTarget执行
        anInvocation.selector = NSSelectorFromString(originalPropertyName);
        [anInvocation invokeWithTarget:self];
    }
}

@end
