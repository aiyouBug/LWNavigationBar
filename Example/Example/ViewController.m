//
//  ViewController.m
//  LWAlertViewDemo
//
//  Created by weil on 2018/11/21.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "ViewController.h"
#import "LWNavigationBar.h"

@interface ViewController ()
@property (nonatomic,strong) LWNavigationBar *bar;
@property (nonatomic,strong) LWNavigationBarItem *addItem;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] init];
    [leftItem setItemImage:[UIImage imageNamed:@"nav_back_black"]];
    [leftItem setItemImageSize:CGSizeMake(20, 20)];
    
    LWNavigationBarItem *rightItem = [[LWNavigationBarItem alloc] init];
    [rightItem setItemImageSize:CGSizeMake(20, 20)];
    [rightItem setItemImage:[UIImage imageNamed:@"detail_share"]];
    
    LWNavigationBarItem *titleItem = [[LWNavigationBarItem alloc] init];
    [titleItem setItemTitle:@"这是一个很长的标题这是一个很长的标题这是一个很长的标题这是一个很长的标题"];
    [titleItem setItemTitleFont:[UIFont systemFontOfSize:15]];
    [titleItem setItemTitleColor:[UIColor blackColor]];
    
    
    LWNavigationBar *bar = [[LWNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
    [bar addItemToLeft:leftItem];
    [bar addItemToRight:rightItem];
    [bar setBarContentInset:15];
    [bar addItemToTitle:titleItem];
    [bar reloadItems];
    [bar setItemLineViewColor:[UIColor redColor]];
    [bar lw_updateLineAlpha:1.0];
    [self.view addSubview:bar];
    self.bar = bar;
    bar.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    LWNavigationBarItem *leftItem = [[LWNavigationBarItem alloc] init];
    [leftItem setItemImage:[UIImage imageNamed:@"detail_share"]];
    [leftItem setItemImageSize:CGSizeMake(20, 20)];
    [self.bar addItemToLeft:leftItem];
}



@end
