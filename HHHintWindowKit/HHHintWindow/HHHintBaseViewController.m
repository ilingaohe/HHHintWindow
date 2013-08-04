//
//  HHHintBaseViewController.m
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHHintBaseViewController.h"
#import "HHHintWindow.h"

//Define
//Duration
#define DURATION_OF_VIEW_ANIMATION 0.3f

static HHHintWindow *hintWindow = nil;

@interface HHHintBaseViewController ()

@end

@implementation HHHintBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --
//子类中实现，更加需要，调整界面布局等
//Window中的ViewController将要显示的时候，依次调用的方法为：viewControllerWillShow->viewControllerWillOnForeground->viewControllerDidShow
//Window中的ViewController将要消失的时候，依次调用的方法为：viewControllerWillClose->viewControllerWillOnBackground->viewControllerDidClose
- (void)viewControllerWillShow
{
}
- (void)viewControllerWillClose
{
}
- (void)viewControllerWillOnForeground
{
}
- (void)viewControllerWillOnBackground
{
}
- (void)viewControllerDidShow
{
}
- (void)viewControllerDidClose
{
  hintWindow.rootViewController = nil;
  [hintWindow resignKeyWindow];
}
//Window中ViewController进行了切换之后新ViewController进行显示时调用的方法
- (void)viewControllerDidChangeOver
{
  [UIApplication sharedApplication].keyWindow.rootViewController = self;
  [self viewControllerWillShow];
  [UIView animateWithDuration:DURATION_OF_VIEW_ANIMATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    [self viewControllerWillOnForeground];
  } completion:^(BOOL finished){
    [self viewControllerDidShow];
  }];
}
#pragma mark -- 
//将Window中的ViewController进行显示
- (void)show:(BOOL)animated
{
  if (!hintWindow) {
    hintWindow = [[HHHintWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  }
  hintWindow.alpha = 0;
  hintWindow.backgroundColor = [UIColor clearColor];
  hintWindow.rootViewController = self;
  [hintWindow makeKeyAndVisible];
  if (animated) {
    [UIView animateWithDuration:DURATION_OF_VIEW_ANIMATION animations:^{
      hintWindow.alpha = 1.0f;
    }];
  }
  //Window中的ViewController显示时调用的顺序：viewControllerWillShow->viewControllerWillOnForeground->viewControllerDidShow
  [self viewControllerWillShow];
  if (animated) {
    [UIView animateWithDuration:DURATION_OF_VIEW_ANIMATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
      [self viewControllerWillOnForeground];
    } completion:^(BOOL finished){
      [self viewControllerDidShow];
    }];
  }else{
    [self viewControllerWillOnForeground];
    [self viewControllerDidShow];
  }
}
//将Window中的ViewController进行消失
- (void)close:(BOOL)animated
{
  if (animated) {
    [UIView animateWithDuration:DURATION_OF_VIEW_ANIMATION animations:^{
      self.view.window.alpha = 0.0f;
    }];
  }
  //Window中的ViewController消失时的调用顺序：viewControllerWillClose->viewControllerWillOnBackground->viewControllerDidClose
  [self viewControllerWillClose];
  if (animated) {
    [UIView animateWithDuration:DURATION_OF_VIEW_ANIMATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      [self viewControllerWillOnBackground];
    } completion:^(BOOL finished){
      [self viewControllerDidClose];
    }];
  }else{
    [self viewControllerWillOnBackground];
    [self viewControllerDidClose];
  }
}
//切换Window中的ViewController到另一个ViewController
- (void)changeToViewController:(HHHintBaseViewController *)viewContoller
{
  //先处理当前ViewController的消失
  [self viewControllerWillClose];
  [UIView animateWithDuration:DURATION_OF_VIEW_ANIMATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    [self viewControllerWillOnBackground];
  } completion:^(BOOL finished){
    //再显示另一个ViewController
    [viewContoller viewControllerDidChangeOver];
  }];
}
@end
