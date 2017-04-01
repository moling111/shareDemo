//
//  GJShareContentView.m
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareContentView.h"
#import "GJVerticleButton.h"

extern CGFloat btnTitleH;

@interface GJShareContentView ()

@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation GJShareContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpData];
        [self setUpViews];
    }
    return self;
}

-(void)setUpData{
    
    NSURL *weixinUrl = [NSURL URLWithString:@"weixin://"];
    NSURL *tencentUrl = [NSURL URLWithString:@"mqq://"];
    NSURL *weiboUrl = [NSURL URLWithString:@"sinaweibo://"];
    BOOL isInstallWeixin = [[UIApplication sharedApplication] canOpenURL:weixinUrl];
    BOOL isInstallQQ = [[UIApplication sharedApplication] canOpenURL:tencentUrl];
    BOOL isInstallWeibo = [[UIApplication sharedApplication] canOpenURL:weiboUrl];

    self.dataArray = @[@{@"icon":@"share_weixin",
                         @"title":@"微信",
                         @"isinstall":[NSNumber numberWithBool:isInstallWeixin]},
                       @{@"icon":@"share_circle",
                         @"title":@"朋友圈",
                         @"isinstall":[NSNumber numberWithBool:isInstallWeixin]},
                       @{@"icon":@"share_qq",
                         @"title":@"QQ",
                         @"isinstall":[NSNumber numberWithBool:isInstallQQ]},
                       @{@"icon":@"share_Qzone",
                         @"title":@"QQ空间",
                         @"isinstall":[NSNumber numberWithBool:isInstallQQ]},
                       @{@"icon":@"share_sina",
                         @"title":@"新浪",
                         @"isinstall":[NSNumber numberWithBool:isInstallWeibo]}];
    NSAssert(self.dataArray.count == shareCount, @"分享数组与分享个数不一样");
}

-(void)setUpViews{
    self.backgroundColor = SHARE_COLOR(220, 220, 220 ,1);
    
    CGFloat labelX = padding;
    CGFloat labelY = 0;
    CGFloat LabelW = SHARE_SCREENWIDTH - 2*padding;
    CGFloat labelH = shareLabelH;
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, LabelW, labelH)];
    shareLabel.text = @"分享到";
    shareLabel.textColor = [UIColor darkGrayColor];
    shareLabel.font = SHARE_FONT(14);
    [self addSubview:shareLabel];
    
    CGFloat verticleBtnW = (SHARE_SCREENWIDTH - (shareCount+1)*padding)/5;
    CGFloat verticleBtnH = verticleBtnW + btnTitleH;
    CGFloat verticleBtnY = CGRectGetMaxY(shareLabel.frame);
    for (int i=0; i<shareCount; i++) {
        
        CGFloat verticleBtnX = padding+(padding+verticleBtnW)*i;
        
        GJVerticleButton *verticleBtn = [[GJVerticleButton alloc]initWithFrame:CGRectMake(verticleBtnX, verticleBtnY, verticleBtnW, verticleBtnH)];
        NSDictionary *dic = [self.dataArray objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:dic[@"icon"]];
        [verticleBtn setImage:image forState:UIControlStateNormal];
        [verticleBtn setTitle:dic[@"title"] forState:UIControlStateNormal];
        [verticleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        verticleBtn.titleLabel.font = SHARE_FONT(13);
        BOOL isInstall = [dic[@"isinstall"] boolValue];
        verticleBtn.enabled = isInstall;
        [verticleBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:verticleBtn];
    }
    
    CGFloat btnX = 0;
    CGFloat btnY = verticleBtnY + verticleBtnH + padding;
    CGFloat btnW = SHARE_SCREENWIDTH;
    CGFloat btnH = cancelBtnH;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
}

-(void)cancelBtnClick:(UIButton *)sender
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

-(void)shareClick:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    if ([title isEqualToString:@"微信"]) {
        self.shareType = GJSHARE_ITEM_TYPE_TO_WEIXIN;
    }else if ([title isEqualToString:@"朋友圈"]) {
        self.shareType = GJSHARE_ITEM_TYPE_TO_CIRCLE;
    }else if ([title isEqualToString:@"QQ"]) {
        self.shareType = GJSHARE_ITEM_TYPE_TO_QQ;
    }else if ([title isEqualToString:@"QQ空间"]) {
        self.shareType = GJSHARE_ITEM_TYPE_TO_QZONE;
    }else if ([title isEqualToString:@"新浪"]) {
        self.shareType = GJSHARE_ITEM_TYPE_TO_WEIBO;
    }else{
        NSAssert(false, @"未识别的分享选项");
    }
    if (self.shareBlock) {
        self.shareBlock(self.shareType);
    }
}

@end
