//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, MBProgressHUDPosition) {
    MBProgressHUDPositionDefault,
    MBProgressHUDPositionBottom,
};

@interface MBProgressHUD (HM)

+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view;

+ (void)showError:(NSString *)error
           toView:(UIView *)view;

+ (void)showTips:(NSString *)tip
            view:(UIView *)view
        position:(MBProgressHUDPosition)position;

+ (MBProgressHUD *)showMessage:(NSString *)message
                        toView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;

@end
