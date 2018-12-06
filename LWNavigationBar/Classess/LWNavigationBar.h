//
//  LWNavigationBar.h
//  Demo
//
//  Created by weil on 2018/12/6.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LWBarAttributeType) {
    LWBarAttributeTypeTextFront,
    LWBarAttributeTypeImageFront
};

@interface LWNavigationItemAttribute : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIFont *titleFont;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,assign) CGSize imageSize;
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign) LWBarAttributeType type;
@property (nonatomic,copy) void(^completionHandler)(id value);
@end

@interface LWNavigationBarItem : YYLabel
+ (instancetype)createNavigationBarItemWithAttribute:(LWNavigationItemAttribute *)attribute maxSize:(CGSize)maxSize;
- (instancetype)initWithAttribute:(LWNavigationItemAttribute *)attribute maxSize:(CGSize)maxSize;
@property (nonatomic,strong,readonly) LWNavigationItemAttribute *lw_attribute;
@property (nonatomic,strong,readonly) YYTextLayout *barLayout;
- (void)lw_updateItemWithAttribute:(LWNavigationItemAttribute *)attribute;
@end

@interface LWNavigationBar : UIView
//设置左右间距
- (void)setBarLeftInset:(CGFloat)barLeftInset;
- (void)setBarRightInset:(CGFloat)barRightInset;
//设置每两个item之间的间距，默认为0，主要针对左右有多个的情况
- (void)setBarItemPadding:(CGFloat)barItemPadding;
- (void)configLeftItems:(NSArray<LWNavigationBarItem *>*)leftItems;
- (void)configRightItems:(NSArray<LWNavigationBarItem *>*)rightItems;
- (void)configTitleItem:(LWNavigationBarItem *)titleItem;
- (void)configLineColor:(UIColor *)lineColor;
- (void)reloadItems;

- (void)lw_updateLeftAttributeContent:(LWNavigationItemAttribute *)attributeContent atIndex:(int)index;
- (void)lw_updateRightAttributeContent:(LWNavigationItemAttribute *)attributeContent atIndex:(int)index;
- (void)lw_updateTitleAttributeContent:(LWNavigationItemAttribute *)attributeContent;
- (void)lw_updateLeftAttributeItemAlpha:(CGFloat)alpha atIndex:(int)index;
- (void)lw_updateTitleAttributeItemAlpha:(CGFloat)alpha;
- (void)lw_updateNavBarAlpha:(CGFloat)alpha;
- (void)lw_updateLineAlpha:(CGFloat)alpha;
- (void)lw_addLeftItem:(LWNavigationBarItem *)leftItem;
- (void)lw_removeLeftItem:(LWNavigationBarItem *)leftItem;
@end

NS_ASSUME_NONNULL_END
