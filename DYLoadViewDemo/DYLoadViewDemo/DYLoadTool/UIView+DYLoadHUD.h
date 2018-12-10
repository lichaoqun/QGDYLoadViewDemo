//
//  UIView+DYLoadHUD.h
//  QEZB
//
//  Created by 李超群 on 2018/11/16.
//  Copyright © 2018 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYLoadHUDView.h"

typedef NS_ENUM(NSInteger, DYPlaceholderHUDViewType) {
    DYPlaceholderHUDViewTypeNormal, /**< 正常的加载图 */
    DYPlaceholderHUDViewTypeShortVideo,/**< 短视频 */
    DYPlaceholderHUDViewTypeAttention_nologin,/**< 关注未登录 */
    DYPlaceholderHUDViewTypeAttention_login_1,/**< 关注登录样式1 */
    DYPlaceholderHUDViewTypeAttention_login_2,/**< 关注登录样式2 */
    DYPlaceholderHUDViewTypeAttention_login_3,/**< 关注登录样式3 */
    DYPlaceholderHUDViewTypeHome_category,/**< 首页其他分类 */
    DYPlaceholderHUDViewTypeHome_recommend,/**< 首页推荐 */
    DYPlaceholderHUDViewTypeHome_live, /**< 首页直播 */
    DYPlaceholderHUDViewTypeGuessHomeList /**<  乐猜 */
};

typedef NS_ENUM(NSInteger, UIViewFailViewType) {
    UIViewFailViewTypeDefault,
    UIViewFailViewTypeFollow,
    UIViewFailViewTypeHistory,
    UIViewFailViewTypeTask,
    UIViewFailViewTypeMessage,
    UIViewFailViewTypeRank,
    UIViewFailViewTypeCommon,
    UIViewFailViewTypeAnchor,
    UIViewFailViewTypeSearch,
    UIViewFailViewTypeLive,
    UIViewFailViewTypeConsume,
    UIViewFailViewTypeQuizRank,
    UIViewFailViewTypeQuiz,
    UIViewFailViewTypeHighlights,
    UIViewFailViewTypeNOAnchor,
    UIViewFailViewTypeNoContribution,
    UIViewFailViewTypeNoRankMore,
    UIViewFailViewTypeVodCategoryOrRank, // 点播分类或者排行榜
    UIViewFailViewTypeNoBackpackGift,
    UIViewFailViewTypeNoBackpackGiftHP,
    UIViewFailViewTypeNOMessage,
    UIViewFailViewTypeMentionNoPraise,
    UIViewFailViewTypeMentionNoComment,
    UIViewFailViewTypeNoMoneyRecord,
    UIViewLuckyDrawNodate,
    UIViewNoInLuckyDraw,
    UIViewFailViewTypeNoCommentReply,
    UIViewFailViewTypeNoSubscribeExpert,
    UIViewFailViewTypeNoSubscribePlan,
    UIViewFailViewTypeGuessNoLogin
};

@interface UIView (DYLoadHUD)

#pragma mark -/** *** 数据加载出来之前的占位图 *** */
/** 数据加载之前的显示的 view */
-(void)placeholderHudViewHidden:(BOOL)hidden type:(DYPlaceholderHUDViewType)placeholderHUDViewType;

/** 数据加载之前的显示的 view */
-(void)placeholderHudViewHidden:(BOOL)hidden frame:(CGRect)frame type:(DYPlaceholderHUDViewType)placeholderHUDViewType;

#pragma mark -/** *** 没有数据的显示的 view *** */
/** 显示没有数据的时候的占位图片 */
-(void)nodataHUDViewHidden:(BOOL)hidden type:(UIViewFailViewType)nodataHUDViewType reloadCallback:(DYCallbackBlock)reloadCallback;

/** 显示没有数据的时候的占位图片 */
-(void)nodataHUDViewHidden:(BOOL)hidden frame:(CGRect)frame type:(UIViewFailViewType)nodataHUDViewType reloadCallback:(DYCallbackBlock)reloadCallback;

#pragma mark -/** *** 数据加载失败的显示的 view *** */
/** 加载失败的 hud 的 view的显示和隐藏 */
-(void)loadFailedHudViewHidden:(BOOL)hidden retryCallback:(DYCallbackBlock)retryCallback;

/** 加载失败的 hud 的 view的显示和隐藏 */
-(void)loadFailedHudViewHidden:(BOOL)hidden frame:(CGRect)frame retryCallback:(DYCallbackBlock)retryCallback;

@end
