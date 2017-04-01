//
//  GJShareWeiboManager.h
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareManager.h"
#import "WeiboSDK.h"

@interface GJShareWeiboManager : GJShareManager<WeiboSDKDelegate>

#pragma mark --- 分享新浪微博
-(void)shareToWeibo;

+ (instancetype)sharedManager;

@end
