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

@interface GJShareView ()

@property (nonatomic, weak) GJShareContentView *contentView;
@end

@implementation GJShareView

+ (instancetype)shareViewWithTitle:(NSString *)title link:(NSString *)link desc:(NSString *)desc {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GJShareView *shareView = [[self alloc]initWithFrame:window.bounds];
    shareView.title = title;
    shareView.link = link;
    shareView.desc = desc;
    shareView.localImage = [UIImage imageNamed:@"11"];
    [shareView addTarget:shareView action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:shareView];
    [shareView showMoveAnimated];
    return shareView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithRed:(100)/255.0 green:(100)/255.0 blue:(100)/255.0 alpha:0.5];
        
        CGRect rect = CGRectMake(0, SHARE_SCREENHEIGHT, SHARE_SCREENWIDTH, SHARE_SCREENHEIGHT);
        GJShareContentView *contentView = [[GJShareContentView alloc]initWithFrame:rect];
        __weak typeof(self) weakSelf = self;
        //取消
        [contentView setCancelBlock:^{
            [weakSelf hideShareView];
        }];
        //确定
        [contentView setShareBlock:^(GJSHARE_ITEM_TYPE itemType) {
            [weakSelf hideShareView];
            [weakSelf shareContentWithItemType:itemType];
        }];
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return self;
}

- (BOOL)hideShareView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GJShareView *shareView = [self shareForView:window];
    if (shareView != nil) {
        [shareView removeFromSuperview];
        return YES;
    }
    return NO;
}

- (GJShareView *)shareForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[GJShareView class]]) {
            return (GJShareView *)subview;
        }
    }
    return nil;
}

- (void)removeFromSuperview {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = SHARE_SCREENHEIGHT;
        self.contentView.frame = contentFrame;
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didHideShareView:)]) {
            [self.delegate didHideShareView:self];
        }
        [super removeFromSuperview];
    }];
}

- (void)showMoveAnimated {
    CGFloat shareIconH = (SHARE_SCREENWIDTH - (shareCount+1)*padding)/5 + padding + btnTitleH;
    CGFloat moveDistance = shareLabelH + shareIconH + cancelBtnH;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = SHARE_SCREENHEIGHT - moveDistance;
        self.contentView.frame = contentFrame;
        self.alpha = 1;
    }];
}

#pragma mark --- 分享Action
- (void)shareContentWithItemType:(GJSHARE_ITEM_TYPE)itemType {
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
- (void)shareToWXBaseWityType:(GJSHARE_ITEM_TYPE)type {
    GJShareWeixinManager *manager = [GJShareWeixinManager sharedManager];
    manager.titleStr = self.title;
    manager.linkStr = self.link;
    manager.descStr = self.desc;
    manager.defaultLocalImage = self.localImage;
    if (type == GJSHARE_ITEM_TYPE_TO_WEIXIN) {
        [manager shareToWeixinBase:GJSHARE_WXTYPE_TO_SESSION];
    }else{
        [manager shareToWeixinBase:GJSHARE_WXTYPE_TO_CIRCLE];
    }
}

#pragma mark --- 分享QQ基类
- (void)shareToQQBaseWithType:(GJSHARE_ITEM_TYPE)type {
    GJShareQQManager *manager = [GJShareQQManager shareManager];
    manager.titleStr = self.title;
    manager.linkStr = self.link;
    manager.descStr = self.desc;
    manager.defaultLocalImage = self.localImage;
    manager.netWorkImageUrl = self.imageUrlPath;
    if (type == GJSHARE_ITEM_TYPE_TO_QQ) {
        [manager shareToQQBase:GJSHARE_QQTYPE_TO_SESSION];
    }else{
        [manager shareToQQBase:GJSHARE_QQTYPE_TO_QZONE];
    }
}


#pragma mark --- 分享新浪微博
- (void)shareToWeibo {
    GJShareWeiboManager *manager = [GJShareWeiboManager sharedManager];
    manager.titleStr = self.title;
    manager.linkStr = self.link;
    manager.descStr = self.desc;
    manager.defaultLocalImage = self.localImage;
    [manager shareToWeibo];
}

- (void)dealloc {
     NSLog(@"__func__-------%s",__func__);
}

@end
