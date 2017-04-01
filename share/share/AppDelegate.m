//
//  AppDelegate.m
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GJShareQQManager.h"
#import "GJShareWeixinManager.h"
#import "GJShareWeiboManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[self window] setRootViewController:navController];
    [[self window] makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

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

@end
