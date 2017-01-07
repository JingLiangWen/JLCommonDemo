//
//  JLHitTestController.m
//  JLCommonDemo
//
//  Created by 温敬亮 on 17/1/7.
//  Copyright © 2017年 lanyou. All rights reserved.
//

#import "JLHitTestController.h"
#import "UIView+Utils.h"

@interface JLHitTestController ()
@property (weak, nonatomic) IBOutlet UIView *greyView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation JLHitTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%@",NSStringFromCGRect(self.greyView.frame));   // {{50, 120}, {240, 240}}
    NSLog(@"%@",NSStringFromCGRect(self.yellowView.frame)); // {{180, 180}, {40, 40}}
    NSLog(@"%@",NSStringFromCGRect(self.blueView.frame));   // {{50, 360}, {60, 60}}
    NSLog(@"-------------------------------------------------");
    
    // 灰色View中的黄色View相对于self.view中的位置
    CGRect rec1 = [self.view convertRect:self.yellowView.frame fromView:self.greyView];
    NSLog(@"%@",NSStringFromCGRect(rec1));  //  {{230, 300}, {40, 40}}
    
    CGRect rec2 = [self.view convertRect:self.yellowView.bounds fromView:self.greyView];
    NSLog(@"%@",NSStringFromCGRect(rec2)); //  {{50, 120}, {40, 40}}
    
    // 在黄色View中，定义一个相对于黄色View（50，50），大小为（20，20）的View，这个View相对于蓝色View的位置
    CGRect newRect = [self.yellowView convertRect:CGRectMake(50, 50, 20, 20) toView:self.blueView];
    NSLog(@"%@",NSStringFromCGRect(newRect));
    
    // 在黄色View中，定义一个目标区域，该区域相对于window的位置（nil代表的是self.view.window）
    CGRect newRect2 = [self.yellowView convertRect:CGRectMake(50, 50, 20, 20) toView:nil];
    NSLog(@"%@",NSStringFromCGRect(newRect2));
    
    // 下面来展示三个方法如何做到黄色View在Window中的位置
    NSLog(@"\n下面来展示三个方法如何做到黄色View在Window中的位置");
    // 在yellowView中，有个和yellowView一样的大小的区域bounds，此区域相对于window的位置
    CGRect newRect3 = [self.yellowView convertRect:self.yellowView.bounds toView:nil];
    // 在greyView中，其子视图yellowView的frame区域，相对于window的位置
    CGRect newRect4 = [self.greyView convertRect:self.yellowView.frame toView:nil];
    NSLog(@"%@",NSStringFromCGRect(newRect3));
    NSLog(@"%@",NSStringFromCGRect(newRect4));
    
    //
    CGRect newRect5 = [self.view.window convertRect:self.yellowView.bounds fromView:self.yellowView];
    NSLog(@"%@",NSStringFromCGRect(newRect5));
    
    /**
     总结：
     toView就是从左往右开始读代码，也是从左往右理解意思
     fromView就是从右往左开始读代码，也是从右往左理解意思
     - A(CGPoint)convertPoint:B(CGPoint)point toView:C(nullable UIView *)view;
     - A(CGPoint)convertPoint:B(CGPoint)point fromView:C(nullable UIView *)view;
     第一句代表
     A区域里面有个坐标B,需要把相对于A的坐标B转换成相对于C的坐标
     
     第二句代表
     从C区域里面转换坐标B，需要把相对于C的坐标转换成相对于A的坐标
     
     
     -----------
     
     CGRectContainsRect(<#CGRect rect1#>, <#CGRect rect2#>)
     CGRectContainsPoint(<#CGRect rect#>, <#CGPoint point#>)
     CGRectIntersectsRect(<#CGRect rect1#>, <#CGRect rect2#>)
     
     1.表示rect1和rect2是否相交
     2.表示rect中是否包含point坐标
     3.表示rect1中是否包含rect2
     
     ----------------
     
     - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
     {
     if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
     for (UIView *subview in self.subviews.reverseObjectEnumerator) {
     CGPoint subPoint = [subview convertPoint:point fromView:self];
     UIView *result = [subview hitTest:subPoint withEvent:event];
     if (result != nil) {
     return result;
     }
     }
     }
     
     return nil;
     }
     
     */
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UIView *centerView = [[UIView alloc]init];
//    centerView.backgroundColor = [UIColor redColor];
//    centerView.frame = self.greyView.bounds;
//    centerView.size = CGSizeMake(20, 20);
//    centerView.centerX = self.greyView.centerX - self.greyView.left;
//    centerView.centerY = self.greyView.centerY - self.greyView.top;
//    [self.greyView addSubview:centerView];
//    NSLog(@"%@",NSStringFromCGRect(centerView.frame));
    
    // 在window上添加一个redView，这个redView的位置，位于灰色View的中央
    // CGRectMake(110,110, 20, 20) 就是相对于greyView的坐标。
    CGRect r = [self.greyView convertRect:CGRectMake(110,110, 20, 20) toView:nil];
    UIView *redView = [[UIView alloc]initWithFrame:r];
    redView.backgroundColor = [UIColor redColor];
    [[UIApplication sharedApplication].keyWindow addSubview:redView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
