//
//  GJShareQQManager.h
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareManager.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

typedef NS_ENUM(NSInteger, GJSHARE_QQTYPE) {
    GJSHARE_QQTYPE_TO_SESSION,
    GJSHARE_QQTYPE_TO_QZONE,
};

@interface GJShareQQManager : GJShareManager<TencentSessionDelegate,QQApiInterfaceDelegate>

-(void)shareToQQBase:(GJSHARE_QQTYPE)type;

+(instancetype)shareManager;

@end
