//
//  NSObject+MethodSwizzling.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/22.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzling)

+(void)MethodExchangeWithOriginMethod:(SEL)originSelector andSwizzlingMethod:(SEL)swizzlingSelector andIsInstanceMethod:(BOOL)isInstanceMethod;

@end
