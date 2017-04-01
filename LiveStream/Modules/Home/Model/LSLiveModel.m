//
//  LSLiveModel.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/3.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSLiveModel.h"

@implementation LSCategoryModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"categoryId" : @"id"
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : @"LSLiveModel"
             };
}
@end

@implementation LSLiveModel
@end
