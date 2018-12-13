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
//是否显示细线
@property (nonatomic,assign) BOOL showLine;
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
    self.lineColor = itemTitleColor;
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
    self.lineColor = itemLineColor;
}
- (void)lw_setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
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
- (void)lw_addItemToLeft:(LWNavigationBarItem *)item {
    [self.leftItems addObject:item];
    [self addSubview:item];
}
- (void)lw_addCustomViewToLeft:(UIView *)customView {
    [self.leftViews addObject:customView];
    [self addSubview:customView];
}
- (void)lw_addItemToRight:(LWNavigationBarItem *)item {
    [self.rightItems addObject:item];
    [self addSubview:item];
}
- (void)lw_addCustomViewToRight:(UIView *)customView {
    [self.rightViews addObject:customView];
    [self addSubview:customView];
}
- (void)lw_addItemToTitle:(LWNavigationBarItem *)item {
    self.titleItem = item;
    [self addSubview:item];
}
- (void)lw_addCustomViewToTitle:(UIView *)customView {
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
- (void)lw_updateLeftItem:(LWNavigationBarItem *)item atIndex:(int)index {
    if (index < self.leftViews.count) {
        [self.leftViews removeObjectAtIndex:index];
    }
    if (self.leftItems.count == 0) {
        [self.leftItems addObject:item];
    }else {
        if (index >= self.leftItems.count) {
            return;
        }
        LWNavigationBarItem *leftItem = self.leftItems[index];
        [self.leftItems removeObject:leftItem];
        [leftItem removeFromSuperview];
        leftItem = item;
        [self.leftItems insertObject:leftItem atIndex:index];
    }
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_updateLeftView:(UIView *)customView atIndex:(int)index {
    if (index < self.leftItems.count) {
        [self.leftItems removeObjectAtIndex:index];
    }
    if (self.leftViews.count == 0) {
        [self.leftViews addObject:customView];
    }else {
        if (index >= self.leftViews.count) {
            return;
        }
        UIView *leftView = self.leftViews[index];
        [self.leftViews removeObject:leftView];
        [leftView removeFromSuperview];
        leftView = customView;
        [self.leftViews insertObject:leftView atIndex:index];
    }
    [self addSubview:customView];
    [self lw_reloadItems];
}
- (void)lw_updateTitleItem:(LWNavigationBarItem *)item {
    if (self.titleItem) {
        [self.titleItem removeFromSuperview];
    }
    if (self.titleView) {
        [self.titleView removeFromSuperview];
        self.titleView = nil;
    }
    self.titleItem = item;
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_updateTitleView:(UIView *)customView {
    if (self.titleView) {
        [self.titleView removeFromSuperview];
    }
    if (self.titleItem) {
        [self.titleItem removeFromSuperview];
        self.titleItem = nil;
    }
    self.titleView = customView;
    [self addSubview:customView];
    [self lw_reloadItems];
}
- (void)lw_updateRightItem:(LWNavigationBarItem *)item atIndex:(int)index {
    if (index < self.rightViews.count) {
        [self.rightViews removeObjectAtIndex:index];
    }
    if (self.rightItems.count == 0) {
        [self.rightItems addObject:item];
    }else {
        if (index >= self.rightItems.count) {
            return;
        }
        LWNavigationBarItem *rightItem = self.rightItems[index];
        [self.rightItems removeObject:rightItem];
        [rightItem removeFromSuperview];
        rightItem = item;
        [self.rightItems insertObject:rightItem atIndex:index];
    }
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_updateRightView:(UIView *)customView atIndex:(int)index {
    if (index < self.rightItems.count) {
        [self.rightItems removeObjectAtIndex:index];
    }
    if (self.rightViews.count == 0) {
        [self.rightViews addObject:customView];
    }else {
        if (index >= self.rightViews.count) {
            return;
        }
        UIView *rightView = self.rightViews[index];
        [self.rightViews removeObject:rightView];
        [rightView removeFromSuperview];
        rightView = customView;
        [self.rightViews insertObject:rightView atIndex:index];
    }
    [self addSubview:customView];
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
- (void)lw_addNewItemToLeft:(LWNavigationBarItem *)item {
    if ([self.leftItems containsObject:item]) {
        return;
    }
    [self.leftItems addObject:item];
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_addNewViewToLeft:(UIView *)customView {
    if ([self.leftViews containsObject:customView]) {
        return;
    }
    [self.leftViews addObject:customView];
    [self addSubview:customView];
    [self lw_reloadItems];
}
- (void)lw_addNewItemToRight:(LWNavigationBarItem *)item {
    if ([self.rightItems containsObject:item]) {
        return;
    }
    [self.rightItems addObject:item];
    [self addSubview:item];
    [self lw_reloadItems];
}
- (void)lw_addNewViewToRight:(UIView *)customView {
    if ([self.rightViews containsObject:customView]) {
        return;
    }
    [self.rightViews addObject:customView];
    [self addSubview:customView];
    [self lw_reloadItems];
}

- (void)lw_reloadItems {
    self.statusView.frame = CGRectMake(0, 0, self.frame.size.width, LW_StatusBarH);
    CGFloat y = CGRectGetMaxY(self.statusView.frame);
    CGFloat x = self.contentInset;
    
    for (int i = 0; i < self.leftItems.count; ++i) {
        LWNavigationBarItem *item = self.leftItems[i];
        item.center = CGPointMake(x + [item lw_itemSize].width * 0.5, y + (self.frame.size.height - y) * 0.5);
        item.bounds = CGRectMake(0, 0, [item lw_itemSize].width, [item lw_itemSize].height);
        x = CGRectGetMaxX(item.frame) + self.itemPadding;
    }
    
    for (int i = 0; i < self.leftViews.count; ++i) {
        UIView *leftView = self.leftViews[i];
        leftView.center = CGPointMake(x + leftView.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        leftView.bounds = CGRectMake(0, 0, leftView.frame.size.width, leftView.frame.size.height);
        x = CGRectGetMaxX(leftView.frame) + self.itemPadding;
    }
    if (self.titleItem) {
        CGFloat titleW = ([self.titleItem lw_itemSize].width > (self.frame.size.width - 2 * x - self.contentInset) ? (self.frame.size.width - 2 * x - self.contentInset) : [self.titleItem lw_itemSize].width);
        self.titleItem.center = CGPointMake(self.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        self.titleItem.bounds = CGRectMake(0, 0, titleW, [self.titleItem lw_itemSize].height);
    }
    if (self.titleView) {
        CGFloat titleW = MIN(self.titleView.frame.size.width, (self.frame.size.width - 2 * x - self.contentInset));
        self.titleView.center = CGPointMake(self.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        self.titleView.bounds = CGRectMake(0, 0, titleW, self.titleView.frame.size.height);
    }
    
    x = self.frame.size.width - self.contentInset;
    for (int i = (int)self.rightItems.count - 1; i >= 0; --i) {
         LWNavigationBarItem *item = self.rightItems[i];
        item.center = CGPointMake(x - [item lw_itemSize].width * 0.5, y + (self.frame.size.height - y) * 0.5);
        item.bounds = CGRectMake(0, 0, [item lw_itemSize].width, [item lw_itemSize].height);
        x = CGRectGetMinX(item.frame) - self.itemPadding;
    }
    for (int i = 0; i < self.rightViews.count; ++i) {
        UIView *rightView = self.rightViews[i];
        rightView.center = CGPointMake(x - rightView.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
        rightView.bounds = CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height);
        x = CGRectGetMinX(rightView.frame) - self.itemPadding;
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
