//
//  HHHintBaseViewController.h
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>

//放在Window中显示的ViewController的基类
@interface HHHintBaseViewController : UIViewController

//Window显示时的一些事件模拟，继承的子类根据情况实现
- (void)viewControllerWillShow;
- (void)viewControllerWillClose;
- (void)viewControllerWillOnForeground;
- (void)viewControllerWillOnBackground;
- (void)viewControllerDidShow;
- (void)viewControllerDidClose;
- (void)viewControllerDidChangeOver;
//Window显示和消失方法
- (void)show:(BOOL)animated;
- (void)close:(BOOL)animated;
//Window中的ViewController切换
- (void)changeToViewController:(HHHintBaseViewController *)viewContoller;

@end
