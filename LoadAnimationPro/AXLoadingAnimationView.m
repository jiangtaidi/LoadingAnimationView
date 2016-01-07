//
//  AXLoadingAnimationView.m
//  AxProject
//
//  Created by jiangtd on 16/1/7.
//  Copyright © 2016年 jiangtd. All rights reserved.
//

#import "AXLoadingAnimationView.h"
#import "UIView+addView.h"

@interface AXLoadingAnimationView ()

@property(nonatomic,weak)UIView* leftBallView;
@property(nonatomic,weak)UIView* rightBallView;
@property(nonatomic,weak)UIView* middleBallView;
@property(nonatomic,assign)CGFloat ballSize;

@property(nonatomic,assign)BOOL isAnimation;
@property(nonatomic,assign)BOOL readyStop;

@end

@implementation AXLoadingAnimationView

+(AXLoadingAnimationView*)loadingAnimationViewWithFrame:(CGRect)frame ballSize:(CGFloat)ballSize;
{
    return [[AXLoadingAnimationView alloc] initWithRect:frame ballSize:ballSize];
}

-(id)initWithRect:(CGRect)frame ballSize:(CGFloat)ballSize
{
    self.ballSize = ballSize;
    return [self initWithFrame:frame];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor redColor];
    self.leftBallView = leftView;
    [self addSubview:leftView];
    
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = [UIColor blackColor];
    self.middleBallView = middleView;
    [self addSubview:middleView];
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor blueColor];
    self.rightBallView = rightView;
    [self addSubview:rightView];
    
    self.middleBallView.frame = CGRectMake(0, 0, self.ballSize, self.ballSize);
    self.leftBallView.frame = CGRectMake(0, 0, self.ballSize, self.ballSize);
    self.rightBallView.frame = CGRectMake(0, 0, self.ballSize, self.ballSize);
    
    self.middleBallView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);//self.center;
    self.leftBallView.center = CGPointMake(self.middleBallView.center.x - self.ballSize*2, self.middleBallView.center.y);
    self.rightBallView.center = CGPointMake(self.middleBallView.center.x + self.ballSize*2, self.middleBallView.center.y);
    
    [self setCornerWithView:self.leftBallView borderColor:[UIColor clearColor] borderWidth:1 cornerRadius:self.ballSize/2];
     [self setCornerWithView:self.middleBallView borderColor:[UIColor clearColor] borderWidth:1 cornerRadius:self.ballSize/2];
     [self setCornerWithView:self.rightBallView borderColor:[UIColor clearColor] borderWidth:1 cornerRadius:self.ballSize/2];
}

-(void)setCornerWithView:(UIView*)view borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

-(void)didMoveToSuperview
{
    if (self.superview) {
        [self startAnimation];
    }
    else
    {
        [self stopAnimation];
    }
}

-(void)startAnimation
{
    self.readyStop = NO;
    self.isAnimation = YES;
    [self performAnimation];
}

-(void)performAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.leftBallView.centerX = self.leftBallView.centerX + self.ballSize*2;
        self.rightBallView.centerX = self.rightBallView.centerX - self.ballSize*2;
        self.leftBallView.alpha = 0.5;
        self.rightBallView.alpha = 0.5;
        
    } completion:^(BOOL finished) {
        UIColor *cr = self.leftBallView.backgroundColor;
        self.leftBallView.backgroundColor = self.middleBallView.backgroundColor;
        self.middleBallView.backgroundColor = cr;
        [UIView animateWithDuration:0.3 animations:^{
            self.leftBallView.alpha = 0.5;
            self.rightBallView.alpha = 0.5;
            
            self.leftBallView.centerX = self.leftBallView.centerX + self.ballSize*2;
            self.rightBallView.centerX = self.rightBallView.centerX - self.ballSize*2;
            
        } completion:^(BOOL finished) {
            UIView *vw = self.leftBallView;
            self.leftBallView = self.rightBallView;
            self.rightBallView = vw;
            
            if (!self.readyStop) {
                [self performAnimation];
            }
        }];
    }];
}

-(void)stopAnimation
{
    self.readyStop = YES;
    self.isAnimation = NO;
}

@end
















