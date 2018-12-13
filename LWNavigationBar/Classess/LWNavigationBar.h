//
//  LWNavigationBar.h
//  Demo
//
//  Created by weil on 2018/12/6.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define LWDeprecated(instead) NS_DEPRECATED(8_0, 8_0, 8_0, 8_0, instead)

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LWNavigationBarItemType) {
    LWNavigationBarItemOnlyText,//只有文字
    LWNavigationBarItemOnlyImage,//只有图片
    LWNavigationBarItemTextLine,//带下划线的文字
    LWNavigationBarItemMulti//图文混合,只支持左文字右图片,不考虑超长文字的情况
};

@interface LWNavigationBarItem : UIControl
- (instancetype)initWithItemType:(LWNavigationBarItemType)itemType;
/** 设置item标题 **/
- (void)lw_setItemTitle:(NSString *)itemTitle;
/** 设置item图片 **/
- (void)lw_setItemImage:(UIImage *)itemImage;
/** 设置标题文字颜色 **/
- (void)lw_setItemTitleColor:(UIColor *)itemTitleColor;
/** 设置标题文字大小 **/
- (void)lw_setItemTitleFont:(UIFont *)itemTitleFont;
/** 设置item图片尺寸 **/
- (void)lw_setItemImageSize:(CGSize)itemImageSize;
/** 设置内容的内边距 **/
- (void)lw_setItemConentInsets:(UIEdgeInsets)itemContentInsets;
/** 设置带下划线文字的下划线颜色，默认和文字颜色相同 **/
- (void)lw_setItemLineColor:(UIColor *)itemLineColor;
/** 返回item的尺寸 **/
- (CGSize)lw_itemSize;
@end

@interface LWNavigationBarItem (LWDeprecated)
- (void)setItemTitle:(NSString *)itemTitle LWDeprecated("请在方法名前加上lw_");
- (void)setItemImage:(UIImage *)itemImage LWDeprecated("请在方法名前加上lw_");
- (void)setItemTitleColor:(UIColor *)itemTitleColor LWDeprecated("请在方法名前加上lw_");
- (void)setItemTitleFont:(UIFont *)itemTitleFont LWDeprecated("请在方法名前加上lw_");
- (void)setItemImageSize:(CGSize)itemImageSize LWDeprecated("请在方法名前加上lw_");
- (void)setItemConentInsets:(UIEdgeInsets)itemContentInsets LWDeprecated("请在方法名前加上lw_");
- (void)setItemLineColor:(UIColor *)itemLineColor LWDeprecated("请在方法名前加上lw_");
- (CGSize)itemSize LWDeprecated("请在方法名前加上lw_");
@end

@interface LWNavigationBar : UIView
/*
 *设置内容的边距，这里默认左右边距相同
 */
- (void)lw_setBarContentInset:(CGFloat)barContentInset;
/*
 *设置每两个item之间的间距，默认为0
 */
- (void)lw_setItemPadding:(CGFloat)itemPadding;
/*添加item到左边
 *item: LWNavigationBarItem生成
 */
- (void)lw_addItemToLeft:(LWNavigationBarItem *)item;
/*添加自定义view为左边item
 *customView:自定义view
 */
- (void)lw_addCustomViewToLeft:(UIView *)customView;
/*添加item到右边
 *item: LWNavigationBarItem生成
 */
- (void)lw_addItemToRight:(LWNavigationBarItem *)item;
/*添加自定义view为右边item
 *customView:自定义view
 */
- (void)lw_addCustomViewToRight:(UIView *)customView;
/*添加item作为标题
 *item: LWNavigationBarItem生成
 */
- (void)lw_addItemToTitle:(LWNavigationBarItem *)item;
/*添加自定义view为标题item
 *customView:自定义view
 */
- (void)lw_addCustomViewToTitle:(UIView *)customView;
/*设置导航栏底部细线的颜色
 */
- (void)lw_setItemLineViewColor:(UIColor *)color;
/*刷新各个子控件的布局
 */
- (void)lw_reloadItems;
/*刷新导航栏背景的透明度
 */
- (void)lw_updateNavBarWithAlpha:(CGFloat)alpha;
/*更新左边的item
 *item:由LWNavigationBarItem生成
 *index:标明更新左边第几个item
 */
- (void)lw_updateLeftItem:(LWNavigationBarItem *)item atIndex:(int)index;
/*更新左边的item
 *customView:自定义的view
 *index:标明更新左边第几个item
 */
- (void)lw_updateLeftView:(UIView *)customView atIndex:(int)index;
/*更新标题item
 *item:由LWNavigationBarItem生成
 */
- (void)lw_updateTitleItem:(LWNavigationBarItem *)item;
/*更新标题item
 *customView:自定义的view
 */
- (void)lw_updateTitleView:(UIView *)customView;
/*更新右边的item
 *item:由LWNavigationBarItem生成
 *index:标明更新右边第几个item
 */
- (void)lw_updateRightItem:(LWNavigationBarItem *)item atIndex:(int)index;
/*更新右边的item
 *customView:自定义的view
 *index:标明更新右边第几个item
 */
- (void)lw_updateRightView:(UIView *)customView atIndex:(int)index;
/*更新左边item的透明度
 *alpha:透明度
 *index:标明第几个
 */
- (void)lw_updateLeftItemAlpha:(CGFloat)alpha  atIndex:(int)index;
/*更新底部细线的透明度
 *alpha:透明度
 */
- (void)lw_updateLineAlpha:(CGFloat)alpha;
/*更新标题item的透明度
 *alpha:透明度
 */
- (void)lw_updateTitleItemAlpha:(CGFloat)alpha;
/*更新右边item的透明度
 *alpha:透明度
 *index:标明第几个
 */
- (void)lw_updateRightItemAlpha:(CGFloat)alpha atIndex:(int)index;
/*向左边添加新的item
 *item：LWNavigationBarItem生成
 */
- (void)lw_addNewItemToLeft:(LWNavigationBarItem *)item;
/*向左边添加新的item
 *customView：自定义view
 */
- (void)lw_addNewViewToLeft:(UIView *)customView;
/*向右边添加新的item
 *item：LWNavigationBarItem生成
 */
- (void)lw_addNewItemToRight:(LWNavigationBarItem *)item;
/*向右边添加新的item
 *customView：自定义view
 */
- (void)lw_addNewViewToRight:(UIView *)customView;
/** 是否显示顶部状态栏 **/
- (void)lw_showTopStatusView:(BOOL)show;
@end

@interface LWNavigationBar (LWDeprecated)
- (void)setBarContentInset:(CGFloat)barContentInset LWDeprecated("请在方法名前加上lw_");
- (void)addItemToLeft:(LWNavigationBarItem *)item LWDeprecated("请在方法名前加上lw_");
- (void)addItemToRight:(LWNavigationBarItem *)item LWDeprecated("请在方法名前加上lw_");
- (void)addItemToTitle:(LWNavigationBarItem *)item LWDeprecated("请在方法名前加上lw_");
- (void)setItemLineViewColor:(UIColor *)color LWDeprecated("请在方法名前加上lw_");
- (void)reloadItems;
@end

NS_ASSUME_NONNULL_END
