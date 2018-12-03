//
//  YTSegmentBarVC.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import "YTSegmentBarVC.h"
#import "UIView+YTSegmentBar.h"

@interface YTSegmentBarVC ()<UIScrollViewDelegate, YTSegmentBarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YTSegmentBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setUpWithItems:(NSArray<NSString *> *)items ChildVCs:(NSArray<UIViewController *> *)childVCs{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致, 请自己检查");
    self.segmentBar.items = items;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    self.scrollView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    self.segmentBar.selectIndex = 0;
}

- (void)showChildVCViewAtIndex:(NSInteger)index {
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
    [self.scrollView addSubview:vc.view];
    // 滑动到对应位置
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.width, 0) animated:YES];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, 60, self.scrollView.width, 35);
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.scrollView.frame = contentFrame;
        self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        
        return;
    }
    
    CGRect contentFrame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.scrollView.frame = contentFrame;
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    self.segmentBar.selectIndex = self.segmentBar.selectIndex;
}

#pragma mark - YTSegmentBarDelegate
- (void)segmentBar:(YTSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showChildVCViewAtIndex:toIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = self.scrollView.contentOffset.x/self.scrollView.width;
    self.segmentBar.selectIndex = index;
}

- (YTSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [YTSegmentBar segmentBarWithFrame:self.view.bounds];
        _segmentBar.delegate = self;
        _segmentBar.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
