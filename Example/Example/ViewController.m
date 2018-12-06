//
//  ViewController.m
//  LWAlertViewDemo
//
//  Created by weil on 2018/11/21.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "ViewController.h"
#import "LWNavigationBar.h"
#import <YYKit.h>

@interface ViewController ()
@property (nonatomic,strong) LWNavigationBar *bar;
@property (nonatomic,strong) LWNavigationBarItem *addItem;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LWNavigationItemAttribute *leftBarAttribute = [[LWNavigationItemAttribute alloc] init];
    leftBarAttribute.image = [UIImage imageNamed:@"nav_back_black"];
    leftBarAttribute.imageSize = CGSizeMake(20, 20);
    
    LWNavigationItemAttribute *rightBarAttribute = [[LWNavigationItemAttribute alloc] init];
    rightBarAttribute.image = [UIImage imageNamed:@"detail_share"];
    rightBarAttribute.imageSize = CGSizeMake(20, 20);
    
    LWNavigationItemAttribute *titleBarAttribute = [[LWNavigationItemAttribute alloc] init];
    titleBarAttribute.title = @"这是一个很长很长额标题这是一个";
    titleBarAttribute.titleFont = [UIFont systemFontOfSize:15.0f];
    titleBarAttribute.titleColor = [UIColor blackColor];
    
    LWNavigationBarItem *leftItem = [LWNavigationBarItem createNavigationBarItemWithAttribute:leftBarAttribute maxSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    
    LWNavigationBarItem *rightItem = [LWNavigationBarItem createNavigationBarItemWithAttribute:rightBarAttribute maxSize:self.view.frame.size];
    
    LWNavigationBarItem *titleItem = [LWNavigationBarItem createNavigationBarItemWithAttribute:titleBarAttribute maxSize:CGSizeMake(self.view.frame.size.width - 15 * 2 - leftItem.barLayout.textBoundingSize.width - rightItem.barLayout.textBoundingSize.width, self.view.frame.size.height)];
    
    LWNavigationBar *bar = [[LWNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
    [bar setBarLeftInset:15];
    [bar setBarRightInset:15];
    [bar configLeftItems:@[leftItem]];
    [bar configRightItems:@[rightItem]];
    [bar configTitleItem:titleItem];
    [bar reloadItems];
    self.bar = bar;
    [self.view addSubview:bar];
    
    LWNavigationItemAttribute *add_leftBarAttribute = [[LWNavigationItemAttribute alloc] init];
    add_leftBarAttribute.image = [UIImage imageNamed:@"nav_back_black"];
    add_leftBarAttribute.imageSize = CGSizeMake(20, 20);
    self.addItem = [LWNavigationBarItem createNavigationBarItemWithAttribute:add_leftBarAttribute maxSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
}
static int idx = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (idx == 0) {
        [self.bar lw_addLeftItem:self.addItem];
    }
    if (idx == 1) {
        LWNavigationItemAttribute *add_leftBarAttribute = [[LWNavigationItemAttribute alloc] init];
        add_leftBarAttribute.image = [UIImage imageNamed:@"nav_back_black"];
        add_leftBarAttribute.imageSize = CGSizeMake(20, 20);
        LWNavigationBarItem *item = [LWNavigationBarItem createNavigationBarItemWithAttribute:add_leftBarAttribute maxSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
        [self.bar lw_addLeftItem:item];
    }
    if (idx == 2) {
        [self.bar lw_removeLeftItem:self.addItem];
    }
    idx++;
    
}



@end
