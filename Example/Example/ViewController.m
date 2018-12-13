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
//动态更新item，以更新左边item为例
@property (nonatomic,strong) LWNavigationBar *bar6;
//动态增加item，以增加左边item为例
@property (nonatomic,strong) LWNavigationBar *bar7;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupBar1];
    [self p_setupBar2];
    [self p_setupBar3];
    [self p_setupBar4];
    [self p_setupBar5];
    [self p_setupBar6];
    [self p_setupBar7];
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
    [item3 lw_setItemTitleColor:[UIColor whiteColor]];
    
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

    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [leftItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [leftItem lw_setItemImageSize:CGSizeMake(27, 27)];
    
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    
    LWNavigationBarItem *item3 = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [item3 lw_setItemTitle:@"很长很长很长的标题"];
    [item3 lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [item3 lw_setItemTitleColor:[UIColor whiteColor]];
    
    self.bar2 = [[LWNavigationBar alloc] init];
    self.bar2.backgroundColor = [UIColor lightGrayColor];
    [self.bar2 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar2 lw_setBarContentInset:15];
    [self.bar2 lw_addItemToLeft:leftItem];
    [self.bar2 lw_addItemToRight:rightItem];
    [self.bar2 lw_addItemToTitle:item3];
    [self.bar2 lw_showTopStatusView:NO];
    self.bar2.frame = CGRectMake(0, CGRectGetMaxY(self.bar1.frame) + 20, self.view.frame.size.width, 64);
    [self.bar2 lw_reloadItems];
    [self.bar2 lw_updateLineAlpha:0];
    [self.view addSubview:self.bar2];

}
- (void)p_setupBar3 {
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [leftItem lw_setItemTitle:@"左边"];
    [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [leftItem lw_setItemTitleColor:[UIColor redColor]];
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    
    LWNavigationBarItem *item3 = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [item3 lw_setItemTitle:@"很长很长很长的标题"];
    [item3 lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [item3 lw_setItemTitleColor:[UIColor whiteColor]];
    
    self.bar3 = [[LWNavigationBar alloc] init];
    self.bar3.backgroundColor = [UIColor lightGrayColor];
    [self.bar3 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar3 lw_setBarContentInset:15];
    [self.bar3 lw_addItemToLeft:leftItem];
    [self.bar3 lw_addItemToRight:rightItem];
    [self.bar3 lw_addItemToTitle:item3];
    [self.bar3 lw_showTopStatusView:NO];
    self.bar3.frame = CGRectMake(0, CGRectGetMaxY(self.bar2.frame) + 20, self.view.frame.size.width, 64);
    [self.bar3 lw_reloadItems];
    [self.bar3 lw_updateLineAlpha:0];
    [self.view addSubview:self.bar3];
}
- (void)p_setupBar4 {
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [leftItem lw_setItemTitle:@"左边"];
    [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [leftItem lw_setItemTitleColor:[UIColor redColor]];
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    [rightItem addTarget:self action:@selector(p_clickBar4) forControlEvents:UIControlEventTouchUpInside];
    
    LWNavigationBarItem *item3 = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [item3 lw_setItemTitle:@"很长很长很长的标题"];
    [item3 lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [item3 lw_setItemTitleColor:[UIColor redColor]];
    
    self.bar4 = [[LWNavigationBar alloc] init];
    self.bar4.backgroundColor = [UIColor lightGrayColor];
    [self.bar4 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar4 lw_setBarContentInset:15];
    [self.bar4 lw_addItemToLeft:leftItem];
    [self.bar4 lw_addItemToRight:rightItem];
    [self.bar4 lw_addItemToTitle:item3];
    [self.bar4 lw_showTopStatusView:NO];
    self.bar4.frame = CGRectMake(0, CGRectGetMaxY(self.bar3.frame) + 20, self.view.frame.size.width, 64);
    [self.bar4 lw_reloadItems];
    [self.bar4 lw_updateLineAlpha:0];
    [self.view addSubview:self.bar4];
    [self.bar4 lw_updateNavBarWithAlpha:0.0];
}

- (void)p_setupBar5 {
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [leftItem lw_setItemTitle:@"左边"];
    [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [leftItem lw_setItemTitleColor:[UIColor redColor]];
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    [rightItem addTarget:self action:@selector(p_clickBar4) forControlEvents:UIControlEventTouchUpInside];
    //注：item3的宽可以随意指定，当其指定宽大于最大宽度(左右item中间的间距),默认显示最大宽度，否则显示指定宽度
    UIView *item3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    item3.backgroundColor = [UIColor redColor];
    
    self.bar5 = [[LWNavigationBar alloc] init];
    self.bar5.backgroundColor = [UIColor lightGrayColor];
    [self.bar5 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar5 lw_setBarContentInset:15];
    [self.bar5 lw_addItemToLeft:leftItem];
    [self.bar5 lw_addItemToRight:rightItem];
    [self.bar5 lw_addCustomViewToTitle:item3];
    [self.bar5 lw_showTopStatusView:NO];
    self.bar5.frame = CGRectMake(0, CGRectGetMaxY(self.bar4.frame) + 20, self.view.frame.size.width, 64);
    [self.bar5 lw_reloadItems];
    [self.bar5 lw_updateLineAlpha:0];
    [self.view addSubview:self.bar5];
}
static float alpha = 0;
- (void)p_clickBar4 {
    if (alpha >= 1.0) {
        alpha = 0.0;
    }else {
        alpha += 0.1;
    }
    [self.bar4 lw_updateNavBarWithAlpha:alpha];
    [self.bar4 lw_updateLeftItemAlpha:(1.0 - alpha) atIndex:0];
}

- (void)p_setupBar6 {
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [leftItem lw_setItemTitle:@"左边"];
    [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [leftItem lw_setItemTitleColor:[UIColor redColor]];
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    [rightItem addTarget:self action:@selector(p_clickBar6) forControlEvents:UIControlEventTouchUpInside];
    //注：item3的宽可以随意指定，当其指定宽大于最大宽度(左右item中间的间距),默认显示最大宽度，否则显示指定宽度
    UIView *item3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    item3.backgroundColor = [UIColor redColor];
    
    self.bar6 = [[LWNavigationBar alloc] init];
    self.bar6.backgroundColor = [UIColor lightGrayColor];
    [self.bar6 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar6 lw_setBarContentInset:15];
    [self.bar6 lw_addItemToLeft:leftItem];
    [self.bar6 lw_addItemToRight:rightItem];
    [self.bar6 lw_addCustomViewToTitle:item3];
    [self.bar6 lw_showTopStatusView:NO];
    self.bar6.frame = CGRectMake(0, CGRectGetMaxY(self.bar5.frame) + 20, self.view.frame.size.width, 64);
    [self.bar6 lw_reloadItems];
    [self.bar6 lw_updateLineAlpha:0];
    [self.view addSubview:self.bar6];
}
- (void)p_setupBar7 {
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
    [leftItem lw_setItemTitle:@"左边"];
    [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
    [leftItem lw_setItemTitleColor:[UIColor redColor]];
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    [rightItem addTarget:self action:@selector(p_clickBar7) forControlEvents:UIControlEventTouchUpInside];
    //注：item3的宽可以随意指定，当其指定宽大于最大宽度(左右item中间的间距),默认显示最大宽度，否则显示指定宽度
    UIView *item3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    item3.backgroundColor = [UIColor redColor];
    
    self.bar7 = [[LWNavigationBar alloc] init];
    self.bar7.backgroundColor = [UIColor lightGrayColor];
    [self.bar7 lw_setItemLineViewColor:[UIColor redColor]];
    [self.bar7 lw_setBarContentInset:15];
    [self.bar7 lw_addItemToLeft:leftItem];
    [self.bar7 lw_addItemToRight:rightItem];
    [self.bar7 lw_addCustomViewToTitle:item3];
    [self.bar7 lw_showTopStatusView:NO];
    self.bar7.frame = CGRectMake(0, CGRectGetMaxY(self.bar6.frame) + 20, self.view.frame.size.width, 64);
    [self.bar7 lw_reloadItems];
    [self.bar7 lw_updateLineAlpha:0];
    [self.view addSubview:self.bar7];
}
static BOOL clickBar6 = NO;
- (void)p_clickBar6 {
    if (!clickBar6) {
        LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
        [leftItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
        [leftItem lw_setItemImageSize:CGSizeMake(27, 27)];
        [self.bar6 lw_updateLeftItem:leftItem atIndex:0];
        clickBar6 = YES;
    }else {
        clickBar6 = NO;
        LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyText];
        [leftItem lw_setItemTitle:@"左边"];
        [leftItem lw_setItemTitleFont:[UIFont systemFontOfSize:15]];
        [leftItem lw_setItemTitleColor:[UIColor redColor]];
        [self.bar6 lw_updateLeftItem:leftItem atIndex:0];
    }
}
- (void)p_clickBar7 {
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] initWithItemType:LWNavigationBarItemOnlyImage];
    [rightItem lw_setItemImage:[UIImage imageNamed:@"home_logo"]];
    [rightItem lw_setItemImageSize:CGSizeMake(27, 27)];
    [self.bar7 lw_addNewItemToRight:rightItem];
}

@end
