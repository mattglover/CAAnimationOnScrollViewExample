//
//  DSScoreBarView.m
//  ScrollyViewyCausingStopyAnimation
//
//  Created by Matt Glover on 28/11/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "DSScoreBarView.h"
#import <QuartzCore/QuartzCore.h>

@interface DSScoreBarView ()
@property (nonatomic, strong) CALayer *scoreBarLayer;
@end

@implementation DSScoreBarView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [self setupScoreBarLayer];
    }
    
    return self;
}

#pragma mark - Setup
- (void)setupScoreBarLayer {
    
    self.scoreBarLayer = [CALayer layer];
    [_scoreBarLayer setBounds:CGRectMake(0, 0, 40, CGRectGetHeight(self.bounds))];
    [_scoreBarLayer setAnchorPoint:CGPointMake(0.0f, 0.5f)];
    [_scoreBarLayer setPosition:CGPointMake(0.0f, floorf(CGRectGetHeight(self.bounds)/2))];
    [_scoreBarLayer setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
 
    [self.layer addSublayer:_scoreBarLayer];
}

#pragma mark - Animate
- (void)fillBar {
    
    CABasicAnimation *animation = [self animationToExtendBoundsOfLayer:self.scoreBarLayer];
    [self.scoreBarLayer addAnimation:animation forKey:nil];
}

#pragma mark - Animation Helper
- (CABasicAnimation *)animationToExtendBoundsOfLayer:(CALayer *)layer {
    
    CGFloat fromValue = CGRectGetWidth(layer.bounds);
    CGFloat toValue   = CGRectGetWidth(self.bounds);
    
    CABasicAnimation *changeBoundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    [changeBoundsAnimation setFromValue:[NSNumber numberWithFloat:fromValue]];
    [changeBoundsAnimation setToValue:  [NSNumber numberWithFloat:toValue]];
    [changeBoundsAnimation setDuration:10.0];
    [layer setBounds:self.bounds];
    
    return changeBoundsAnimation;
}

@end
