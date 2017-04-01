//
//  LSLiveModel.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/3.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSLiveModel;
@interface LSCategoryModel : NSObject

@property(nonatomic, strong) NSString *name; //名称
@property(nonatomic, assign) NSInteger categoryId; //id
@property(nonatomic, assign) NSInteger screen;
@property(nonatomic, assign) NSInteger type; //类别
@property(nonatomic, assign) NSInteger is_default;
@property(nonatomic, strong) NSString  *slug;
@property(nonatomic, strong) NSString *icon_image;
@property(nonatomic, strong) NSString *icon_red;
@property(nonatomic, strong) NSString *icon_gray;
@property(nonatomic, strong) NSArray<LSLiveModel *> *list;

@end























/** 列表数据 */
@interface LSLiveModel : NSObject

/** 大图地址 */
@property (nonatomic, strong) NSString  *thumb;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 头像 */
@property (nonatomic, strong) NSURL    *avatar;
/** 名字 */
@property (nonatomic, strong) NSString *nick;
/** uid */
@property (nonatomic, assign) NSInteger uid;
/** 观看人数 */
@property (nonatomic, strong) NSString *view;
/** 类型名字 */
@property (nonatomic, strong) NSString *categoryName;
/** 类型id */
@property (nonatomic, strong) NSString *categoryId;
/** 类型 */
@property (nonatomic, strong) NSString *categorySlug;
@end
