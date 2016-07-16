//
//  ViewController.m
//  ClueTest
//
//  Created by David Lashkhi on 03/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "ViewController.h"
#import "ControlRotationRecognizer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *control;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (assign, nonatomic) CGFloat imageAngle;
@property (strong, nonatomic) ControlRotationRecognizer *rotationRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageAngle = 0;
    [self setupControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupControl {
    self.rotationRecognizer = [[ControlRotationRecognizer alloc] initWithControl:self.control];
    self.rotationRecognizer.customDelegate = self;
    [self.view addGestureRecognizer:self.rotationRecognizer];
}

- (void)rotation:(CGFloat)angle
{
    // calculate rotation angle
    self.imageAngle += angle;
    if (self.imageAngle > 360)
        self.imageAngle -= 360;
    else if (self.imageAngle < -360)
        self.imageAngle += 360;
    
    self.control.transform = CGAffineTransformMakeRotation(self.imageAngle *  M_PI / 180);
    NSLog([NSString stringWithFormat:@"%f", angle]);

    //[self updateTextDisplay];
}

- (void) finalAngle: (CGFloat) angle
{
    // circular gesture ended, update text field
    //[self updateTextDisplay];
}

@end
