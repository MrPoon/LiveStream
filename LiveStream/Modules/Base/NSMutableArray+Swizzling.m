//
//  NSMutableArray+Swizzling.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/22.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"

@implementation NSMutableArray (Swizzling)
+(void)load
{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(objectAtIndex:) andSwizzlingMethod:@selector(sw_objectAtIndex:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(addObject:) andSwizzlingMethod:@selector(sw_addObject:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(insertObject:atIndex:) andSwizzlingMethod:@selector(sw_insertObject:atIndex:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(removeObject:) andSwizzlingMethod:@selector(sw_removeObject:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(removeObjectAtIndex:) andSwizzlingMethod:@selector(sw_removeObjectAtIndex:) andIsInstanceMethod:YES];
        [objc_getClass("__NSDictionaryM") MethodExchangeWithOriginMethod:@selector(replaceObjectAtIndex:withObject:) andSwizzlingMethod:@selector(sw_replaceObjectAtIndex:withObject:) andIsInstanceMethod:YES];
    });
}

-(id)sw_objectAtIndex:(NSUInteger)index
{
    if (index == 0) {
        return nil;
    }
    if (index > self.count) {
        return nil;
    }
    return [self sw_objectAtIndex:index];
}

- (void)sw_addObject:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    [self sw_addObject:anObject];
}

- (void)sw_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        return;
    }
    [self sw_insertObject:anObject atIndex:index];
}
- (void)sw_removeObject:(id)anObject;
{
    if (anObject == nil) {
        return;
    }
    [self sw_removeObject:anObject];
}
- (void)sw_removeObjectAtIndex:(NSUInteger)index
{
    if (index > self.count) {
        return;
    }
    [self sw_removeObjectAtIndex:index];
}
- (void)sw_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index > self.count) {
        return;
    }
    if (anObject == nil) {
        return;
    }
    [self sw_replaceObjectAtIndex:index withObject:anObject];
}
@end
