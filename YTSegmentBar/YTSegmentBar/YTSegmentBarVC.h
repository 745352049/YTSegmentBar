//
//  YTSegmentBarVC.h
//  YTSegmentBar
//
//  Created by 水晶岛 on 2018/12/3.
//  Copyright © 2018 水晶岛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSegmentBar.h"

@interface YTSegmentBarVC : UIViewController

@property (nonatomic, strong) YTSegmentBar *segmentBar;
- (void)setUpWithItems:(NSArray <NSString *>*)items ChildVCs:(NSArray <UIViewController *>*)childVCs;

@end
