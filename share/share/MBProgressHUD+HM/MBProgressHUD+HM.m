//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+HM.h"

@implementation MBProgressHUD (HM)

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

+ (void)hideHUDForView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}

#pragma mark --- 带图片显示一些信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (text.length > 6) {
        [self showTips:text view:view position:MBProgressHUDPositionBottom];
    }else{
        if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.contentColor = [UIColor whiteColor];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.square = YES;
        hud.label.text = text;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.5];
    }
}

#pragma mark --- 加载中
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.backgroundView.color = [UIColor colorWithWhite:0.1 alpha:0.5];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    return hud;
}

#pragma mark --- 不带图片提示信息
+ (void)showTips:(NSString *)tip view:(UIView *)view position:(MBProgressHUDPosition)position{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.0f;
    hud.label.text = tip;
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    CGFloat offsetY = position == MBProgressHUDPositionDefault?0:MBProgressMaxOffset;
    hud.offset = CGPointMake(0.f, offsetY);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}

@end
