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

@required;
-(void)didCancelShareAtShareView:(GJShareView *)shareView;

@end
@interface GJShareView : UIView

+ (instancetype)showShareView;
+ (BOOL)hideShareView;

@property (nonatomic, assign) id<GJShareViewDelegate> delegate;

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, copy) NSString *shareDesc;

//本地图片缩略图->默认选择
@property (nonatomic, strong) UIImage *defaultLocalImage;
//网络图片缩略图->只支持qq
@property (nonatomic, copy) NSString *netWorkImageUrl;

@end
