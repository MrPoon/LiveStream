//
//  NSMutableDictionary+Swizzling.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/22.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "NSMutableDictionary+Swizzling.h"


//抽象类 - 真实类（类簇）
//NSArray -> __NSArrayI
//NSMutableArray -> __NSArrayM
//NSDictionary -> __NSDictionaryI
//NSMutableDictionary -> __NSDictionaryM

@implementation NSMutableDictionary (Swizzling)
+(void)load
{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(objectForKey:) andSwizzlingMethod:@selector(sw_objectForKey:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(removeObjectForKey:) andSwizzlingMethod:@selector(sw_removeObjectForKey:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(setObject:forKey:) andSwizzlingMethod:@selector(sw_setObject:forKey:) andIsInstanceMethod:YES];
    });
}


- (id)sw_objectForKey:(id<NSCopying>)aKey
{
    if (aKey == nil) {
        return nil;
    }
    return [self sw_objectForKey:aKey];
}
- (void)sw_removeObjectForKey:(id<NSCopying>)aKey
{
    if (aKey == nil) {
        return;
    }
    [self sw_removeObjectForKey:aKey];
    
}
- (void)sw_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject == nil || aKey == nil) {
        return;
    }
    [self sw_setObject:anObject forKey:aKey];
}

@end
