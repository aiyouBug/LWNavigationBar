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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LWBarAttribute *leftBarAttribute = [[LWBarAttribute alloc] init];
    leftBarAttribute.image = [UIImage imageNamed:@"nav_back_black"];
    leftBarAttribute.imageSize = CGSizeMake(20, 20);
    leftBarAttribute.hightlightColor = [UIColor clearColor];
    
    LWBarAttribute *rightBarAttribute = [[LWBarAttribute alloc] init];
    rightBarAttribute.image = [UIImage imageNamed:@"detail_share"];
    rightBarAttribute.imageSize = CGSizeMake(20, 20);
    rightBarAttribute.hightlightColor = [UIColor clearColor];
    
    LWBarAttribute *titleBarAttribute = [[LWBarAttribute alloc] init];
    titleBarAttribute.text = @"这是一个很长很长额标题这是一个";
    titleBarAttribute.hightlightColor = [UIColor clearColor];
    titleBarAttribute.textFont = [UIFont systemFontOfSize:15.0f];
    titleBarAttribute.textColor = [UIColor blackColor];
    
    LWBarObj *obj = [[LWBarObj alloc] init];
    obj.leftAttributeString = [leftBarAttribute lw_createAttributeWithBarAttributeType:LWBarAttributeTypeTextFront];
    obj.rightAttributeString = [rightBarAttribute lw_createAttributeWithBarAttributeType:LWBarAttributeTypeTextFront];
    obj.titleAttributeString = [titleBarAttribute lw_createAttributeWithBarAttributeType:LWBarAttributeTypeTextFront];
    obj.lineColor = [UIColor redColor];
    obj.navBarColor = [UIColor greenColor];
    obj.edgeInset = 15;
    obj.titleMaxH = 80 - 20;
    obj.navBarAlpha = 0.0;
    obj.lineAlpha = 0.0;
    obj.leftItemAction = ^(id  _Nullable value) {
        NSLog(@"%@",value);
    };
    obj.rightItemAction = ^(id  _Nullable value) {
        NSLog(@"%@",value);
    };
    
    LWNavigationBar *bar = [LWNavigationBarBuilder builderNavigationBarWithBarObj:obj superView:self.view];
    bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    self.bar = bar;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LWBarAttribute *leftBarAttribute = [[LWBarAttribute alloc] init];
    leftBarAttribute.image = [UIImage imageNamed:@"nav_back_black"];
    leftBarAttribute.imageSize = CGSizeMake(20, 20);
    leftBarAttribute.hightlightColor = [UIColor clearColor];
    leftBarAttribute.textColor = [UIColor blackColor];
    leftBarAttribute.textFont = [UIFont systemFontOfSize:15.0f];
    [self.bar lw_updateLeftAttributeContent:[leftBarAttribute lw_createAttributeWithBarAttributeType:LWBarAttributeTypeImageFront]];
}




@end
