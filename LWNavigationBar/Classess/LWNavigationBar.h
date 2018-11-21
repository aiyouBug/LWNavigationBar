//
//  LWNavigationBar.h
//  LWAlertViewDemo
//
//  Created by weil on 2018/11/21.
//  Copyright © 2018 allyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LWBarAttributeType) {
    LWBarAttributeTypeTextFront,
    LWBarAttributeTypeImageFront
};
@interface LWBarAttribute : NSObject
@property (nullable,nonatomic,copy) NSString *text;
@property (nullable,nonatomic,strong) UIImage *image;
@property (nullable,nonatomic,strong) UIFont *textFont;
@property (nullable,nonatomic,strong) UIColor *textColor;
@property (nullable,nonatomic,strong) UIColor *hightlightColor;
@property (nonatomic,assign) CGSize imageSize;
- (NSMutableAttributedString *)lw_createAttributeWithBarAttributeType:(LWBarAttributeType)type;
@end

@interface LWBarObj : NSObject
/**左侧按钮内容**/
@property (nonatomic,copy) NSMutableAttributedString *leftAttributeString;
/**标题**/
@property (nonatomic,copy) NSMutableAttributedString *titleAttributeString;
/**右侧按钮内容**/
@property (nonatomic,copy) NSMutableAttributedString *rightAttributeString;
/**底部细线颜色**/
@property (nonatomic,strong) UIColor *lineColor;
/**导航栏颜色**/
@property (nonatomic,strong) UIColor *navBarColor;
/**标题最大高度**/
@property (nonatomic,assign) CGFloat titleMaxH;
/**透明度**/
@property (nonatomic,assign) CGFloat navBarAlpha;
@property (nonatomic,assign) CGFloat lineAlpha;
/**左右间距**/
@property (nonatomic,assign) CGFloat edgeInset;
/**左侧点击事件**/
@property (nonatomic,copy) void(^leftItemAction)(_Nullable id value);
/**右侧点击事件**/
@property (nonatomic,copy) void(^rightItemAction)(_Nullable id value);
/**中间点击事件**/
@property (nonatomic,copy) void(^titleItemAction)(_Nullable id value);
@end

@interface LWNavigationBar : UIView

- (void)lw_updateLeftAttributeContent:(NSMutableAttributedString *)attributeContent;
- (void)lw_updateRightAttributeContent:(NSMutableAttributedString *)attributeContent;
- (void)lw_updateTitleAttributeContent:(NSMutableAttributedString *)attributeContent;
- (void)lw_updateLeftAttributeItemAlpha:(CGFloat)alpha;
- (void)lw_updateTitleAttributeItemAlpha:(CGFloat)alpha;
- (void)lw_updateNavBarAlpha:(CGFloat)alpha;
- (void)lw_updateLineAlpha:(CGFloat)alpha;
@end

@interface LWNavigationBarBuilder : NSObject
+ (LWNavigationBar *)builderNavigationBarWithBarObj:(LWBarObj *)obj superView:(UIView *)superView;

@end
