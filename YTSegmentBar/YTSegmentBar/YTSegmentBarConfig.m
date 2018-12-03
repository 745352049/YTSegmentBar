//
//  YTSegmentBarConfig.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import "YTSegmentBarConfig.h"

@implementation YTSegmentBarConfig

+ (instancetype)shareInstance {
    static YTSegmentBarConfig *segmentBarConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        segmentBarConfig = [[self alloc] init];
        segmentBarConfig.segmentBarBackGroundC = [UIColor clearColor];
        segmentBarConfig.itemF = [UIFont systemFontOfSize:20];
        segmentBarConfig.itemNormalC = [UIColor lightGrayColor];
        segmentBarConfig.itemSelectC = [UIColor redColor];
        segmentBarConfig.indicatorC = [UIColor redColor];
        segmentBarConfig.indicatorH = 2;
        segmentBarConfig.indicatorW = 10;
    });
    return segmentBarConfig;
}

- (YTSegmentBarConfig *(^)(UIColor *))segmentBarBackGroundColor {
    return ^(UIColor *color){
        self.segmentBarBackGroundC = color;
        return self;
    };
}

- (YTSegmentBarConfig *(^)(UIFont *))itemFont{
    return ^(UIFont *font){
        self.itemF = font;
        return self;
    };
}

- (YTSegmentBarConfig *(^)(UIColor *))itemNormalColor{
    return ^(UIColor *color){
        self.itemNormalC = color;
        return self;
    };
}

- (YTSegmentBarConfig *(^)(UIColor *))itemSelectColor{
    return ^(UIColor *color){
        self.itemSelectC = color;
        return self;
    };
}

- (YTSegmentBarConfig *(^)(UIColor *))indicatorColor{
    return ^(UIColor *color){
        self.indicatorC = color;
        return self;
    };
}

- (YTSegmentBarConfig *(^)(CGFloat))indicatorHeight{
    return ^(CGFloat H){
        self.indicatorH = H;
        return self;
    };
}

- (YTSegmentBarConfig *(^)(CGFloat))indicatorWidth{
    return ^(CGFloat W){
        self.indicatorW = W;
        return self;
    };
}

@end
