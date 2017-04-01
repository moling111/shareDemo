//
//  GJShareWeixinManager.m
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareWeixinManager.h"

static NSString *kLinkTagName = @"WECHAT_TAG_JUMP_SHOWRANK";

@implementation GJShareWeixinManager

static GJShareWeixinManager *instance;
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GJShareWeixinManager alloc] init];
    });
    return instance;
}

-(instancetype)init {
    if (self = [super init]) {
        //向微信注册
        [WXApi registerApp:Weixin_AppID enableMTA:YES];
        //向微信注册支持的文件类型
        UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
        [WXApi registerAppSupportContentFlag:typeFlag];
    }
    return self;
}

-(void)shareToWeixinBase:(GJSHARE_WXTYPE)type {

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.linkStr;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.titleStr;
    message.description = self.descStr;
    message.mediaObject = ext;
    message.mediaTagName = kLinkTagName;
    [message setThumbImage:self.defaultLocalImage];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    if (type == GJSHARE_WXTYPE_TO_SESSION) {//微信会话
        req.scene = WXSceneSession;
    }else{//微信朋友圈
        req.scene = WXSceneTimeline;
    }
    req.message = message;
    [WXApi sendReq:req];
}

#pragma mark --- WXApiDelegate
-(void) onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if(resp.errCode == 0) {
            [MBProgressHUD showSuccess:@"分享成功" toView:nil];
        }else{
            [MBProgressHUD showError:@"分享失败" toView:nil];
        }
    }
}
@end
