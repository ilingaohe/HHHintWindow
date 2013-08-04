//
//  DemoViewController.m
//  HHHintWindowKit
//
//  Created by lingaohe on 8/4/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "DemoViewController.h"
#import "HHHintPickerViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

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
  [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- UIView
- (void)setupView
{
  //
  self.view.backgroundColor = [UIColor whiteColor];
  //
  float btnWidth = 100.0f;
  float btnHeight = 44.0f;
  float screenWidth = [UIScreen mainScreen].bounds.size.width;
  //  float screenHeight = [UIScreen mainScreen].bounds.size.height;
  //BtnOne
  UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  btnOne.frame = CGRectMake((screenWidth-btnWidth)/2, 100+btnHeight, btnWidth, btnHeight);
  [btnOne setTitle:@"BtnOne" forState:UIControlStateNormal];
  [btnOne addTarget:self action:@selector(handleBtnOneAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btnOne];
}
#pragma mark -- UIAction
- (void)handleBtnOneAction:(id)sender
{
  //显示一个UIWindow中提示UIPickerView选择的例子
  NSArray *FirstComponent = @[@"FPick1",@"FPick2",@"FPickT3"];
  HHHintPickerViewDataUnit *FirstDataUnit = [[HHHintPickerViewDataUnit alloc] init];
  FirstDataUnit.componentData = FirstComponent;
  FirstDataUnit.selectedIndex = 0;
  NSArray *SecondComponent = @[@"SPick1",@"SPick2",@"SPick3"];
  HHHintPickerViewDataUnit *SecondDataUnit = [[HHHintPickerViewDataUnit alloc] init];
  SecondDataUnit.componentData = SecondComponent;
  SecondDataUnit.selectedIndex = 1;
  //创建用于在Window中显示的ViewController
  HHHintPickerViewController *pickerViewController = [[HHHintPickerViewController alloc] init];
  pickerViewController.dataSource = @[FirstDataUnit, SecondDataUnit];
  pickerViewController.selectBlock = ^(NSArray *params){
    NSString *firstValue = [FirstComponent objectAtIndex:[[params objectAtIndex:0] integerValue]];
    NSString *secondValue = [SecondComponent objectAtIndex:[[params objectAtIndex:1] integerValue]];
    NSString *title = [NSString stringWithFormat:@"1:%@,2:%@",firstValue,secondValue];
    return title;
  };
  pickerViewController.finishBlock = ^(NSArray *params){
    NSNumber *firstIndex = [params objectAtIndex:0];
    NSNumber *secondIndex = [params objectAtIndex:1];
    NSLog(@"FirstIndex:%@,SecondIndex:%@",firstIndex, secondIndex);
  };
  //以在Window中的方式显示ViewController
  [pickerViewController show:YES];
}
@end
