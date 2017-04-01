//
//  GJShareWeiboManager.m
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareWeiboManager.h"

@interface GJShareWeiboManager ()

@property (strong, nonatomic) NSString *wbtoken;

@end
@implementation GJShareWeiboManager

static GJShareWeiboManager *instance;
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GJShareWeiboManager alloc] init];
    });
    return instance;
}

-(instancetype)init {
    if (self = [super init]) {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:Weibo_AppID];
    }
    return self;
}

-(void)shareToWeibo {
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = self.linkStr;
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = self.titleStr;
    webpage.description = self.descStr;
    webpage.thumbnailData = UIImageJPEGRepresentation(self.defaultLocalImage, 0.5);
    webpage.webpageUrl = self.linkStr;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:self.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

#pragma mark --- WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            [MBProgressHUD showSuccess:@"分享成功" toView:nil];
        }
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
        {
            [MBProgressHUD showError:@"取消分享" toView:nil];
        }
            break;
        case WeiboSDKResponseStatusCodeSentFail:
        {
            [MBProgressHUD showError:@"分享失败" toView:nil];
        }
            break;
        default:
        {
            [MBProgressHUD showError:@"分享失败" toView:nil];
        }
            break;
    }
}

@end
