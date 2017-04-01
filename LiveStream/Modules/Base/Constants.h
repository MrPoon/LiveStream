//
//  Header.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - 设备相关

//屏幕的宽度,支持旋转屏幕
#define kScreen_Width                                                                                  \
((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)                            \
? (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) \
? [UIScreen mainScreen].bounds.size.height                                              \
: [UIScreen mainScreen].bounds.size.width)                                              \
: [UIScreen mainScreen].bounds.size.width)

//屏幕的高度,支持旋转屏幕
#define kScreen_Height                                                                                 \
((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)                            \
? (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) \
? [UIScreen mainScreen].bounds.size.width                                               \
: [UIScreen mainScreen].bounds.size.height)                                             \
: [UIScreen mainScreen].bounds.size.height)


//计算比例后的宽度
#define SCREEN_SCALE_WIDTH(w)  (w*(kScreen_Width/320.0f))
//计算比例后高度
#define SCREEN_SCALE_HEIGHT(h)  (h*(kScreen_Height/568.0f))

#define GATEGORYINFO @"http://www.quanmin.tv/json/app/index/category/info-iphone.json"
#define LIVESTREAMURL @"http://hls.quanmin.tv/live/%td/playlist.m3u8"


#endif /* Header_h */
