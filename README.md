#ReadMe 
======
##注意事项
-------
*程序 —— Targets —— Build Settings —— Linking —— Other Linker Flag 添加 `-ObjC-all_load`

*分享代码如下
-(void)didCancelShareAtShareView:(GJShareView *)shareView
{
    [GJShareView hideShareView];
}

-(void)shareClick {
    GJShareView *shareView = [GJShareView showShareView];
    shareView.delegate = self;
    shareView.shareTitle = @"百度一下";
    shareView.shareLink = @"http://www.baidu.com";
    shareView.shareDesc = @"百度一下";
}

### 处理回调结果 
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [QQApiInterface handleOpenURL:url delegate:[GJShareQQManager shareManager]];
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        [WeiboSDK handleOpenURL:url delegate:[GJShareWeiboManager sharedManager]];
    }else if([[url absoluteString] hasPrefix:@"wx"]) {
        
        return [WXApi handleOpenURL:url delegate:[GJShareWeixinManager sharedManager]];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [QQApiInterface handleOpenURL:url delegate:[GJShareQQManager shareManager]];
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        [WeiboSDK handleOpenURL:url delegate:[GJShareWeiboManager sharedManager]];
    }else if([[url absoluteString] hasPrefix:@"wx"]) {
        
        return [WXApi handleOpenURL:url delegate:[GJShareWeixinManager sharedManager]];
    }
    return YES;
}



###效果如下
![](https://github.com/moling111/shareDemo/blob/master/share/CC81725D9E71AFDF410BC8D6382E7FBF.png)

