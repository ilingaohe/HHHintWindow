//
//  HHHintConfiguration.m
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHHintConfiguration.h"

static HHHintConfiguration *configuration = nil;

@implementation HHHintConfiguration

+ (HHHintConfiguration *)sharedHHHintConfiguration
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    configuration = [[HHHintConfiguration alloc] init];
  });
  return configuration;
}
@end
