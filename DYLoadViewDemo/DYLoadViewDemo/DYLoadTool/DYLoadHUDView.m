//
//  DYLoadHUDView.m
//  QEZB
//
//  Created by 李超群 on 2018/11/17.
//  Copyright © 2018 zhou. All rights reserved.
//

#import "DYLoadHUDView.h"

#pragma mark -/** *** HUDView 的基类 *** */
@implementation DYLoadStatusHUDView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

/** 绘制 UI */
- (void)setupUI{
    
}

/** 设置 HUD 的 view的透明度 */
-(void)setHUDViewHidden:(BOOL)HUDViewHidden{
    if (HUDViewHidden) {
        [UIView animateWithDuration:0.2 animations:^{
            self.layer.opacity = 0;
        }];
    }else{
        self.layer.opacity = 1;
    }
}

@end

#pragma mark -/** *** 页面加载出来之前的 HUDView *** */
@implementation DYPlacehoderHUDView

/** 加载 UI */
- (void)setupUI{
    self.backgroundColor = kColor_gray_FFFFFF;
    UIImageView * placeholderImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:placeholderImageView];
    _placeholderImageView = placeholderImageView;
    [placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

@end

#pragma mark -/** *** 没有数据的 HUDView *** */
@implementation DYNoDataHUDView

/** 加载 UI */
- (void)setupUI{
    /**< 加载失败的图片 */
    self.backgroundColor = kColor_gray_FFFFFF;
    UIImageView *nodataImgeView = ({
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 86, 68)];
        imgV.contentMode = UIViewContentModeCenter;
        [self addSubview:imgV];
        _nodataImgeView = imgV;

        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-12);
        }];
        imgV;
    });
    
    /** 加载失败的提示 */
    UILabel *tipLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"暂无数据";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont_System_normal(14);
        label.textColor = kColor_gray_999999;
        [self addSubview:label];
        _tipLabel = label;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(nodataImgeView);
            make.top.equalTo(nodataImgeView.mas_bottom);
        }];
        label;
    });
    
    /** 重试按钮 */
    ({
        CGFloat buttonH = 27;
        UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadButton setBackgroundColor:kcolor_red_FF5655];
        reloadButton.layer.cornerRadius = buttonH / 2;
        reloadButton.clipsToBounds = YES;
        [reloadButton setTitle:@"刷新" forState: UIControlStateNormal];
        [reloadButton setTitleColor:kColor_gray_FFFFFF forState:UIControlStateNormal];
        reloadButton.titleLabel.font = kFont_System_normal(12);
        [reloadButton addTarget:self action:@selector(onReloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
        reloadButton.hidden = YES;
        [self addSubview:reloadButton];
        _reloadButton = reloadButton;
        
        [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(tipLabel);
            make.top.equalTo(tipLabel.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(78, buttonH));
        }];
    });
}

#pragma mark -/** *** 事件监听 *** */
-(void)onReloadButtonClick{
    self.HUDViewHidden = YES;
    !self.reloadCallback ? : self.reloadCallback();
}

@end

#pragma mark -/** *** 加载失败的 HUDView *** */
@implementation DYLoadfailedHUDView

/** 加载 UI */
- (void)setupUI{
    /**< 加载失败的图片 */
    CGFloat paddingTop = 12;
    self.backgroundColor = kColor_gray_FFFFFF;
    UIImageView *failedImageView = ({
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fail_img"]];
        imgV.contentMode = UIViewContentModeCenter;
        [self addSubview:imgV];
        _failedImageView = imgV;
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-paddingTop);
        }];
        imgV;
    });
    
    /** 加载失败的提示 */
    UILabel *tipLabel =({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"网络加载失败";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont_System_bold(18);
        label.textColor = kColor_gray_000000;
        [self addSubview:label];
        _tipLabel = label;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(failedImageView);
            make.top.equalTo(failedImageView.mas_bottom).offset(paddingTop);
        }];
        label;
    });
    
    /** 刷新提示的 label */
    UILabel *refreshLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"请再次刷新或检查网络";
        label.textColor = kColor_gray_999999;
        label.font = kFont_System_normal(14);
        [self addSubview:label];
        _refreshLabel = label;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(tipLabel);
            make.top.equalTo(tipLabel.mas_bottom).offset(paddingTop);
        }];
        label;
    });
    
    /** 重试按钮 */
    ({
        CGFloat buttonH = 36;
        UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        retryButton.titleLabel.font = kFont_System_bold(14);
        retryButton.backgroundColor = kColor_yellow_FFD800;
        retryButton.clipsToBounds = YES;
        retryButton.layer.cornerRadius = buttonH / 2;
        [retryButton setTitle:@"刷新" forState: UIControlStateNormal];
        [retryButton setTitleColor:kColor_gray_000000 forState:UIControlStateNormal];
        [retryButton addTarget:self action:@selector(retryButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:retryButton];
        _retryButton = retryButton;
        
        [retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(refreshLabel);
            make.top.equalTo(refreshLabel.mas_bottom).offset(30);
            make.size.mas_equalTo(CGSizeMake(121, buttonH));
        }];
        
    });
}

#pragma mark -/** *** 按钮的事件监听 *** */
/** 重试按钮的事件监听 */
-(void)retryButtonClick{
    self.HUDViewHidden = YES;
    !self.retryCallback ? : self.retryCallback();
}


@end
