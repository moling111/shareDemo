//
//  GJShareManager.m
//  share
//
//  Created by drision on 2017/3/30.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJShareManager.h"

@implementation GJShareManager

-(instancetype)init {
    if (self = [super init]) {
        self.defaultLocalImage = [UIImage imageNamed:@"Default_Image"];
    }
    return self;
}

-(void)setDefaultLocalImage:(UIImage *)defaultLocalImage {
    if (defaultLocalImage) {
        _defaultLocalImage = defaultLocalImage;
    }
}

-(void)setNetWorkImageUrl:(NSString *)netWorkImageUrl {
    if (netWorkImageUrl.length>0) {
        _netWorkImageUrl = netWorkImageUrl;
    }
}


@end
