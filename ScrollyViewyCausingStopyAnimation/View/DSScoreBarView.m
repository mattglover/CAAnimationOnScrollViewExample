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

#pragma mark - Initialisers
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
    [self setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:1.0]];
    [self setupScoreBarLayer];
}

#pragma mark - Setup
- (void)setupScoreBarLayer {
    
    self.scoreBarLayer = [CALayer layer];
    [_scoreBarLayer setBounds:CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds))];
    [_scoreBarLayer setAnchorPoint:CGPointMake(0.0f, 0.5f)];
    [_scoreBarLayer setPosition:CGPointMake(0.0f, floorf(CGRectGetHeight(self.bounds)/2))];
    [_scoreBarLayer setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
 
    [self.layer addSublayer:_scoreBarLayer];
}

#pragma mark - Animate
- (void)fillBarWithDelay:(CFTimeInterval)delay {
    
    CABasicAnimation *animation = [self animationToExtendBoundsOfLayer:_scoreBarLayer];
    [animation setBeginTime:CACurrentMediaTime() + delay];
    [_scoreBarLayer addAnimation:animation forKey:@"fillBarAnimation"];
}

#pragma mark - Animation Helper
- (CABasicAnimation *)animationToExtendBoundsOfLayer:(CALayer *)layer {
    
    CGFloat fromValue = CGRectGetWidth(layer.bounds);
    CGFloat toValue   = CGRectGetWidth(self.bounds);
    
    CABasicAnimation *changeBoundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    [changeBoundsAnimation setFromValue:[NSNumber numberWithFloat:fromValue]];
    [changeBoundsAnimation setToValue:  [NSNumber numberWithFloat:toValue]];
    [changeBoundsAnimation setDuration:10.0];
    [changeBoundsAnimation setFillMode:kCAFillModeForwards];
    [changeBoundsAnimation setRemovedOnCompletion:NO];
    
    return changeBoundsAnimation;
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_scoreBarLayer removeAnimationForKey:@"fillBarAnimation"];
}

@end
