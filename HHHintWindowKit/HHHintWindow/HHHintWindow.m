//
//  HHHintWindow.m
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHHintWindow.h"

@implementation HHHintWindow

- (void)makeKeyAndVisible
{
  //先保存就的KeyWindow
  self.oldKeyWindow = [[UIApplication sharedApplication] keyWindow];
  self.windowLevel = UIWindowLevelNormal;
  self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
  [super makeKeyAndVisible];
}
- (void)resignKeyWindow
{
  [super resignKeyWindow];
  //恢复旧的KeyWindow
  [self.oldKeyWindow makeKeyAndVisible];
}
@end
