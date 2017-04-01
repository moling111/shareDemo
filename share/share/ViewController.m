//
//  ViewController.m
//  share
//
//  Created by drision on 2017/3/29.
//  Copyright © 2017年 drision. All rights reserved.
//

#import "ViewController.h"
#import "GJShareView.h"

@interface ViewController ()<GJShareViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *baritem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tpk_navigationbar_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareClick)];
    self.navigationItem.rightBarButtonItem = baritem;
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
