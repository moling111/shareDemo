//
//  GJShareWeixinManager.h
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareManager.h"
#import "WXApi.h"

typedef NS_ENUM(NSInteger, GJSHARE_WXTYPE) {
    GJSHARE_WXTYPE_TO_SESSION,
    GJSHARE_WXTYPE_TO_CIRCLE,
};

@interface GJShareWeixinManager : GJShareManager<WXApiDelegate>

-(void)shareToWeixinBase:(GJSHARE_WXTYPE)type;

+ (instancetype)sharedManager;

@end
