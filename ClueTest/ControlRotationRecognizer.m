//
//  ControlRotationRecognizer.m
//  ClueTest
//
//  Created by David Lashkhi on 10/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "ControlRotationRecognizer.h"

@interface ControlRotationRecognizer ()
@property (nonatomic, assign) CGFloat outerR;
@property (nonatomic, assign) CGFloat innerR;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation ControlRotationRecognizer

- (instancetype)initWithControl:(UIImageView *)control {
    if (self = [super init]) {
        self.centerPoint = CGPointMake(control.frame.origin.x + control.frame.size.width / 2,
                                       control.frame.origin.y + control.frame.size.height / 2);
        self.outerR = (control.frame.size.width / 2)  + 5;
        self.innerR = 50;
    }
    return self;
}

- (CGFloat)distanceBetweenPoints:(CGPoint)point1 point2:(CGPoint)point2 {
    CGFloat dx = point1.x - point2.x;
    CGFloat dy = point1.y - point2.y;
    return sqrt(dx*dx + dy*dy);
}

- (CGFloat)angleBetweenLinesInDegrees:(CGPoint)beginLineA endPointLineA:(CGPoint)endLineA beginLineB:(CGPoint)beginLineB endPointLineB:(CGPoint)endLineB {
    CGFloat a = endLineA.x - beginLineA.x;
    CGFloat b = endLineA.y - beginLineA.y;
    CGFloat c = endLineB.x - beginLineB.x;
    CGFloat d = endLineB.y - beginLineB.y;
    
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
    
    // convert radiants to degrees
    return (atanA - atanB) * 180 / M_PI;
}


#pragma mark - UIGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([touches count] != 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) {
        return;
    }
    
    CGPoint nowPoint  = [[touches anyObject] locationInView: self.view];
    NSLog(@"%@", NSStringFromCGPoint(nowPoint));

    CGPoint prevPoint = [[touches anyObject] previousLocationInView: self.view];
    NSLog(@"%@", NSStringFromCGPoint(prevPoint));

    
    CGFloat distance = [self distanceBetweenPoints:self.centerPoint point2:nowPoint];
    if (self.innerR <= distance && distance <= self.outerR) {
        CGFloat angle = [self angleBetweenLinesInDegrees:self.centerPoint endPointLineA:prevPoint beginLineB:self.centerPoint endPointLineB:nowPoint];
        
        if (angle > 180)
        {
            angle -= 360;
        }
        else if (angle < -180)
        {
            angle += 360;
        }
        
        // sum up single steps
        self.angle += angle;
        
        // call delegate
        [self.customDelegate rotation:angle];
    }
    else {
        // finger moved outside the area
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStatePossible)
    {
        self.state = UIGestureRecognizerStateRecognized;
        [self.customDelegate finalAngle:self.angle];
    }
    else
    {
        self.state = UIGestureRecognizerStateFailed;
    }
    
    self.angle = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    self.state = UIGestureRecognizerStateFailed;
    self.angle = 0;
}


@end
