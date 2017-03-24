//
//  LSLiveModel.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/3.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSCategoryListModel;
@interface LSCategoryModel : NSObject

@property (nonatomic, strong) NSString *name; //名称
@property (nonatomic, assign) NSInteger categoryId; //id
@property (nonatomic, assign) NSInteger screen;
/** 1为推荐 2为其它 */
@property (nonatomic, assign) NSInteger type; //类别 类型
/** 是否显示在推荐列表 */
@property (nonatomic, assign) NSInteger isDefault;
/** 类型 空为推荐 */
@property (nonatomic, strong) NSString  *slug;
/** 数据 */
@property (nonatomic, strong) NSArray<LSCategoryListModel *> *list;

@end


/** 列表数据 */
@interface LSCategoryListModel : NSObject

/** 大图地址 */
@property (nonatomic, strong) NSURL    *thumb;
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
