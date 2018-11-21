# LWNavigationBar
自定义导航栏，左右和标题item可以为文字，可以为图片，也可以为图文混合，支持回调事件，背景透明度渐变和标题文字透明度渐变

###### 1. 各个item内容定制：

```
LWBarAttribute *leftBarAttribute = [[LWBarAttribute alloc] init];
leftBarAttribute.image = [UIImage imageNamed:@"nav_back_black"];
leftBarAttribute.imageSize = CGSizeMake(20, 20);
leftBarAttribute.hightlightColor = [UIColor clearColor];

```

###### 2. 导航栏属性定制：

```
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

```

###### 3. 生成导航栏：

```
LWNavigationBar *bar = [LWNavigationBarBuilder builderNavigationBarWithBarObj:obj superView:self.view];
bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);

```
