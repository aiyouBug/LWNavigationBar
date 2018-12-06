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
//图片大小
@property (nonatomic,assign) CGSize imageSize;
//标题颜色
@property (nonatomic,strong) UIColor *textColor;
//标题字体
@property (nonatomic,strong) UIFont *textFont;
//标题文本
@property (nonatomic,copy) NSString *title;
//标题和图片间距，默认是5
@property (nonatomic,assign) CGFloat titleImageInset;
//下划线和文字的间距,默认1
@property (nonatomic,assign) CGFloat lineTitleInset;
//是否显示细线
@property (nonatomic,assign) BOOL showLine;
@end

@implementation LWNavigationBarItem

- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_initSubviews];
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
    
    self.titleImageInset = 5;
    self.lineTitleInset = 1;
}
- (void)setItemTitle:(NSString *)itemTitle {
    self.title = itemTitle;
    self.titleLabel.text = itemTitle;
}
- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    self.textFont = itemTitleFont;
    self.titleLabel.font = itemTitleFont;
}
- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    self.textColor = itemTitleColor;
    self.titleLabel.textColor = itemTitleColor;
    self.lineView.backgroundColor = itemTitleColor;
}
- (void)setItemImage:(UIImage *)itemImage {
    self.imageView.image = itemImage;
}
- (void)setItemImageSize:(CGSize)itemImageSize {
    self.imageSize = itemImageSize;
}
- (void)showItemLine:(BOOL)show {
    self.showLine = show;
}
- (CGSize)itemSize {
    CGSize titleSize = CGSizeZero;
    CGSize imageSize = CGSizeZero;
    CGSize lineSize = CGSizeZero;
    if (self.title && self.title.length > 0) {
        titleSize = [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
    }
    imageSize = self.imageSize;
    if (self.showLine) {
        lineSize = CGSizeMake(titleSize.width, 0.5);
        self.lineTitleInset = 1;
    }else {
        self.lineTitleInset = 0;
    }
    if (self.title && self.imageView.image) {
        self.titleImageInset = 5;
    }else {
        self.titleImageInset = 0;
    }
    CGFloat itemW = (titleSize.width + self.titleImageInset + imageSize.width) + 2 * 5;
    CGFloat itemH = (titleSize.height > imageSize.height ? titleSize.height : imageSize.height) + self.lineTitleInset + lineSize.height + 2 * 2;
    return CGSizeMake(itemW, itemH);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.title && self.title.length > 0) {
        CGSize titleSize =  [self.title boundingRectWithSize:CGSizeMake(HUGE, HUGE) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:NULL].size;
        if (self.showLine) {
            self.lineTitleInset = 1;
            self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5, (self.frame.size.height - 0.5 - self.lineTitleInset) * 0.5);
            self.titleLabel.bounds = CGRectMake(0, 0, titleSize.width > self.frame.size.width ? self.frame.size.width : titleSize.width, titleSize.height);
            self.lineView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), self.frame.size.height - 0.5, self.titleLabel.frame.size.width, 0.5);
        }else {
            self.lineTitleInset = 0;
            self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5,self.frame.size.height * 0.5);
            self.titleLabel.bounds = CGRectMake(0, 0, titleSize.width > self.frame.size.width ? self.frame.size.width : titleSize.width, titleSize.height);
            self.lineView.frame = CGRectZero;
        }
    }
    
    if (self.imageView.image) {
        self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + self.titleImageInset + 5 + self.imageSize.width * 0.5, self.frame.size.height * 0.5);
        self.imageView.bounds = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
    }
}
@end
#define LW_StatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
@interface LWNavigationBar ()
//状态栏部分
@property (nonatomic,strong) UIView *statusView;
//左边items数组
@property (nonatomic,strong) NSMutableArray<LWNavigationBarItem*> *leftItems;
//右边items数组
@property (nonatomic,strong) NSMutableArray<LWNavigationBarItem*> *rightItems;
//中间标题
@property (nonatomic,strong) LWNavigationBarItem *titleItem;
//左右间距
@property (nonatomic,assign) CGFloat contentInset;
//底部细线
@property (nonatomic,strong) UIView *lineView;
@end

@implementation LWNavigationBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.leftItems = @[].mutableCopy;
        self.rightItems = @[].mutableCopy;
        self.statusView = [[UIView alloc] init];
        [self addSubview:self.statusView];
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return self;
}
- (void)addItemToLeft:(LWNavigationBarItem *)item {
    [self.leftItems addObject:item];
    [self addSubview:item];
}
- (void)addItemToRight:(LWNavigationBarItem *)item {
    [self.rightItems addObject:item];
    [self addSubview:item];
}
- (void)addItemToTitle:(LWNavigationBarItem *)item {
    self.titleItem = item;
    [self addSubview:item];
}
- (void)setBarContentInset:(CGFloat)barContentInset {
    self.contentInset = barContentInset;
}
- (void)setItemLineViewColor:(UIColor *)color {
    self.lineView.backgroundColor = color;
}
- (void)lw_updateNavBarWithAlpha:(CGFloat)alpha {
    self.layer.backgroundColor = [self.backgroundColor colorWithAlphaComponent:alpha].CGColor;
//    self.statusView.layer.backgroundColor = self.layer.backgroundColor;
}
- (void)lw_updateLeftItem:(LWNavigationBarItem *)item atIndex:(int)index {
    if (index >= self.leftItems.count) {
        return;
    }
    LWNavigationBarItem *leftItem = self.leftItems[index];
    [leftItem removeFromSuperview];
    [self.leftItems removeObject:leftItem];
    [self.leftItems insertObject:item atIndex:index];
    [self addSubview:item];
    [self reloadItems];
}
- (void)lw_updateTitleItem:(LWNavigationBarItem *)item {
    [self.titleItem removeFromSuperview];
    self.titleItem = item;
    [self addSubview:item];
    [self reloadItems];
}
- (void)lw_updateRightItem:(LWNavigationBarItem *)item atIndex:(int)index {
    if (index >= self.rightItems.count) {
        return;
    }
    LWNavigationBarItem *rightItem = self.rightItems[index];
    [rightItem removeFromSuperview];
    [self.rightItems removeObject:rightItem];
    [self.rightItems insertObject:item atIndex:index];
    [self addSubview:item];
    [self reloadItems];
}
- (void)lw_updateLeftItemAlpha:(CGFloat)alpha atIndex:(int)index{
    LWNavigationBarItem *item = self.leftItems[index];
    item.alpha = alpha;
}
- (void)lw_updateLineAlpha:(CGFloat)alpha {
    self.lineView.alpha = alpha;
}
- (void)lw_updateTitleItemAlpha:(CGFloat)alpha {
    self.titleItem.alpha = alpha;
}

- (void)reloadItems {
    self.statusView.frame = CGRectMake(0, 0, self.frame.size.width, LW_StatusBarH);
    CGFloat y = CGRectGetMaxY(self.statusView.frame);
    CGFloat x = self.contentInset;
    for (int i = 0; i < self.leftItems.count; ++i) {
        LWNavigationBarItem *item = self.leftItems[i];
        item.center = CGPointMake(x + [item itemSize].width * 0.5, y + (self.frame.size.height - y) * 0.5);
        item.bounds = CGRectMake(0, 0, [item itemSize].width, [item itemSize].height);
        x = CGRectGetMaxX(item.frame);
    }
    self.titleItem.center = CGPointMake(self.frame.size.width * 0.5, y + (self.frame.size.height - y) * 0.5);
    self.titleItem.bounds = CGRectMake(0, 0, self.frame.size.width - 2 * x - self.contentInset, [self.titleItem itemSize].height);
    
    x = self.frame.size.width - self.contentInset;
    for (int i = (int)self.rightItems.count - 1; i >= 0; --i) {
         LWNavigationBarItem *item = self.rightItems[i];
        item.center = CGPointMake(x - [item itemSize].width * 0.5, y + (self.frame.size.height - y) * 0.5);
        item.bounds = CGRectMake(0, 0, [item itemSize].width, [item itemSize].height);
        x = CGRectGetMinX(item.frame);
    }
}

@end
