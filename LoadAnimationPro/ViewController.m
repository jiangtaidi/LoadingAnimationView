//
//  ViewController.m
//  LoadAnimationPro
//
//  Created by jiangtd on 16/1/7.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "ViewController.h"
#import "AXLoadingAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI
{
    AXLoadingAnimationView *loadView = [AXLoadingAnimationView loadingAnimationViewWithFrame:CGRectMake(100, 100, 150, 50) ballSize:20];
    [self.view addSubview:loadView];
    
}


@end
