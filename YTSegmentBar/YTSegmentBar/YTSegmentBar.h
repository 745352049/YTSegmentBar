//
//  YTSegmentBar.h
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSegmentBarConfig.h"

@class YTSegmentBar;

@protocol YTSegmentBarDelegate <NSObject>

/**
 通知外界内部的点击数据
 
 @param segmentBar segmentBar
 @param toIndex 选中的索引从0 开始
 @param fromIndex 上一个索引
 */
- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface YTSegmentBar : UIView

/**
 快速创建一个选项卡控件
 
 @param frame frame
 @return segment
 */
+ (instancetype)segmentBarWithFrame: (CGRect)frame;

/**
 代理
 */
@property (nonatomic, weak) id<YTSegmentBarDelegate> delegate;

/**
 是否显示指示器
 */
@property (nonatomic, assign) BOOL showIndicator;

/**
 数据源
 */
@property (nonatomic, strong) NSArray<NSString *> *items;

/**
 当前选中的索引 双向设置
 */
@property (nonatomic, assign) NSInteger selectIndex;

- (void)updateWithConfig:(void(^)(YTSegmentBarConfig *config))configBlock;

@end
