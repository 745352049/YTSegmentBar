//
//  YTSegmentBarConfig.h
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YTSegmentBarConfig : NSObject

/**
 单例
 */
+ (instancetype)shareInstance;

// SegmentBar背景颜色
@property (nonatomic, strong) UIColor *segmentBarBackGroundC;
// 默认颜色
@property (nonatomic, strong) UIColor *itemNormalC;
// 选中颜色
@property (nonatomic, strong) UIColor *itemSelectC;
// 标签字号
@property (nonatomic, strong) UIFont *itemF;
// 指示器颜色
@property (nonatomic, strong) UIColor *indicatorC;
// 指示器高
@property (nonatomic, assign) CGFloat indicatorH;
// 指示器宽
@property (nonatomic, assign) CGFloat indicatorW;

/**
 背景颜色
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^segmentBarBackGroundColor)(UIColor *color);

/**
 默认颜色
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^itemNormalColor)(UIColor *color);

/**
 选中颜色
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^itemSelectColor)(UIColor *color);

/**
 文字字体大小
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^itemFont)(UIFont *font);

/**
 指示器颜色
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^indicatorColor)(UIColor *color);

/**
 指示器高度
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^indicatorHeight)(CGFloat h);

/**
 指示器宽度
 */
@property (nonatomic, copy, readonly) YTSegmentBarConfig *(^indicatorWidth)(CGFloat w);

@end
