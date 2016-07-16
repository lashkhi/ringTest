//
//  ControlRotationRecognizer.h
//  ClueTest
//
//  Created by David Lashkhi on 10/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@protocol ControlRotationRecognizerDelegate

- (void)finalAngle:(CGFloat)angle;
- (void)rotation:(CGFloat) angle;


@end

@interface ControlRotationRecognizer : UIGestureRecognizer

@property (nonatomic, weak) id <ControlRotationRecognizerDelegate> customDelegate;

- (instancetype)initWithControl:(UIImageView *)control;

@end
