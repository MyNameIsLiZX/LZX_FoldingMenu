//
//  ViewController.m
//  LZX_FoldingMenu
//
//  Created by twzs on 2017/8/8.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import "ViewController.h"

#import "LZX_FoldingMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *bgcolor = [UIColor blueColor];
    
    UIColor *textColor = [UIColor blackColor];
    
    LZX_FoldingMenuView *menview = [[LZX_FoldingMenuView alloc]initForm:CGRectMake(20, 100, self.view.bounds.size.width-40, 50) superController:self TitleArr:@[@"左面",@"中间",@"右面",@"第四个"] bgColor:bgcolor TitleColor:textColor titleFont:18 listArr:@[@[@"第一行",@"第二行",@"第三行",@"第四行"],@[@"第一行",@"第二行",@"第三行"],@[@"第一行",@"第二行",@"第三行"],@[@"第四"]]];
    
    menview.block = ^(NSInteger index1,NSInteger index2) {
        NSLog(@"你点击了第%ld列第%ld行",index1,index2);
    };
    
    [self.view addSubview:menview];
    
}



@end
