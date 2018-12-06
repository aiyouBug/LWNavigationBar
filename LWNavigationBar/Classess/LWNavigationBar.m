//
//  LWNavigationBar.m
//  Demo
//
//  Created by weil on 2018/12/6.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "LWNavigationBar.h"

@implementation LWNavigationItemAttribute

@end

@interface LWNavigationBarItem ()
@property (nonatomic,strong,readwrite) LWNavigationItemAttribute *lw_attribute;
@property (nonatomic,assign) CGSize maxSize;
@property (nonatomic,strong,readwrite) YYTextLayout *barLayout;
@property (nonatomic,strong) NSMutableAttributedString *attribute;
- (void)lw_updateItemWithMaxSize:(CGSize)maxSize;
@end

@implementation LWNavigationBarItem
+ (instancetype)createNavigationBarItemWithAttribute:(LWNavigationItemAttribute *)attribute maxSize:(CGSize)maxSize {
    return [[LWNavigationBarItem alloc] initWithAttribute:attribute maxSize:maxSize];
}
- (instancetype)initWithAttribute:(LWNavigationItemAttribute *)attribute maxSize:(CGSize)maxSize {
    self = [super init];
    if (self) {
        self.lw_attribute = attribute;
        self.maxSize = maxSize;
        [self p_setupItem];
    }
    return self;
}
- (void)p_setupItem {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    if (self.lw_attribute.title && self.lw_attribute.title.length > 0) {
        NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc] initWithString:self.lw_attribute.title];
        titleAttr.font = self.lw_attribute.titleFont;
        titleAttr.color = self.lw_attribute.titleColor;
        titleAttr.alignment = NSTextAlignmentJustified;
        if (self.lw_attribute.lineColor) {
            titleAttr.underlineColor = self.lw_attribute.lineColor;
            titleAttr.underlineStyle = NSUnderlineStyleSingle;
        }
        [attribute appendAttributedString:titleAttr];
    }
    if (self.lw_attribute.image) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:self.lw_attribute.image];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:self.lw_attribute.imageSize alignToFont:self.lw_attribute.titleFont alignment:YYTextVerticalAlignmentCenter];
        if (self.lw_attribute.type == LWBarAttributeTypeTextFront) {
            [attribute appendAttributedString:attachText];
        }else if (self.lw_attribute.type == LWBarAttributeTypeImageFront) {
            [attribute insertAttributedString:attachText atIndex:0];
        }
    }
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.fillColor = [UIColor clearColor];
    if (self.lw_attribute.lineColor) {
        highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    }
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setBackgroundBorder:highlightBorder];
    [attribute setTextHighlight:highlight range:attribute.rangeOfAll];
    __weak typeof(self) wsf = self;
    self.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (wsf.lw_attribute.completionHandler) {
            wsf.lw_attribute.completionHandler(text);
        }
    };
    self.barLayout = [YYTextLayout layoutWithContainerSize:self.maxSize text:attribute];
    self.textLayout = self.barLayout;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    self.numberOfLines = 1;
    self.attribute = attribute;
}
- (void)lw_updateItemWithAttribute:(LWNavigationItemAttribute *)attribute {
    self.lw_attribute = attribute;
    [self p_setupItem];
}
- (void)lw_updateItemWithMaxSize:(CGSize)maxSize {
    self.barLayout = [YYTextLayout layoutWithContainerSize:maxSize text:self.attribute];
    self.textLayout = self.barLayout;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    self.numberOfLines = 1;
}

@end
#define LW_StatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
@interface LWNavigationBar ()
@property (nonatomic,strong) NSArray<LWNavigationBarItem*> *leftItems;
@property (nonatomic,strong) NSArray<LWNavigationBarItem*> *rightItems;
@property (nonatomic,strong) LWNavigationBarItem *titleItem;
@property (nonatomic,assign) CGSize barSize;
@property (nonatomic,assign) CGFloat leftInset;
@property (nonatomic,assign) CGFloat rightInset;
@property (nonatomic,assign) CGFloat itemPadding;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIColor *groundColor;
@property (nonatomic,strong) UIView *statusBarView;
@end

@implementation LWNavigationBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lineView = [[UIView alloc] init];
        self.statusBarView = [[UIView alloc] init];
    }
    return self;
}
- (void)setBarLeftInset:(CGFloat)barLeftInset {
    self.leftInset = barLeftInset;
}
- (void)setBarRightInset:(CGFloat)barRightInset {
    self.rightInset = barRightInset;
}
- (void)setBarItemPadding:(CGFloat)barItemPadding {
    self.itemPadding = barItemPadding;
}

- (void)configLeftItems:(NSArray<LWNavigationBarItem *> *)leftItems {
    self.leftItems = leftItems;
}
- (void)configRightItems:(NSArray<LWNavigationBarItem *> *)rightItems {
    self.rightItems = rightItems;
}
- (void)configTitleItem:(LWNavigationBarItem *)titleItem {
    self.titleItem = titleItem;
}
- (void)configLineColor:(UIColor *)lineColor {
    self.lineView.backgroundColor = lineColor;
}
- (void)reloadItems {
    self.statusBarView.layer.backgroundColor = [self.backgroundColor colorWithAlphaComponent:self.alpha].CGColor;
    self.statusBarView.frame = CGRectMake(0, 0, self.frame.size.width, LW_StatusBarH);
    [self addSubview:self.statusBarView];
    CGFloat minY = CGRectGetMaxY(self.statusBarView.frame);
    
    CGFloat minX = self.leftInset;
    CGFloat leftItemX = minX;
    for (int i = 0; i < self.leftItems.count; ++i) {
        LWNavigationBarItem *item = self.leftItems[i];
        item.center = CGPointMake(minX + item.barLayout.textBoundingSize.width * 0.5, minY + (self.frame.size.height - minY - 0.5) * 0.5);
        item.bounds = CGRectMake(0, 0, item.barLayout.textBoundingSize.width, item.barLayout.textBoundingSize.height);
        minX = CGRectGetMaxX(item.frame) + self.itemPadding;
        [self addSubview:item];
        leftItemX = CGRectGetMaxX(item.frame);
    }
    
    CGFloat maxX = self.frame.size.width - self.rightInset;
    CGFloat rightItemX = maxX;
    for (int i = (int)self.rightItems.count - 1; i >= 0 ; --i) {
        LWNavigationBarItem *item = self.rightItems[i];
        item.center = CGPointMake(maxX - item.barLayout.textBoundingSize.width * 0.5, minY + (self.frame.size.height - minY - 0.5) * 0.5);
        item.bounds = CGRectMake(0, 0, item.barLayout.textBoundingSize.width, item.barLayout.textBoundingSize.height);
        maxX = CGRectGetMinX(item.frame) - self.itemPadding;
        [self addSubview:item];
        rightItemX = CGRectGetMinX(item.frame);
    }
    
    self.titleItem.center = CGPointMake(leftItemX + (rightItemX - leftItemX) * 0.5, minY + (self.frame.size.height - minY - 0.5) * 0.5);
    self.titleItem.bounds = CGRectMake(0, 0, self.titleItem.barLayout.textBoundingSize.width, self.titleItem.barLayout.textBoundingSize.height);
    [self addSubview:self.titleItem];
    
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, self.frame.size.height - 0.5);
    [self addSubview:self.lineView];
}
- (void)lw_updateLeftAttributeContent:(LWNavigationItemAttribute *)attributeContent atIndex:(int)index{
    if (index < self.leftItems.count) {
        LWNavigationBarItem *item = self.leftItems[index];
        [item lw_updateItemWithAttribute:attributeContent];
    }
     [self reloadItems];
}
- (void)lw_updateRightAttributeContent:(LWNavigationItemAttribute *)attributeContent atIndex:(int)index{
    if (index < self.rightItems.count) {
        LWNavigationBarItem *item = self.rightItems[index];
        [item lw_updateItemWithAttribute:attributeContent];
    }
     [self reloadItems];
}
- (void)lw_updateTitleAttributeContent:(LWNavigationItemAttribute *)attributeContent {
    [self.titleItem lw_updateItemWithAttribute:attributeContent];
    [self reloadItems];
}
- (void)lw_updateLeftAttributeItemAlpha:(CGFloat)alpha atIndex:(int)index{
    if (index < self.leftItems.count) {
        LWNavigationBarItem *item = self.leftItems[index];
        item.alpha = alpha;
    }
}
- (void)lw_updateTitleAttributeItemAlpha:(CGFloat)alpha{
    self.titleItem.alpha = alpha;
}
- (void)lw_updateNavBarAlpha:(CGFloat)alpha {
    self.layer.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha].CGColor;
    self.statusBarView.layer.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha].CGColor;
}
- (void)lw_updateLineAlpha:(CGFloat)alpha {
    self.lineView.alpha = alpha;
}
- (void)lw_addLeftItem:(LWNavigationBarItem *)leftItem {
    if ([self.leftItems containsObject:leftItem]) {
        return;
    }
    NSMutableArray *items = self.leftItems.mutableCopy;
    [items addObject:leftItem];
    self.leftItems = items.copy;
    __block CGFloat maxW = 0;
    [self.leftItems enumerateObjectsUsingBlock:^(LWNavigationBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        maxW += obj.barLayout.textBoundingSize.width;
    }];
    [self.rightItems enumerateObjectsUsingBlock:^(LWNavigationBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        maxW += obj.barLayout.textBoundingSize.width;
    }];
    [self.titleItem lw_updateItemWithMaxSize:CGSizeMake(self.frame.size.width - self.leftInset - self.rightInset - self.leftItems.count * self.itemPadding - self.rightItems.count * self.itemPadding - maxW, self.frame.size.height)];
    [self reloadItems];
}
- (void)lw_removeLeftItem:(LWNavigationBarItem *)leftItem {
    if (![self.leftItems containsObject:leftItem]) {
        return;
    }
    NSMutableArray *items = self.leftItems.mutableCopy;
    if ([self.leftItems containsObject:leftItem]) {
        [items removeObject:leftItem];
    }
    self.leftItems = items.copy;
    __block CGFloat maxW = 0;
    [self.leftItems enumerateObjectsUsingBlock:^(LWNavigationBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        maxW += obj.barLayout.textBoundingSize.width;
    }];
    [self.rightItems enumerateObjectsUsingBlock:^(LWNavigationBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        maxW += obj.barLayout.textBoundingSize.width;
    }];
    [self.titleItem lw_updateItemWithMaxSize:CGSizeMake(self.frame.size.width - self.leftInset - self.rightInset - self.leftItems.count * self.itemPadding - self.rightItems.count * self.itemPadding - maxW, self.frame.size.height)];
    [self reloadItems];
}
@end
