//
//  LWNavigationBar.m
//  LWAlertViewDemo
//
//  Created by weil on 2018/11/21.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import "LWNavigationBar.h"
#import <YYKit.h>

#define LWStatusBarH  [UIApplication sharedApplication].statusBarFrame.size.height
#define LWScreenW [UIScreen mainScreen].bounds.size.width

@implementation LWBarAttribute
- (instancetype)init {
    self = [super init];
    if (self) {
        self.hightlightColor = [UIColor clearColor];
        self.textColor = [UIColor blackColor];
        self.textFont = [UIFont systemFontOfSize:15.0f];
    }
    return self;
}
- (NSMutableAttributedString *)lw_createAttributeWithBarAttributeType:(LWBarAttributeType)type {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    if (self.text && self.text.length > 0) {
        NSMutableAttributedString *textAttribute = [[NSMutableAttributedString alloc] initWithString:self.text];
        textAttribute.font = self.textFont;
        textAttribute.color = self.textColor;
        textAttribute.alignment = NSTextAlignmentJustified;
        [attribute appendAttributedString:textAttribute];
    }
    if (self.image) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:self.image];
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:self.imageSize alignToFont:[UIFont systemFontOfSize:15] alignment:YYTextVerticalAlignmentCenter];
        if (type == LWBarAttributeTypeTextFront) {
            [attribute appendAttributedString:attachText];
        }else if (type == LWBarAttributeTypeImageFront) {
            [attribute insertAttributedString:attachText atIndex:0];
        }
    }
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.fillColor = [UIColor clearColor];
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setBackgroundBorder:highlightBorder];
    [attribute setTextHighlight:highlight range:attribute.rangeOfAll];
    return attribute;
}
@end

@implementation LWBarObj

@end

@interface LWNavigationBar ()
@property (nonatomic,strong) LWBarObj *barObj;
@property (nonatomic,strong) UIView *statusBarView;
@property (nonatomic,strong) YYLabel *leftItem;
@property (nonatomic,strong) YYLabel *titleItem;
@property (nonatomic,strong) YYLabel *rightItem;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) YYTextLayout *leftLayout;
@property (nonatomic,strong) YYTextLayout *titleLayout;
@property (nonatomic,strong) YYTextLayout *rightLayout;
- (void)buildNavBar;
@end

@implementation LWNavigationBar
- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_initSubviews];
        [self p_addItemActions];
    }
    return self;
}
- (void)p_initSubviews {
    self.statusBarView = [[UIView alloc] init];
    [self addSubview:self.statusBarView];
    
    self.leftItem = [YYLabel new];
    [self addSubview:self.leftItem];
    
    self.titleItem = [YYLabel new];
    [self addSubview:self.titleItem];
    
    self.rightItem = [YYLabel new];
    [self addSubview:self.rightItem];
    
    self.lineView = [[UIView alloc] init];
    [self addSubview:self.lineView];
}

- (void)p_addItemActions {
    @weakify(self);
    self.leftItem.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(self);
        YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSDictionary *info = highlight.userInfo;
        if (self.barObj.leftItemAction) {
            self.barObj.leftItemAction(info);
        }
    };
    
    self.rightItem.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(self);
        YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSDictionary *info = highlight.userInfo;
        if (self.barObj.rightItemAction) {
            self.barObj.rightItemAction(info);
        }
    };
    
    self.titleItem.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(self);
        YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSDictionary *info = highlight.userInfo;
        if (self.barObj.titleItemAction) {
            self.barObj.titleItemAction(info);
        }
    };
}

- (void)buildNavBar {
    
    self.statusBarView.layer.backgroundColor = [self.barObj.navBarColor colorWithAlphaComponent:self.barObj.navBarAlpha].CGColor;
    self.layer.backgroundColor = [self.barObj.navBarColor colorWithAlphaComponent:self.barObj.navBarAlpha].CGColor;
    self.lineView.layer.backgroundColor = [self.barObj.lineColor colorWithAlphaComponent:self.barObj.lineAlpha].CGColor;
    self.leftLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(HUGE, HUGE) text:self.barObj.leftAttributeString];
    self.rightLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(HUGE, HUGE) text:self.barObj.rightAttributeString];
    self.titleLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(LWScreenW - self.leftLayout.textBoundingSize.width - self.rightLayout.textBoundingSize.width - 2 * self.barObj.edgeInset, self.barObj.titleMaxH) text:self.barObj.titleAttributeString];
    self.leftItem.textLayout = self.leftLayout;
    self.titleItem.textLayout = self.titleLayout;
    self.rightItem.textLayout = self.rightLayout;
    self.titleItem.numberOfLines = 1;
    self.titleItem.lineBreakMode = NSLineBreakByTruncatingTail;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.statusBarView.frame = CGRectMake(0, 0, self.frame.size.width, LWStatusBarH);
   
    self.leftItem.center = CGPointMake(self.barObj.edgeInset + self.leftLayout.textBoundingSize.width * 0.5, CGRectGetMaxY(self.statusBarView.frame) + (self.frame.size.height - CGRectGetMaxY(self.statusBarView.frame)) / 2.0);
    self.leftItem.bounds = CGRectMake(0, 0, self.leftLayout.textBoundingSize.width, self.leftLayout.textBoundingSize.height);
    
    self.rightItem.center = CGPointMake(self.frame.size.width - self.barObj.edgeInset - self.rightLayout.textBoundingSize.width * 0.5, self.leftItem.center.y);
    self.rightItem. bounds = CGRectMake(0, 0, self.rightLayout.textBoundingSize.width, self.rightLayout.textBoundingSize.height);
    
    self.titleItem.center = CGPointMake(self.frame.size.width * 0.5, self.leftItem.center.y);
    self.titleItem.bounds = CGRectMake(0, 0, self.titleLayout.textBoundingSize.width, self.titleLayout.textBoundingSize.height);
   
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}

- (void)lw_updateLeftAttributeContent:(NSMutableAttributedString *)attributeContent {
   self.leftLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(HUGE, HUGE) text:attributeContent];
     self.leftItem.textLayout = self.leftLayout;
     self.barObj.leftAttributeString = attributeContent;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)lw_updateRightAttributeContent:(NSMutableAttributedString *)attributeContent {
     self.rightLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(HUGE, HUGE) text:attributeContent];
    self.rightItem.textLayout = self.rightLayout;
    self.barObj.rightAttributeString = attributeContent;
    [self setNeedsLayout];
     [self layoutIfNeeded];
}
- (void)lw_updateTitleAttributeContent:(NSMutableAttributedString *)attributeContent {
     self.titleLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(LWScreenW - self.leftLayout.textBoundingSize.width - self.rightLayout.textBoundingSize.width - 2 * self.barObj.edgeInset, self.barObj.titleMaxH) text:attributeContent];
    self.titleItem.textLayout = self.titleLayout;
    self.barObj.titleAttributeString = attributeContent;
    [self setNeedsLayout];
     [self layoutIfNeeded];
}
- (void)lw_updateLeftAttributeItemAlpha:(CGFloat)alpha {
    self.leftItem.alpha = alpha;
}
- (void)lw_updateTitleAttributeItemAlpha:(CGFloat)alpha {
    self.titleItem.alpha = alpha;
}
- (void)lw_updateNavBarAlpha:(CGFloat)alpha {
    self.layer.backgroundColor = [self.barObj.navBarColor colorWithAlphaComponent:alpha].CGColor;
    self.barObj.navBarAlpha = alpha;
}
- (void)lw_updateLineAlpha:(CGFloat)alpha {
    self.lineView.layer.backgroundColor = [self.barObj.lineColor colorWithAlphaComponent:alpha].CGColor;
    self.barObj.lineAlpha = alpha;
}
@end

@implementation LWNavigationBarBuilder
+ (LWNavigationBar *)builderNavigationBarWithBarObj:(LWBarObj *)obj superView:(UIView *)superView {
    LWNavigationBar *bar = [[LWNavigationBar alloc] init];
    bar.barObj = obj;
    [superView addSubview:bar];
    [bar buildNavBar];
    return bar;
}
@end
