//
//  HHHintPickerViewController.h
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHHintBaseViewController.h"

//使用Window进行Hint显示的ViewController，这个类实现提示Picker选择的效果

//定义Block：typedef returnType(^ReturnTypeParamTypeBlock)(ParamType);
typedef void(^VoidVoidBlock)(void);
typedef NSString *(^StringArrayBlock)(NSArray *params);
typedef void(^VoidArrayBlock)(NSArray *params);

//
@interface HHHintPickerViewDataUnit : NSObject
@property (nonatomic, strong) NSArray *componentData;
@property (nonatomic, assign) NSUInteger selectedIndex;
@end
//
@interface HHHintPickerViewController : HHHintBaseViewController

@property (nonatomic, strong) VoidArrayBlock finishBlock;
@property (nonatomic, strong) StringArrayBlock selectBlock;
@property (nonatomic, strong) NSArray *dataSource;
@end
