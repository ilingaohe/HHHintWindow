//
//  HHHintConfiguration.h
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <Foundation/Foundation.h>

//用来保存一些配置信息
@interface HHHintConfiguration : NSObject

@property (nonatomic, strong) UIViewController *topViewController;

+ (HHHintConfiguration *)sharedHHHintConfiguration;
@end
