//
//  ViewController.m
//  Example
//
//  Created by weil on 2018/12/13.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "ViewController.h"
#import "LWNavigationBar.h"

@interface ViewController ()
//左右中间皆为文字
@property (nonatomic,strong) LWNavigationBar *bar1;
//左右为图片中间为文字
@property (nonatomic,strong) LWNavigationBar *bar2;
//左文字右图片或者左图片右文字中间文字
@property (nonatomic,strong) LWNavigationBar *bar3;
//动态控制左右item的隐藏和显示
@property (nonatomic,strong) LWNavigationBar *bar4;
//左右和中间可自定义view
@property (nonatomic,strong) LWNavigationBar *bar5;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupBar1];
    [self p_setupBar2];
    [self p_setupBar3];
    [self p_setupBar4];
    [self p_setupBar5];
}
- (void)p_setupBar1 {
    //带下划线
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemTextLine];
    [leftItem lw_setItemTitle:@"左边"];
    [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [leftItem lw_setItemTitleColor:[UIColor redColor]];
    [leftItem lw_setItemLineColor:[UIColor whiteColor]];
    
    
    LWNavigationBarItem *item2 = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [item2 lw_setItemTitle:@"右边"];
    [item2 lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [item2 lw_setItemTitleColor:[UIColor whiteColor]];
    
    LWNavigationBarItem *item3 = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [item3 lw_setItemTitle:@"很长很长很长的标题"];
    [item3 lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [item3 lw_setItemTitleColor:[UIColor darkGrayColor]];
    
    self.bar1 = [[LWNavigationBar alloc] init];
    self.bar1.backgroundColor = [UIColor lightGrayColor];
    [self.bar1 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar1 lw_setBarContentInset:15];
    [self.bar1 lw_addItemToLeft:leftItem];
    [self.bar1 lw_addItemToRight:item2];
    [self.bar1 lw_addItemToTitle:item3];
    self.bar1.frame = CGRectMake(0, 0, self.view.frame.size.width, 88);
    [self.bar1 lw_reloadItems];
    [self.view addSubview:self.bar1];
}
- (void)p_setupBar2 {
    
}
- (void)p_setupBar3 {
    
}
- (void)p_setupBar4 {
    
}
- (void)p_setupBar5 {
    
}

- (void)p_clickBar4 {
    
}

@end
