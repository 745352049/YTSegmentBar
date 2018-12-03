//
//  YTSegmentBar.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import "YTSegmentBar.h"
#import "UIView+YTSegmentBar.h"

#define KMinMargin 30

@interface YTSegmentBar ()

/**
 内容承载视图
 */
@property (nonatomic, weak) UIScrollView *contentView;

/**
 添加的按钮数据
 */
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

/**
 指示器
 */
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, strong) YTSegmentBarConfig *config;

@end

@implementation YTSegmentBar {
    // 记录最后一次点击的按钮
    UIButton *_lastBtn;
}

+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    YTSegmentBar *segmentBar = [[YTSegmentBar alloc] initWithFrame:frame];
    return segmentBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.config.segmentBarBackGroundC;
    }
    return self;
}

- (void)updateWithConfig:(void (^)(YTSegmentBarConfig *))configBlock{
    if (configBlock) {
        configBlock(self.config);
    }
    
    self.backgroundColor = self.config.segmentBarBackGroundC;
    if (self.showIndicator) {
        self.indicatorView.backgroundColor = self.config.indicatorC;
    }
    
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemNormalC forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectC forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemF;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    if (self.items.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count- 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}

- (void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    // 删除之前添加过多的组件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    // 根据所有的选项数据源 创建Button 添加到内容视图
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:self.config.itemNormalC forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectC forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemF;
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)btnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:sender.tag fromIndex:_lastBtn.tag];
    }
    
    _selectIndex = sender.tag;
    _lastBtn.selected = NO;
    sender.selected = YES;
    _lastBtn = sender;
    if (self.showIndicator) {
        [UIView animateWithDuration:0.1 animations:^{
            self.indicatorView.width = sender.width + self.config.indicatorW * 2;
            self.indicatorView.centerX = sender.centerX;
        }];
    }
    
    // 滚动到Btn的位置
    CGFloat scrollX = sender.x - self.contentView.width * 0.5;
    
    // 考虑临界的位置
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < KMinMargin) {
        caculateMargin = KMinMargin;
    }
    
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.y = 0;
        btn.x = lastX;
        lastX += btn.width + caculateMargin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    if (self.itemBtns.count == 0) {
        return;
    }
    
    UIButton *btn = self.itemBtns[self.selectIndex];
    if (self.showIndicator) {
        self.indicatorView.width = btn.width + self.config.indicatorW * 2;
        self.indicatorView.centerX = btn.centerX;
        self.indicatorView.height = self.config.indicatorH;
        self.indicatorView.y = self.height - self.indicatorView.height;
    }
}

#pragma mark - lazy-init
- (NSMutableArray <UIButton *> *)itemBtns {
    if (!_itemBtns) {
        _itemBtns = [[NSMutableArray alloc] init];
    }
    return _itemBtns;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorH = self.config.indicatorH;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = self.config.indicatorC;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}

- (YTSegmentBarConfig *)config{
    if (!_config) {
        _config = [YTSegmentBarConfig shareInstance];
    }
    return _config;
}

@end
