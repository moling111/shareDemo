//
//  GJShareView.m
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareView.h"
#import "GJShareContentView.h"
#import "GJShareWeixinManager.h"
#import "GJShareQQManager.h"
#import "GJShareWeiboManager.h"

extern CGFloat btnTitleH;

@interface GJShareView ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) GJShareContentView *contentView;
@end

@implementation GJShareView

+ (instancetype)showShareView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GJShareView *shareView = [[self alloc]initWithFrame:window.bounds];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShareView)];
    tapGes.delegate = shareView;
    [shareView addGestureRecognizer:tapGes];
    [window addSubview:shareView];
    return shareView;
}

+ (BOOL)hideShareView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GJShareView *shareView = [self shareForView:window];
    if (shareView != nil) {
        [shareView removeFromSuperview];
        return YES;
    }
    return NO;
}

+ (GJShareView *)shareForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (GJShareView *)subview;
        }
    }
    return nil;
}

-(void)removeFromSuperview {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = SHARE_SCREENHEIGHT;
        self.contentView.frame = contentFrame;
    }completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
        [self showMoveAnimated];
    }
    return self;
}

-(void)setUpViews {
    self.backgroundColor = SHARE_COLOR(100, 100, 100, 0.5);
    CGRect rect = CGRectMake(0, SHARE_SCREENHEIGHT, SHARE_SCREENWIDTH, SHARE_SCREENHEIGHT);
    GJShareContentView *contentView = [[GJShareContentView alloc]initWithFrame:rect];
    __weak typeof(self) weakSelf = self;
    //取消
    [contentView setCancelBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didCancelShareAtShareView:)]) {
            [weakSelf.delegate didCancelShareAtShareView:weakSelf];
        }
    }];
    //确定
    [contentView setShareBlock:^(GJSHARE_ITEM_TYPE itemType) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didCancelShareAtShareView:)]) {
            [weakSelf.delegate didCancelShareAtShareView:weakSelf];
        }
        [weakSelf shareContentWithItemType:itemType];
    }];
    [self addSubview:contentView];
    self.contentView = contentView;
}

-(void)showMoveAnimated {
    CGFloat shareIconH = (SHARE_SCREENWIDTH - (shareCount+1)*padding)/5 + padding + btnTitleH;
    CGFloat moveDistance = shareLabelH + shareIconH + cancelBtnH;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = SHARE_SCREENHEIGHT - moveDistance;
        self.contentView.frame = contentFrame;
    }];
}

#pragma mark --- UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark --- 分享Action
-(void)shareContentWithItemType:(GJSHARE_ITEM_TYPE)itemType {
    switch (itemType) {
        case GJSHARE_ITEM_TYPE_TO_WEIXIN:
        {
            [self shareToWXBaseWityType:GJSHARE_ITEM_TYPE_TO_WEIXIN];
        }
            break;
        case GJSHARE_ITEM_TYPE_TO_CIRCLE:
        {
            [self shareToWXBaseWityType:GJSHARE_ITEM_TYPE_TO_CIRCLE];
        }
            break;
        case GJSHARE_ITEM_TYPE_TO_QQ:
        {
            [self shareToQQBaseWithType:GJSHARE_ITEM_TYPE_TO_QQ];
        }
            break;
        case GJSHARE_ITEM_TYPE_TO_QZONE:
        {
            [self shareToQQBaseWithType:GJSHARE_ITEM_TYPE_TO_QZONE];
        }
            break;
        case GJSHARE_ITEM_TYPE_TO_WEIBO:
        {
            [self shareToWeibo];
        }
            break;
        default:
            break;
    }
}

#pragma mark --- 分享微信基类
-(void)shareToWXBaseWityType:(GJSHARE_ITEM_TYPE)type {
    GJShareWeixinManager *manager = [GJShareWeixinManager sharedManager];
    manager.titleStr = self.shareTitle;
    manager.linkStr = self.shareLink;
    manager.descStr = self.shareDesc;
    manager.defaultLocalImage = self.defaultLocalImage;
    if (type == GJSHARE_ITEM_TYPE_TO_WEIXIN) {
        [manager shareToWeixinBase:GJSHARE_WXTYPE_TO_SESSION];
    }else{
        [manager shareToWeixinBase:GJSHARE_WXTYPE_TO_CIRCLE];
    }
}

#pragma mark --- 分享QQ基类
-(void)shareToQQBaseWithType:(GJSHARE_ITEM_TYPE)type {
    GJShareQQManager *manager = [GJShareQQManager shareManager];
    manager.titleStr = self.shareTitle;
    manager.linkStr = self.shareLink;
    manager.descStr = self.shareDesc;
    manager.defaultLocalImage = self.defaultLocalImage;
    manager.netWorkImageUrl = self.netWorkImageUrl;
    if (type == GJSHARE_ITEM_TYPE_TO_QQ) {
        [manager shareToQQBase:GJSHARE_QQTYPE_TO_SESSION];
    }else{
        [manager shareToQQBase:GJSHARE_QQTYPE_TO_QZONE];
    }
}


#pragma mark --- 分享新浪微博
-(void)shareToWeibo {
    GJShareWeiboManager *manager = [GJShareWeiboManager sharedManager];
    manager.titleStr = self.shareTitle;
    manager.linkStr = self.shareLink;
    manager.descStr = self.shareDesc;
    manager.defaultLocalImage = self.defaultLocalImage;
    [manager shareToWeibo];
}

-(void)dealloc {
     NSLog(@"__func__-------%s",__func__);
}

@end
