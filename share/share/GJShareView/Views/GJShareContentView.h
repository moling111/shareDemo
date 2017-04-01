//
//  GJShareContentView.h
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJShareConst.h"

typedef NS_ENUM(NSInteger, GJSHARE_ITEM_TYPE) {
    GJSHARE_ITEM_TYPE_TO_WEIXIN,
    GJSHARE_ITEM_TYPE_TO_CIRCLE,
    GJSHARE_ITEM_TYPE_TO_QQ,
    GJSHARE_ITEM_TYPE_TO_QZONE,
    GJSHARE_ITEM_TYPE_TO_WEIBO,
};
//分享的个数
static NSInteger const shareCount = 5;
static CGFloat const padding = 20;
static CGFloat const shareLabelH = 40;
static CGFloat const cancelBtnH = 45;

@interface GJShareContentView : UIView

@property (nonatomic, assign) GJSHARE_ITEM_TYPE shareType;

@property (nonatomic, copy) void(^cancelBlock)();
@property (nonatomic, copy) void(^shareBlock)(GJSHARE_ITEM_TYPE itemType);

@end
