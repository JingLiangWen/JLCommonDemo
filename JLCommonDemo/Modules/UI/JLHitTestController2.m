//
//  JLHitTestController2.m
//  JLCommonDemo
//
//  Created by 温敬亮 on 17/1/7.
//  Copyright © 2017年 lanyou. All rights reserved.
//

#import "JLHitTestController2.h"

@interface JLRedView : UIView

@end

@implementation JLRedView


/**
 往往重写这个方法都是超出的那个父View进行重写
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            // 讲点击的point(这个点是相对父View) 转 到子View的坐标系。
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            // 让子View判断是否命中，这个point
            UIView *result = [subview hitTest:subPoint withEvent:event];
            if (result != nil) {
                return result;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

@end

@interface JLHitTestController2 ()
@property (strong, nonatomic) IBOutlet UIView *outSideBtn;
@property (weak, nonatomic) IBOutlet UIButton *inSideBtn;

@end

@implementation JLHitTestController2

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)clickInside:(id)sender {
    NSLog(@"里面！");
}
- (IBAction)clickOutBtn:(id)sender {
    NSLog(@"外面！");
}


@end
