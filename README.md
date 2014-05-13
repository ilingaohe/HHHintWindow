HHHintWindow
============

###说明：

iOS上显示用于提示的Hint内容有可以有两种方式。第一种方式为创建UIView，然后以addSubview的方式添加到当前的View中进行显示，如[HHHintView](https://github.com/ilingaohe/HHHintView)中的实现。第二种方式为创建UIViewController，然后作为新建的UIWindow的rootViewController，再通过UIWindow的makeKeyAndVisible的方式进行显示。

[HHHintWindow](https://github.com/ilingaohe/HHHintWindow)是第二种方式即以UIWindow的方式进行Hint提示的一种是实现。

###使用要求和方式：

1、需要iOS5.0及以上，和开启ARC

###示例代码：

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

更多代码请参考Demo和HHHintWindow的具体实现。

###后续：

目前只提供了HHHintPickerViewController一个基于UIWindow提示的类，后续会根据实际的需要添加更多的现成类。开发者也可以参考HHHintPickerViewController自己创建使用UIWindow进行提示的类




