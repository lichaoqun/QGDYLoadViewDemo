

//
//  UIView+DYLoadHUD.m
//  QEZB
//
//  Created by 李超群 on 2018/11/16.
//  Copyright © 2018 zhou. All rights reserved.
//

#import "UIView+DYLoadHUD.h"
#import <objc/message.h>
#import "DYThemeManager.h"

@interface UIView ()

/** 占位图的imageView */
@property (nonatomic, strong) DYPlacehoderHUDView *placehoderHUDView;

/** 没有数据的view */
@property (nonatomic, strong) DYNoDataHUDView *noDataHUDView;

/** 加载失败的 view */
@property (nonatomic, strong) DYLoadfailedHUDView *loadfailedHUDView;

@end

@implementation UIView (DYLoadHUD)

/** 占位图的 key */
static char *placehoderHUDKey = "placehoderHUDKey";

/** 没有数据的 key */
static char *noDataHUDViewKey = "noDataHUDViewKey";

/** 加载失败 key */
static char *loadfailedHUDViewKey = "loadfailedHUDViewKey";

/** 隐藏其他的 view */
- (void)hiddenViewsExcept:(DYLoadStatusHUDView *)view{
    DYPlacehoderHUDView * _placehoderHUDView =  objc_getAssociatedObject(self, placehoderHUDKey);
    DYNoDataHUDView * _noDataHUDView = objc_getAssociatedObject(self, noDataHUDViewKey);
    DYLoadfailedHUDView * _loadfailedHUDView = objc_getAssociatedObject(self, loadfailedHUDViewKey);
    
    (view == _placehoderHUDView) ? : [_placehoderHUDView.layer setOpacity:0];
    (view == _noDataHUDView) ? : [_noDataHUDView.layer setOpacity:0];
    (view == _loadfailedHUDView) ? : [_loadfailedHUDView.layer setOpacity:0];
}

#pragma mark -/** *** 数据加载出来之前的占位图 *** */
/** 数据加载之前的显示的 view */
-(void)placeholderHudViewHidden:(BOOL)hidden type:(DYPlaceholderHUDViewType)placeholderHUDViewType{
    [self placeholderHudViewHidden:hidden frame:self.bounds type:placeholderHUDViewType];
}

/** 数据加载之前的显示的 view */
-(void)placeholderHudViewHidden:(BOOL)hidden frame:(CGRect)frame type:(DYPlaceholderHUDViewType)placeholderHUDViewType{
    [self hiddenViewsExcept:self.placehoderHUDView];
    self.placehoderHUDView.HUDViewHidden = hidden;
    if (hidden) return;
    
    NSString *imageName = nil;
    NSArray *animationImages = nil;
    switch (placeholderHUDViewType) {
        case DYPlaceholderHUDViewTypeNormal:/**< 普通的加载动画 */
            animationImages = [[DYThemeManager shareManager] loadingAnimateImages];
            break;
        case DYPlaceholderHUDViewTypeShortVideo:/**< 短视频 */
            imageName = @"shortVideo_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeAttention_nologin:/**< 关注未登录 */
            imageName = @"attention_nologin_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeAttention_login_1:/**< 关注登录样式1 */
            imageName = @"attention_login1_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeAttention_login_2:/**< 关注登录样式2 */
            imageName = @"attention_login2_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeAttention_login_3:/**< 关注登录样式3 */
            imageName = @"attention_login3_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeHome_category:/**< 首页其他分类 */
            imageName = @"home_category_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeHome_recommend:/**< 首页推荐 */
            imageName = @"home_recommond_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeHome_live: /**< 首页直播 */
            imageName = @"home_live_default_placeImage";
            break;
        case DYPlaceholderHUDViewTypeGuessHomeList: /**< 乐猜首页 */
            imageName = @"home_guess_default_placeImage";
            break;
    }
    
    /** 设置图片的属性 */
    if (animationImages) {
        self.placehoderHUDView.placeholderImageView.animationImages = animationImages;
        self.placehoderHUDView.placeholderImageView.animationDuration = 0.15 * [animationImages count];
        self.placehoderHUDView.placeholderImageView.animationRepeatCount = 0;
        [self.placehoderHUDView.placeholderImageView startAnimating];
    }else{
        UIImage *img = [UIImage imageNamed:imageName];
        self.placehoderHUDView.placeholderImageView.image = img;
    }
    self.placehoderHUDView.frame = frame;
    [self bringSubviewToFront:self.placehoderHUDView];
}

#pragma mark -/** *** 没有数据的显示的 view *** */
/** 显示没有数据的时候的占位图片 */
-(void)nodataHUDViewHidden:(BOOL)hidden type:(UIViewFailViewType)nodataHUDViewType reloadCallback:(nonnull DYCallbackBlock)reloadCallback{
    [self nodataHUDViewHidden:hidden frame:self.bounds type:nodataHUDViewType reloadCallback:reloadCallback];
}

/** 显示没有数据的时候的占位图片 */
-(void)nodataHUDViewHidden:(BOOL)hidden frame:(CGRect)frame type:(UIViewFailViewType)nodataHUDViewType reloadCallback:(nonnull DYCallbackBlock)reloadCallback{
    [self hiddenViewsExcept:self.noDataHUDView];
    self.noDataHUDView.HUDViewHidden = hidden;
    if (hidden) return;
    
    NSString *imageName;
    NSString *tips;
    NSString *buttonTitle;
    BOOL hiddenButton = YES;
    switch (nodataHUDViewType) {
        case UIViewFailViewTypeDefault: {
            imageName = @"img_no_data_history";
            tips      = @"暂无数据";
            break;
        }
        case UIViewFailViewTypeFollow: {
            imageName = @"img_no_data_follow";
            tips      = @"暂无数据,多关注些主播吧";
            break;
        }
        case UIViewFailViewTypeHistory: {
            imageName = @"img_no_data_history";
            tips      = @"暂无数据";
            break;
        }
        case UIViewFailViewTypeTask: {
            imageName = @"img_no_data_task";
            tips      = @"恭喜您已经完成全部任务!";
            break;
        }
        case UIViewFailViewTypeMessage: {
            imageName = @"img_no_data_message";
            tips      = @"暂无数据";
            break;
        }
        case UIViewFailViewTypeRank: {
            imageName = @"img_no_data_rank";
            tips      = @"暂无数据";
            break;
        }
        case UIViewFailViewTypeCommon:{
            imageName = @"img_no_data_commom";
            tips      = @"您经常观看的栏目会出现在这儿~";
            break;
        }
        case UIViewFailViewTypeAnchor:{
            imageName = @"img_no_data_notice";
            tips      = @"主播很懒,什么都没有留下";
            break;
        }
        case UIViewFailViewTypeSearch:{
            imageName = @"img_no_living";
            tips      = @"换个条件搜索试试吧~";
            break;
        }
        case UIViewFailViewTypeLive:{
            imageName = @"img_no_living";
            tips      = @"暂无直播，去其它栏目看看吧~";
            break;
        }
        case UIViewFailViewTypeQuizRank:{
            imageName = @"img_no_data_rank_list";
            tips      = @"榜单空缺，快去冲榜吧";
            break;
        }
        case UIViewFailViewTypeQuiz:{
            imageName = @"lottery_no_jingcai";
            tips      = @"暂无乐答数据";
            break;
        }
        case UIViewFailViewTypeConsume:{
            imageName = @"";
            tips      = @"暂无消费记录";
            break;
        }
        case UIViewFailViewTypeHighlights:{
            imageName = @"Image_no_highlights";
            tips      = @"暂无视频集锦";
            break;
        }
        case UIViewFailViewTypeNOAnchor:{
            imageName = @"Image_no_anchor";
            tips      = @"目前暂无主播哦";
            break;
        }
        case UIViewFailViewTypeNoContribution:{
            imageName = @"Image_no_highlights";
            tips      = @"没有上传投稿视频哦";
            break;
        }
        case UIViewFailViewTypeNoRankMore:{
            tips      = @"暂无更多排名";
            imageName = @"";
            break;
        }
        case UIViewFailViewTypeVodCategoryOrRank: {
            tips      = @"暂无分类数据，去其他栏目看看吧";
            imageName = @"img_no_living";
            break;
        }
            
        case UIViewFailViewTypeNoBackpackGift:{
            tips =  @"装备包里什么都没有~";
            imageName = @"backpack_gift_nothing";
            break;
        }
        case UIViewFailViewTypeNoBackpackGiftHP:{
            tips =  @"装备包里什么都没有~";
            imageName = @"backpack_gift_nothing_hp";
            break;
        }
        case UIViewFailViewTypeNOMessage:{
            tips =  @"暂时没有消息~";
            imageName = @"message_nodata";
            break;
        }
        case UIViewFailViewTypeMentionNoPraise:{
            tips =  @"还没有人给你点赞哦~";
            imageName = @"mention_no_praise";
            break;
        }
        case UIViewFailViewTypeMentionNoComment:{
            tips =  @"还没有人给你评论哦~";
            imageName = @"mention_no_comment";
            break;
        }
            
        case UIViewFailViewTypeNoCommentReply:{
            tips =  @"暂无回复，说说你的看法~";
            imageName = @"mention_no_comment";
            break;
        }
        case UIViewFailViewTypeNoMoneyRecord:{
            tips =  @"暂无数据";
            imageName = @"";
            break;
        }
        case UIViewLuckyDrawNodate: {
            imageName = @"img_no_data_luckyDraw";
            tips      = @"暂无数据";
            break;
        }
        case UIViewNoInLuckyDraw: {
            imageName = @"img_no_data_luckyDraw";
            tips      = @"本次抽奖无人符合抽奖要求";
            break;
        }
        case UIViewFailViewTypeNoSubscribeExpert:{
            imageName = @"guess_no_expert";
            tips      = @"您还没有订阅任何专家";
            buttonTitle = @"去订阅";
            hiddenButton = NO;
            break;
        }
        case UIViewFailViewTypeNoSubscribePlan:{
            imageName = @"guess_no_sub_plan";
            tips      = @"暂无最新方案，去订阅更多专家吧";
            buttonTitle = @"去订阅";
            hiddenButton = NO;
            break;
        }
        case UIViewFailViewTypeGuessNoLogin:{
            imageName = @"guss_no_login";
            tips      = @"登录后才能看到哦";
            buttonTitle = @"点击登录";
            hiddenButton = NO;
            break;
        }
    }
    
    self.noDataHUDView.frame = frame;
    self.noDataHUDView.nodataImgeView.image = [UIImage imageNamed:imageName];
    self.noDataHUDView.tipLabel.text = tips;
    [self.noDataHUDView.reloadButton setTitle:buttonTitle forState:UIControlStateNormal];
    self.noDataHUDView.reloadButton.hidden = hiddenButton;
    self.noDataHUDView.reloadCallback = reloadCallback;
    [self bringSubviewToFront:self.noDataHUDView];
}

#pragma mark -/** *** 加载失败显示的 view *** */
/** 加载失败的 hud 的 view的显示和隐藏 */
-(void)loadFailedHudViewHidden:(BOOL)hidden retryCallback:(DYCallbackBlock)retryCallback{
    [self loadFailedHudViewHidden:hidden frame:self.bounds retryCallback:retryCallback];
}

/** 加载失败的 hud 的 view的显示和隐藏 */
-(void)loadFailedHudViewHidden:(BOOL)hidden frame:(CGRect)frame retryCallback:(DYCallbackBlock)retryCallback{
    [self hiddenViewsExcept:self.loadfailedHUDView];
    self.loadfailedHUDView.HUDViewHidden = hidden;
    if (hidden) return;
    
    self.loadfailedHUDView.frame = frame;
    self.loadfailedHUDView.retryCallback = retryCallback;
    [self bringSubviewToFront:self.loadfailedHUDView];
}

#pragma mark -/** *** 懒加载 *** */
/** 数据加载出来之前的占位图 */
- (DYPlacehoderHUDView *)placehoderHUDView{
    DYPlacehoderHUDView * _placehoderHUDView =  objc_getAssociatedObject(self, placehoderHUDKey);
    if(!_placehoderHUDView){
        _placehoderHUDView = [[DYPlacehoderHUDView alloc] init];
        [self addSubview:_placehoderHUDView];
        objc_setAssociatedObject(self, placehoderHUDKey, _placehoderHUDView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _placehoderHUDView;
}

/** 暂无数据的view  */
- (DYNoDataHUDView *)noDataHUDView{
    DYNoDataHUDView * _noDataHUDView = objc_getAssociatedObject(self, noDataHUDViewKey);
    if (!_noDataHUDView) {
        _noDataHUDView = [[DYNoDataHUDView alloc]init];
        [self addSubview:_noDataHUDView];
        objc_setAssociatedObject(self, noDataHUDViewKey, _noDataHUDView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _noDataHUDView;
}

/** 加载失败的view */
- (DYLoadfailedHUDView *)loadfailedHUDView{
    DYLoadfailedHUDView * _loadfailedHUDView = objc_getAssociatedObject(self, loadfailedHUDViewKey);
    if (!_loadfailedHUDView) {
        _loadfailedHUDView = [[DYLoadfailedHUDView alloc]init];
        [self addSubview:_loadfailedHUDView];
        objc_setAssociatedObject(self, loadfailedHUDViewKey, _loadfailedHUDView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return _loadfailedHUDView;
}

@end
