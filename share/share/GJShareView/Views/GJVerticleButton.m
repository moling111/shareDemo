//
//  GJVerticleButton.m
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "GJVerticleButton.h"

CGFloat btnTitleH = 30;

@implementation GJVerticleButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    NSAssert(frameHeight == frameWidth+btnTitleH, @"按钮高度必须等于宽度+30");
    // Center image
    CGRect imageViewF = self.imageView.frame;
    imageViewF.origin.x = 0;
    imageViewF.origin.y = 0;
    imageViewF.size.width = frameWidth;
    imageViewF.size.height = frameHeight - btnTitleH;
    self.imageView.frame = imageViewF;
    
    //Center text
    CGRect newFrame = self.titleLabel.frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = imageViewF.size.height;
    newFrame.size.width = frameWidth;
    newFrame.size.height = btnTitleH;
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)dealloc {
    NSLog(@"__func__-------%s",__func__);
}

@end
