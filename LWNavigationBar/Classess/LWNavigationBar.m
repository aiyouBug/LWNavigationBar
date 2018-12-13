//
//  LWNavigationBar.m
//  Demo
//
//  Created by weil on 2018/12/6.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "LWNavigationBar.h"

@interface LWNavigationBarItem ()
//标题
@property (nonatomic,strong) UILabel *titleLabel;
//图片
@property (nonatomic,strong) UIImageView *imageView;
//下划线
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIColor *lineColor;
//图片大小
@property (nonatomic,assign) CGSize imageSize;
//标题颜色
@property (nonatomic,strong) UIColor *textColor;
//标题字体
@property (nonatomic,strong) UIFont *textFont;
//标题文本
@property (nonatomic,copy) NSString *title;
//标题和图片间距，默认是2
@property (nonatomic,assign) CGFloat titleImagePadding;
//下划线和文字的间距,默认0
@property (nonatomic,assign) CGFloat lineTopPadding;
//下划线高度，默认为1
@property (nonatomic,assign) CGFloat lineHeight;
@property (nonatomic,assign) LWNavigationBarItemType itemType;
//设置内容的内边距
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@end

@implementation LWNavigationBarItem

- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_initSubviews];
    }
    return self;
}
- (instancetype)initWithItemType:(LWNavigationBarItemType)itemType {
    self = [super init];
    if (self) {
        [self p_initSubviews];
        self.itemType = itemType;
    }
    return self;
}
//初始化
- (void)p_initSubviews {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    
    self.lineView = [[UIView alloc] init];
    [self addSubview:self.lineView];
    
    self.titleImagePadding = 2;
    self.lineTopPadding = 0;
    self.lineHeight = 1;
    self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)lw_setItemTitle:(NSString *)itemTitle {
    self.title = itemTitle;
    self.titleLabel.text = itemTitle;
}
- (void)lw_setItemTitleFont:(UIFont *)itemTitleFont {
    self.textFont = itemTitleFont;
    self.titleLabel.font = itemTitleFont;
}
- (void)lw_setItemTitleColor:(UIColor *)itemTitleColor {
    self.textColor = itemTitleColor;
    self.titleLabel.textColor = itemTitleColor;
     [self lw_setLineColor:itemTitleColor];
}
- (void)lw_setItemImage:(UIImage *)itemImage {
    self.imageView.image = itemImage;
}
- (void)lw_setItemImageSize:(CGSize)itemImageSize {
    self.imageSize = itemImageSize;
}
- (void)lw_setItemConentInsets:(UIEdgeInsets)itemContentInsets {
    self.contentInsets = itemContentInsets;
}
- (void)lw_setItemLineColor:(UIColor *)itemLineColor {
    [self lw_setLineColor:itemLineColor];
}
- (void)lw_setLineColor:(UIColor *)lineColor {
    self.lineColor = lineColor;
    self.lineView.backgroundColor = lineColor;
}
- (CGSize)lw_itemSize {
    CGSize size = CGSizeZero;
    switch (self.itemType) {
        case LWNavigationBarItemOnlyText:
           size = [self p_itemSizeOnlyText];
            break;
        case LWNavigationBarItemOnlyImage:
           size = [self p_itemSizeOnlyImage];
            break;
        case LWNavigationBarItemTextLine:
           size = [self p_itemSizeTextLine];
            break;
        case LWNavigationBarItemMulti:
           size = [self p_itemSizeMulti];
            break;
    }
    return size;
}
- (CGSize)p_itemSizeOnlyText {
    if (self.title && self.title.length > 0) {
        CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
        return CGSizeMake(titleSize.width + 2 * self.contentInsets.left, titleSize.height + self.contentInsets.top * 2);
    }
    return CGSizeMake(0, 0);
}
- (CGSize)p_itemSizeOnlyImage {
    return CGSizeMake(self.imageSize.width + 2 * self.contentInsets.left, self.imageSize.height + 2 * self.contentInsets.top);
}
- (CGSize)p_itemSizeTextLine {
    if (self.title && self.title.length > 0) {
        CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
        return CGSizeMake(titleSize.width + 2 * self.contentInsets.left, titleSize.height + self.contentInsets.top * 2 + self.lineTopPadding + self.lineHeight);
    }
    return CGSizeMake(0, 0);
}
- (CGSize)p_itemSizeMulti {
    CGSize titleSize;
    if (self.title && self.title.length > 0) {
       titleSize = [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
    }else {
        titleSize = CGSizeZero;
    }
    CGFloat h = titleSize.height > self.imageSize.height ? titleSize.height : self.imageSize.height;
    return CGSizeMake(titleSize.width + self.titleImagePadding + self.imageSize.width + 2 * self.contentInsets.left, h + self.contentInsets.top * 2);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.itemType) {
        case LWNavigationBarItemOnlyText:
            [self p_layoutOnlyText];
            break;
        case LWNavigationBarItemTextLine:
            [self p_layoutTextLine];
            break;
        case LWNavigationBarItemOnlyImage:
            [self p_layoutOnlyImage];
            break;
        case LWNavigationBarItemMulti:
            [self p_layoutMulti];
            break;
    }
}

- (void)p_layoutOnlyText {
    if (self.title && self.title.length > 0) {
        CGSize titleSize =  [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
        self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5,self.frame.size.height * 0.5);
        self.titleLabel.bounds = CGRectMake(0, 0, titleSize.width > self.frame.size.width ? self.frame.size.width : titleSize.width, titleSize.height);
    }else {
        self.titleLabel.frame = CGRectZero;
    }
}
- (void)p_layoutOnlyImage {
    self.imageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.imageView.bounds = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
}
- (void)p_layoutTextLine {
    if (self.title && self.title.length > 0) {
        CGSize titleSize =  [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
        self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5,(self.frame.size.height - self.lineHeight) * 0.5);
        self.titleLabel.bounds = CGRectMake(0, 0, titleSize.width > self.frame.size.width ? self.frame.size.width : titleSize.width, titleSize.height);
        self.lineView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), self.frame.size.height - self.lineHeight, CGRectGetWidth(self.titleLabel.frame), self.lineHeight);
    }
}
- (void)p_layoutMulti {
    if (self.title && self.title.length > 0) {
        CGSize titleSize =  [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
        self.titleLabel.center = CGPointMake(titleSize.width * 0.5 + self.contentInsets.left,self.frame.size.height * 0.5);
        self.titleLabel.bounds = CGRectMake(0, 0, titleSize.width, titleSize.height);
    }
    self.imageView.center = CGPointMake(self.frame.size.width + self.contentInsets.right - self.imageSize.width * 0.5, self.frame.size.height * 0.5);
    self.imageView.bounds = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
}
@end

@implementation LWNavigationBarItem (LWDeprecated)
- (void)setItemTitle:(NSString *)itemTitle {
    [self lw_setItemTitle:itemTitle];
}
- (void)setItemImage:(UIImage *)itemImage {
    [self lw_setItemImage:itemImage];
}
- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    [self lw_setItemTitleColor:itemTitleColor];
}
- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    [self lw_setItemTitleFont:itemTitleFont];
}
- (void)setItemImageSize:(CGSize)itemImageSize {
    [self lw_setItemImageSize:itemImageSize];
}
- (void)setItemConentInsets:(UIEdgeInsets)itemContentInsets {
    [self lw_setItemConentInsets:itemContentInsets];
}
- (void)setItemLineColor:(UIColor *)itemLineColor {
    [self lw_setItemLineColor:itemLineColor];
}
- (CGSize)itemSize {
    return [self lw_itemSize];
}

@end

#define LW_StatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
@interface LWNavigationBar ()
//状态栏部分
@property (nonatomic,strong) UIView *statusView;
//左边items数组
@property (nonatomic,strong) NSMutableArray<LWNavigationBarItem*> *leftItems;
@property (nonatomic,strong) NSMutableArray<UIView *> *leftViews;
//右边items数组
@property (nonatomic,strong) NSMutableArray<LWNavigationBarItem*> *rightItems;
@property (nonatomic,strong) NSMutableArray<UIView *> *rightViews;
//中间标题
@property (nonatomic,strong) LWNavigationBarItem *titleItem;
@property (nonatomic,strong) UIView *titleView;
//左右间距
@property (nonatomic,assign) CGFloat contentInset;
//底部细线
@property (nonatomic,strong) UIView *lineView;
//item之间的间距
@property (nonatomic,assign) CGFloat itemPadding;
@end

@implementation LWNavigationBar
- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftItems = @[].mutableCopy;
        self.rightItems = @[].mutableCopy;
        self.leftViews = @[].mutableCopy;
        self.rightViews = @[].mutableCopy;
        self.statusView = [[UIView alloc] init];
        [self addSubview:self.statusView];
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.leftItems = @[].mutableCopy;
        self.rightItems = @[].mutableCopy;
        self.leftViews = @[].mutableCopy;
        self.rightViews = @[].mutableCopy;
        self.statusView = [[UIView alloc] init];
        [self addSubview:self.statusView];
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return self;
}
- (void)lw_addItemToLeft:(LWNavigationBarItem *__nonnull)item {
    if (item) {
        [self.leftItems addObject:item];
        [self addSubview:item];
    }
}
- (void)lw_addCustomViewToLeft:(UIView *__nonnull)customView {
    if (customView) {
        [self.leftViews addObject:customView];
        [self addSubview:customView];
    }
}
- (void)lw_addItemToRight:(LWNavigationBarItem *__nonnull)item {
    if (item) {
        [self.rightItems addObject:item];
        [self addSubview:item];
    }
}
- (void)lw_addCustomViewToRight:(UIView *__nonnull)customView {
    if (customView) {
        [self.rightViews addObject:customView];
        [self addSubview:customView];
    }
}
- (void)lw_addItemToTitle:(LWNavigationBarItem *__nonnull)item {
    self.titleItem = item;
    [self addSubview:item];
}
- (void)lw_addCustomViewToTitle:(UIView *__nonnull)customView {
    self.titleView = customView;
    [self addSubview:self.titleView];
}
- (void)lw_setBarContentInset:(CGFloat)barContentInset {
    self.contentInset = barContentInset;
}
- (void)lw_setItemPadding:(CGFloat)itemPadding {
    self.itemPadding = itemPadding;
}
- (void)lw_setItemLineViewColor:(UIColor *)color {
    self.lineView.backgroundColor = color;
}
- (void)lw_updateNavBarWithAlpha:(CGFloat)alpha {
    self.layer.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha].CGColor;
    self.statusView.layer.backgroundColor = self.layer.backgroundColor;
}
- (void)lw_updateLeftItem:(LWNavigationBarItem *_Nullable)item atIndex:(int)index {
    if (index < self.leftViews.count) {
        [self.leftViews removeObjectAtIndex:index];
    }
    if (self.leftItems.count == 0) {
        if (item) {
            [self.leftItems addObject:item];
            [self addSubview:item];
        }
    }else {
        if (index >= self.leftItems.count) {
            return;
        }
        LWNavigationBarItem *leftItem = self.leftItems[index];
        [self.leftItems removeObject:leftItem];
        [leftItem removeFromSuperview];
        if (item) {
            leftItem = item;
            [self.leftItems insertObject:leftItem atIndex:index];
            [self addSubview:item];
        }
    }
    [self lw_reloadItems];
}
- (void)lw_updateLeftView:(UIView *_Nullable)customView atIndex:(int)index {
    if (index < self.leftItems.count) {
        [self.leftItems removeObjectAtIndex:index];
    }
    if (self.leftViews.count == 0) {
        if (customView) {
            [self.leftViews addObject:customView];
             [self addSubview:customView];
        }
    }else {
        if (index >= self.leftViews.count) {
            return;
        }
        UIView *leftView = self.leftViews[index];
        [self.leftViews removeObject:leftView];
        [leftView removeFromSuperview];
        if (customView) {
            leftView = customView;
            [self.leftViews insertObject:leftView atIndex:index];
             [self addSubview:customView];
        }
    }
    [self lw_reloadItems];
}
- (void)lw_updateTitleItem:(LWNavigationBarItem *_Nullable)item {
    if (self.titleItem) {
        [self.titleItem removeFromSuperview];
    }
    if (self.titleView) {
        [self.titleView removeFromSuperview];
        self.titleView = nil;
    }
    self.titleItem = item;
    if (item) {
        [self addSubview:item];
    }
    [self lw_reloadItems];
}
- (void)lw_updateTitleView:(UIView *_Nullable)customView {
    if (self.titleView) {
        [self.titleView removeFromSuperview];
    }
    if (self.titleItem) {
        [self.titleItem removeFromSuperview];
        self.titleItem = nil;
    }
    self.titleView = customView;
    if (customView) {
        [self addSubview:customView];
    }
    [self lw_reloadItems];
}
- (void)lw_updateRightItem:(LWNavigationBarItem *_Nullable)item atIndex:(int)index {
    if (index < self.rightViews.count) {
        [self.rightViews removeObjectAtIndex:index];
    }
    if (self.rightItems.count == 0) {
        if (item) {
            [self.rightItems addObject:item];
            [self addSubview:item];
        }
    }else {
        if (index >= self.rightItems.count) {
            return;
        }
        LWNavigationBarItem *rightItem = self.rightItems[index];
        [self.rightItems removeObject:rightItem];
        [rightItem removeFromSuperview];
        if (item) {
            rightItem = item;
            [self.rightItems insertObject:rightItem atIndex:index];
            [self addSubview:item];
        }
    }
    [self lw_reloadItems];
}
- (void)lw_updateRightView:(UIView *_Nullable)customView atIndex:(int)index {
    if (index < self.rightItems.count) {
        [self.rightItems removeObjectAtIndex:index];
    }
    if (self.rightViews.count == 0) {
        if (customView) {
            [self.rightViews addObject:customView];
             [self addSubview:customView];
        }
    }else {
        if (index >= self.rightViews.count) {
            return;
        }
        UIView *rightView = self.rightViews[index];
        [self.rightViews removeObject:rightView];
        [rightView removeFromSuperview];
        if (customView) {
            rightView = customView;
            [self.rightViews insertObject:rightView atIndex:index];
            [self addSubview:customView];
        }
    }
    [self lw_reloadItems];
}
- (void)lw_updateLeftItemAlpha:(CGFloat)alpha atIndex:(int)index{
    if (self.leftItems.count > index) {
        LWNavigationBarItem *item = self.leftItems[index];
        item.alpha = alpha;
    }
    if (self.leftViews.count > index) {
        UIView *leftView = self.leftViews[index];
        leftView.alpha = alpha;
    }
}
- (void)lw_updateRightItemAlpha:(CGFloat)alpha atIndex:(int)index {
    if (self.rightItems.count > index) {
        LWNavigationBarItem *item = self.rightItems[index];
        item.alpha = alpha;
    }
    if (self.rightViews.count > index) {
        UIView *rightView = self.rightViews[index];
        rightView.alpha = alpha;
    }
}

- (void)lw_updateLineAlpha:(CGFloat)alpha {
    self.lineView.alpha = alpha;
}
- (void)lw_updateTitleItemAlpha:(CGFloat)alpha {
    if (self.titleItem) {
        self.titleItem.alpha = alpha;
    }
    if (self.titleView) {
        self.titleView.alpha = alpha;
    }
}
- (void)lw_addNewItemToLeft:(LWNavigationBarItem *__nonnull)item {
    if (!item) {
        return;
    }
    if ([self.leftItems containsObject:item]) {
        return;
    }
    [self.leftItems addObject:item];
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_addNewViewToLeft:(UIView *__nonnull)customView {
    if (!customView) {
        return;
    }
    if ([self.leftViews containsObject:customView]) {
        return;
    }
    [self.leftViews addObject:customView];
    [self addSubview:customView];
    [self lw_reloadItems];
}
- (void)lw_addNewItemToRight:(LWNavigationBarItem *__nonnull)item {
    if (!item) {
        return;
    }
    if ([self.rightItems containsObject:item]) {
        return;
    }
    [self.rightItems addObject:item];
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_addNewViewToRight:(UIView *__nonnull)customView {
    if (!customView) {
        return;
    }
    if ([self.rightViews containsObject:customView]) {
        return;
    }
    [self.rightViews addObject:customView];
    [self addSubview:customView];
    [self lw_reloadItems];
}
- (void)lw_showTopStatusView:(BOOL)show {
    self.statusView.hidden = !show;
}

- (void)lw_reloadItems {
    if (self.statusView.hidden) {
        self.statusView.frame = CGRectZero;
    }else {
        self.statusView.frame = CGRectMake(0, 0, self.frame.size.width, LW_StatusBarH);
    }
    CGFloat y = CGRectGetMaxY(self.statusView.frame);
    CGFloat leftX = self.contentInset;
    
    for (int i = 0; i < self.leftItems.count; ++i) {
        LWNavigationBarItem *item = self.leftItems[i];
        item.center = CGPointMake(leftX + [item lw_itemSize].width * 0.5, y + (self.frame.size.height - y) * 0.5);
        item.bounds = CGRectMake(0, 0, [item lw_itemSize].width, [item lw_itemSize].height);
        leftX = CGRectGetMaxX(item.frame) + self.itemPadding;
    }
    
    for (int i = 0; i < self.leftViews.count; ++i) {
        UIView *leftView = self.leftViews[i];
        leftView.center = CGPointMake(leftX + leftView.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        leftView.bounds = CGRectMake(0, 0, leftView.frame.size.width, leftView.frame.size.height);
        leftX = CGRectGetMaxX(leftView.frame) + self.itemPadding;
    }
    
  CGFloat rightX = self.frame.size.width - self.contentInset;
    for (int i = (int)self.rightItems.count - 1; i >= 0; --i) {
         LWNavigationBarItem *item = self.rightItems[i];
        item.center = CGPointMake(rightX - [item lw_itemSize].width * 0.5, y + (self.frame.size.height - y) * 0.5);
        item.bounds = CGRectMake(0, 0, [item lw_itemSize].width, [item lw_itemSize].height);
        rightX = CGRectGetMinX(item.frame) - self.itemPadding;
    }
    for (int i = 0; i < self.rightViews.count; ++i) {
        UIView *rightView = self.rightViews[i];
        rightView.center = CGPointMake(rightX - rightView.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        rightView.bounds = CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height);
        rightX = CGRectGetMinX(rightView.frame) - self.itemPadding;
    }
    
    if (self.titleItem) {
        CGFloat padding = MAX(self.frame.size.width - rightX, leftX) + self.contentInset;
        CGFloat titleW = MIN([self.titleItem lw_itemSize].width, self.frame.size.width - 2 * padding);
        if (titleW < 0) {
            titleW = 0;
        }
        self.titleItem.center = CGPointMake(self.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        self.titleItem.bounds = CGRectMake(0, 0, titleW, [self.titleItem lw_itemSize].height);
    }
    if (self.titleView) {
        CGFloat padding = MAX(self.frame.size.width - rightX, leftX) + self.contentInset;
        CGFloat titleW = MIN(self.titleView.frame.size.width, self.frame.size.width - 2 * padding);
        if (titleW < 0) {
            titleW = 0;
        }
        self.titleView.center = CGPointMake(self.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        self.titleView.bounds = CGRectMake(0, 0, titleW, self.titleView.frame.size.height);
    }

    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}

@end

@implementation LWNavigationBar (LWDeprecated)
- (void)setBarContentInset:(CGFloat)barContentInset {
    [self lw_setBarContentInset:barContentInset];
}
- (void)addItemToLeft:(LWNavigationBarItem *)item {
    [self lw_addItemToLeft:item];
}
- (void)addItemToRight:(LWNavigationBarItem *)item {
    [self lw_addItemToRight:item];
}
- (void)addItemToTitle:(LWNavigationBarItem *)item {
    [self lw_addItemToTitle:item];
}
- (void)setItemLineViewColor:(UIColor *)color {
    [self lw_setItemLineViewColor:color];
}
- (void)reloadItems {
    [self lw_reloadItems];
}
@end
