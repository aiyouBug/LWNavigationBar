//
//  LWNavigationBar.h
//  Demo
//
//  Created by weil on 2018/12/6.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LWNavigationBarItemType) {
    LWNavigationBarItemOnlyText,//只有文字
    LWNavigationBarItemOnlyImage,//只有图片
    LWNavigationBarItemTextLine,//带下划线的文字
    LWNavigationBarItemMulti//图文混合,只支持左文字右图片,不考虑超长文字的情况
};

@interface LWNavigationBarItem : UIControl
- (instancetype)initWithItemType:(LWNavigationBarItemType)itemType;
- (void)setItemTitle:(NSString *)itemTitle;
- (void)setItemImage:(UIImage *)itemImage;
- (void)setItemTitleColor:(UIColor *)itemTitleColor;
- (void)setItemTitleFont:(UIFont *)itemTitleFont;
- (void)setItemImageSize:(CGSize)itemImageSize;
- (void)setItemConentInsets:(UIEdgeInsets)itemContentInsets;
- (void)showItemLine:(BOOL)show;
- (void)setItemLineColor:(UIColor *)itemLineColor;
- (CGSize)itemSize;
@end

@interface LWNavigationBar : UIView
- (void)setBarContentInset:(CGFloat)barContentInset;
- (void)addItemToLeft:(LWNavigationBarItem *)item;
- (void)addItemToRight:(LWNavigationBarItem *)item;
- (void)addItemToTitle:(LWNavigationBarItem *)item;
- (void)setItemLineViewColor:(UIColor *)color;
- (void)reloadItems;
- (void)lw_updateNavBarWithAlpha:(CGFloat)alpha;
- (void)lw_updateLeftItem:(LWNavigationBarItem *)item atIndex:(int)index;
- (void)lw_updateTitleItem:(LWNavigationBarItem *)item;
- (void)lw_updateRightItem:(LWNavigationBarItem *)item atIndex:(int)index;
- (void)lw_updateLeftItemAlpha:(CGFloat)alpha  atIndex:(int)index;
- (void)lw_updateLineAlpha:(CGFloat)alpha;
- (void)lw_updateTitleItemAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
