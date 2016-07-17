//
//  ViewController.m
//  ClueTest
//
//  Created by David Lashkhi on 03/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "ViewController.h"
#import "ControlRotationRecognizer.h"
#import "CustomDatesTableViewController.h"


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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupControl {
    CGPoint centerPoint = CGPointMake(self.control.frame.origin.x + self.control.frame.size.width / 2,
                                      self.control.frame.origin.y + self.control.frame.size.height / 2);
    self.rotationRecognizer = [[ControlRotationRecognizer alloc] initWithControl:self.control centerPoint:centerPoint];
    self.rotationRecognizer.customDelegate = self;
    [self.view addGestureRecognizer:self.rotationRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [self setupControl];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (void)rotation:(CGFloat)angle
{
    self.imageAngle += angle;
    if (self.imageAngle > 360)
        self.imageAngle -= 360;
    else if (self.imageAngle < -360)
        self.imageAngle += 360;
    
    self.control.transform = CGAffineTransformMakeRotation(self.imageAngle *  M_PI / 180);

    NSLog(@"Image angle : %f", self.imageAngle);
    [self updateDate];
}



- (void)updateDate {
    NSInteger date;
    if (self.imageAngle < 0) {
        date = self.imageAngle / 11.6 + 32;
    } else {
        date = self.imageAngle / 11.6 + 1;
    }
    [self.controlButton setTitle:[NSString stringWithFormat:@"%ld", (long)date] forState:UIControlStateNormal];
}
- (IBAction)controlButtonTapped:(id)sender {
    
}
- (IBAction)calendarButtonTapped:(id)sender {
}

@end
