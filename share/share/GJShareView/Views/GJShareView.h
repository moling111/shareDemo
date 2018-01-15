//
//  GJShareView.h
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJShareView;

@protocol GJShareViewDelegate <NSObject>

@optional;
- (void)didHideShareView:(GJShareView *)shareView;
@end

@interface GJShareView : UIControl
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 链接 */
@property (nonatomic, copy) NSString *link;
/** 描述文字 */
@property (nonatomic, copy) NSString *desc;
/** 本地图片缩略图->默认选择 */
@property (nonatomic, strong) UIImage *localImage;
/** 网络图片缩略图->只支持qq */
@property (nonatomic, copy) NSString *imageUrlPath;

@property (nonatomic, assign) id<GJShareViewDelegate> delegate;
/** 快速创建 */
+ (instancetype)shareViewWithTitle:(NSString *)title link:(NSString *)link desc:(NSString *)desc;

- (BOOL)hideShareView;

@end
