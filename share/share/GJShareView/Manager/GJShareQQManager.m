//
//  GJShareQQManager.m
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareQQManager.h"

@interface GJShareQQManager ()

@end

@implementation GJShareQQManager

static GJShareQQManager *manager = nil;
+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GJShareQQManager alloc]init];
    });
    return manager;
}

-(instancetype)init {
    if (self = [super init]) {
       TencentOAuth *oauth = [[TencentOAuth alloc] initWithAppId:Tencent_AppID andDelegate:self];
        NSLog(@"oauth = %@",oauth.accessToken);
    }
    return self;
}

-(void)shareToQQBase:(GJSHARE_QQTYPE)type {
    
    NSURL *linkUrl = [NSURL URLWithString:self.linkStr];
    QQApiNewsObject *img = nil;
    if (self.netWorkImageUrl.length>0 && [self.netWorkImageUrl hasPrefix:@"http"]) {
        NSURL *previewURL = [NSURL URLWithString:self.netWorkImageUrl];
        img = [QQApiNewsObject objectWithURL:linkUrl title:self.titleStr description:self.descStr previewImageURL:previewURL];
    }else{
        NSData* data = UIImageJPEGRepresentation(self.defaultLocalImage, 0.5);
        img = [QQApiNewsObject objectWithURL:linkUrl title:self.titleStr description:self.descStr previewImageData:data];
    }
    img.shareDestType = ShareDestTypeQQ;
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    if (type == GJSHARE_QQTYPE_TO_SESSION) { //将内容分享到qq
        
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        [self handleSendResult:sent];
    }else{//将内容分享到qzone
        
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
        [self handleSendResult:sent];
    }
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [MBProgressHUD showError:@"App未注册" toView:nil];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:case EQQAPIMESSAGECONTENTNULL:case EQQAPIMESSAGETYPEINVALID:
        {
            [MBProgressHUD showError:@"发送参数错误" toView:nil];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:case EQQAPITIMNOTSUPPORTAPI:
        {
            [MBProgressHUD showError:@"API接口不支持" toView:nil];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [MBProgressHUD showError:@"发送失败" toView:nil];
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE:case ETIMAPIVERSIONNEEDUPDATE:
        {
            [MBProgressHUD showError:@"当前QQ版本太低，需要更新" toView:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark --- TencentLoginDelegate
- (void)tencentDidLogin {}
- (void)tencentDidNotLogin:(BOOL)cancelled {}
- (void)tencentDidNotNetWork {}


#pragma mark --- QQApiInterfaceDelegate
/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
    if ([resp.result integerValue] == 0) {
        [MBProgressHUD showSuccess:@"分享成功" toView:nil];
    }else{
        [MBProgressHUD showError:@"分享失败" toView:nil];
    }
}
- (void)onReq:(QQBaseReq *)req{};
- (void)isOnlineResponse:(NSDictionary *)response{};

@end
