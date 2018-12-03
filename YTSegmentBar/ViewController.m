//
//  ViewController.m
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import "ViewController.h"
#import "YTSegmentBarVC.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"

#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) YTSegmentBarVC *segmentVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, kScreen_Width, 35);
    self.segmentVC.segmentBar.showIndicator = YES;
    self.navigationItem.titleView = self.segmentVC.segmentBar;
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    NSArray *items = @[@"关注", @"发现", @"同城美女帅哥",@"美女",@"帅哥",@"渣男渣女"];
    OneViewController *one = [[OneViewController alloc] init];
    TwoViewController *two = [[TwoViewController alloc] init];
    ThreeViewController *three = [[ThreeViewController alloc] init];
    FourViewController *four = [[FourViewController alloc] init];
    FiveViewController *five = [[FiveViewController alloc] init];
    SixViewController *six = [[SixViewController alloc] init];
    [self.segmentVC setUpWithItems:items ChildVCs:@[one,two,three,four,five,six]];
    self.segmentVC.segmentBar.selectIndex = 2;
    [self.segmentVC.segmentBar updateWithConfig:^(YTSegmentBarConfig *config) {
        config.itemNormalColor([UIColor lightGrayColor]).itemSelectColor([UIColor orangeColor]).indicatorColor([UIColor redColor]);
    }];
}

- (YTSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        _segmentVC = [[YTSegmentBarVC alloc] init];
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
