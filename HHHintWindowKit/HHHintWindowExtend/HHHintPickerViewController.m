//
//  HHHintPickerViewController.m
//  HHWindowHintViewDemo
//
//  Created by lingaohe on 5/21/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHHintPickerViewController.h"

/*
 * HintWindow中的ViewController类的实现可以分为两个部分：
 * 第一部分：ViewController类的实现，包括SetupData和SetupView，显示和消失时各个viewControllerWillXXXX方法的实现，在其中调整界面的布局等
 * 第二部分：ViewController类中的ContentView（UIView）的实现，ContentView可以单独实现，然后通过addSubview的方式添加到ViewController中。
 */

//Define
//Tag
#define TAG_OF_PICKER_VIEW 300
#define TAG_OF_HEADER_VIEW 301
#define TAG_OF_HEADER_CLOSE_BTN 302
#define TAG_OF_HEADER_TITLE_LABEL 303
//Size
#define HEIGHT_OF_HEADER_VIEW 44.0f
#define HEIGHT_OF_PICKER_VIEW 162.0f
#define HEIGHT_OF_TOTAL_VIEW (HEIGHT_OF_HEADER_VIEW+HEIGHT_OF_PICKER_VIEW)

//HHHintPickerViewDataUnit
@implementation HHHintPickerViewDataUnit
@end

//ViewController中的ContentView的实现
//HHHintPickerView
@interface HHHintPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) VoidArrayBlock closeBlock;
@property (nonatomic, strong) StringArrayBlock selectBlock;
@property (nonatomic, strong) NSArray *dataSource;
@end
@implementation HHHintPickerView
#pragma mark -- Init
- (id)init
{
  self = [super init];
  if (self) {
    [self setupView];
  }
  return self;
}
#pragma mark --UIView
- (void)setupView
{
  self.backgroundColor = [UIColor whiteColor];
  //Header
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
  UILabel *titleLabel = [[UILabel alloc] init];
  UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [closeBtn setTitle:@"Done" forState:UIControlStateNormal];
  [closeBtn addTarget:self action:@selector(handleCloseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  titleLabel.tag = TAG_OF_HEADER_TITLE_LABEL;
  closeBtn.tag = TAG_OF_HEADER_CLOSE_BTN;
  self.titleLabel = titleLabel;
  headerView.tag = TAG_OF_HEADER_VIEW;
  [self addSubview:headerView];
  [headerView addSubview:titleLabel];
  [headerView addSubview:closeBtn];
  //PickerView
  UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
  pickerView.showsSelectionIndicator = YES;
  pickerView.dataSource = self;
  pickerView.delegate = self;
  pickerView.tag = TAG_OF_PICKER_VIEW;
  [self addSubview:pickerView];
}
- (void)setupViewFrame
{
  //HeaderView
  UIView *headerView = [self viewWithTag:TAG_OF_HEADER_VIEW];
  headerView.frame = CGRectMake(0, 0, self.frame.size.width, HEIGHT_OF_HEADER_VIEW);
  UIView *titleLabel = [self viewWithTag:TAG_OF_HEADER_TITLE_LABEL];
  UIView *closeBtn = [self viewWithTag:TAG_OF_HEADER_CLOSE_BTN];
  CGFloat btnWidth = 50.0f;
  CGFloat btnHeight = headerView.frame.size.height;
  titleLabel.frame = CGRectMake(0, 0, headerView.frame.size.width-btnWidth, headerView.frame.size.height);
  closeBtn.frame = CGRectMake(titleLabel.frame.size.width, 0, btnWidth, btnHeight);
  //PickerView
  UIView *pickerView = [self viewWithTag:TAG_OF_PICKER_VIEW];
  pickerView.frame = CGRectMake(0, HEIGHT_OF_HEADER_VIEW, self.frame.size.width, HEIGHT_OF_PICKER_VIEW);
}
- (void)setupHorizontalViewFrame
{
  [self setupViewFrame];
}
- (void)setupVerticalViewFrame
{
  [self setupViewFrame];
}
//界面布局
- (void)layoutSubviews
{
  [super layoutSubviews];
  UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
  if (currentOrientation == UIInterfaceOrientationLandscapeLeft
      || currentOrientation == UIInterfaceOrientationLandscapeRight) {
    [self setupHorizontalViewFrame];
  }else{
    [self setupVerticalViewFrame];
  }
}
- (void)setupTitleForPickerView:(UIPickerView *)pickerView
{
  NSArray *selectedIndexArray = [self selectedRowsInPickerView:pickerView];
  NSString *title = nil;
  if (self.selectBlock) {
    title = self.selectBlock(selectedIndexArray);
  }
  self.titleLabel.text = title;
}
#pragma mark -- Data
- (NSArray *)selectedRowsInPickerView:(UIPickerView *)pickerView
{
  NSInteger components = [self numberOfComponentsInPickerView:pickerView];
  NSMutableArray *selectedIndexArray = [NSMutableArray arrayWithCapacity:components];
  for (int index=0; index<components; index++) {
    NSInteger selectedIndex = [pickerView selectedRowInComponent:index];
    [selectedIndexArray addObject:@(selectedIndex)];
  }
  return selectedIndexArray;
}
- (void)setupDefaultData
{
  UIPickerView *pickerView = (UIPickerView *)[self viewWithTag:TAG_OF_PICKER_VIEW];
  NSInteger componentCount = [self numberOfComponentsInPickerView:pickerView];
  for (int component=0; component<componentCount; component++) {
    HHHintPickerViewDataUnit *dataUnit = [self.dataSource objectAtIndex:component];
    [pickerView selectRow:dataUnit.selectedIndex inComponent:component animated:YES];
  }
  [self setupTitleForPickerView:pickerView];
}
#pragma mark UIAcion
- (void)handleCloseBtnAction:(id)sender
{
  UIPickerView *pickerView = (UIPickerView *)[self viewWithTag:TAG_OF_PICKER_VIEW];
  NSArray *selectedIndexArray = [self selectedRowsInPickerView:pickerView];
  if (self.closeBlock) {
    self.closeBlock(selectedIndexArray);
  }
}
#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return [self.dataSource count];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  HHHintPickerViewDataUnit *dataUnit = [self.dataSource objectAtIndex:component];
  return [dataUnit.componentData count];
}
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  HHHintPickerViewDataUnit *dataUnit = [self.dataSource objectAtIndex:component];
  
  NSString *title = [dataUnit.componentData objectAtIndex:row];
  return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  [self setupTitleForPickerView:pickerView];
}
@end


//ViewController的实现
//HHHintPickerViewController
@interface HHHintPickerViewController ()
@property (nonatomic, strong) HHHintPickerView *hintPickerView;
@end

@implementation HHHintPickerViewController

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
  [self setupData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIView
- (void)loadView
{
  [super loadView];
  [self setupView];
}
- (void)setupPickerView
{
  self.hintPickerView = [[HHHintPickerView alloc] init];
  self.hintPickerView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, HEIGHT_OF_TOTAL_VIEW);
  self.hintPickerView.center = CGPointMake(self.view.bounds.size.width/2.0f, self.view.bounds.size.height-self.hintPickerView.bounds.size.height/2.0f);
  self.hintPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  self.hintPickerView.dataSource = self.dataSource;
  self.hintPickerView.selectBlock = self.selectBlock;
  __weak HHHintPickerViewController *pickerViewController = self;
  self.hintPickerView.closeBlock = ^(NSArray *params){
    [pickerViewController close:YES];
    if (pickerViewController.finishBlock) {
      pickerViewController.finishBlock(params);
    }
  };
  [self.view addSubview:self.hintPickerView];
}
- (void)setupView
{
  [self setupPickerView];
  self.view.backgroundColor = [UIColor clearColor];
}
#pragma mark -- Data
- (void)setupData
{
  [self.hintPickerView setupDefaultData];

}
#pragma mark -- UIView Animation
- (void)viewControllerWillShow
{
  self.hintPickerView.center = CGPointMake(self.view.bounds.size.width/2.0f, self.view.bounds.size.height+self.hintPickerView.bounds.size.height/2.0f);
}
- (void)viewControllerWillOnForeground
{
  self.hintPickerView.center = CGPointMake(self.view.bounds.size.width/2.0f, self.view.bounds.size.height-self.hintPickerView.bounds.size.height/2.0f);
}
- (void)viewControllerDidShow
{
  self.hintPickerView.center = CGPointMake(self.view.bounds.size.width/2.0f, self.view.bounds.size.height-self.hintPickerView.bounds.size.height/2.0f);
}
- (void)viewControllerWillClose
{
}
- (void)viewControllerWillOnBackground
{
  self.hintPickerView.center = CGPointMake(self.view.bounds.size.width/2.0f, self.view.bounds.size.height+self.hintPickerView.bounds.size.height/2.0f);
}
@end
