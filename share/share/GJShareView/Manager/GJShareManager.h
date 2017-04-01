//
//  GJShareManager.h
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJShareConst.h"

@interface GJShareManager : NSObject

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *linkStr;
@property (nonatomic, copy) NSString *descStr;

@property (nonatomic, strong) UIImage *defaultLocalImage;

@property (nonatomic, copy) NSString *netWorkImageUrl;

@end
