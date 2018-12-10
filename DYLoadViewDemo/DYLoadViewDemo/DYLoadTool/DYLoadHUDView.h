//
//  DYLoadHUDView.h
//  QEZB
//
//  Created by 李超群 on 2018/11/17.
//  Copyright © 2018 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 回调 */
typedef void(^DYCallbackBlock)(void);


NS_ASSUME_NONNULL_BEGIN

#pragma mark -/** *** HUDView 的基类 *** */
@interface DYLoadStatusHUDView : UIView

/** 设置 HUD 的 view的透明度 */
@property (nonatomic, assign) BOOL HUDViewHidden;

@end

#pragma mark -/** *** 页面加载出来之前的 HUDView *** */
@interface DYPlacehoderHUDView : DYLoadStatusHUDView

/** 加载出来之前的占位图 */
@property (nonatomic, weak) UIImageView *placeholderImageView;

@end

#pragma mark -/** *** 没有数据的 HUDView *** */
@interface DYNoDataHUDView : DYLoadStatusHUDView

/** 没数据的图片 */
@property (nonatomic, weak) UIImageView *nodataImgeView;

/** 提示没数据的label */
@property (nonatomic, weak) UILabel *tipLabel;

/**  重试按钮 */
@property (nonatomic, weak) UIButton *reloadButton;

/** 按钮点击的回调 */
@property (nonatomic, copy) DYCallbackBlock reloadCallback;

@end

#pragma mark -/** *** 加载失败的 HUDView *** */
@interface DYLoadfailedHUDView : DYLoadStatusHUDView

/** 加载失败的图片 */
@property (nonatomic, weak) UIImageView *failedImageView;

/** 提示加载失败的 label */
@property (nonatomic, weak) UILabel *tipLabel;

/** 提示刷新重试的 label */
@property (nonatomic, weak) UILabel *refreshLabel;

/**  重试按钮 */
@property (nonatomic, weak) UIButton *retryButton;

/** 按钮点击的回调 */
@property (nonatomic, copy) DYCallbackBlock retryCallback;

@end

NS_ASSUME_NONNULL_END
