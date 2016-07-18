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
#import "CalendarDataManager.h"


@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *control;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (assign, nonatomic) CGFloat imageAngle;
@property (strong, nonatomic) ControlRotationRecognizer *rotationRecognizer;
@property (strong, nonatomic) CustomDatesTableViewController *customDatesTableViewController;
@property (strong, nonatomic) CalendarDataManager *calendarDataManager;
@property (strong, nonatomic) NSArray *datesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageAngle = 0;
    self.calendarDataManager = [CalendarDataManager new];
    self.datesArray = [self.calendarDataManager savedDates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupControl {
    if (!self.rotationRecognizer) {
        CGPoint centerPoint = CGPointMake(self.control.frame.origin.x + self.control.frame.size.width / 2,
                                          self.control.frame.origin.y + self.control.frame.size.height / 2);
        self.rotationRecognizer = [[ControlRotationRecognizer alloc] initWithControl:self.control centerPoint:centerPoint];
        self.rotationRecognizer.customDelegate = self;
        self.rotationRecognizer.delegate = self;
        [self.view addGestureRecognizer:self.rotationRecognizer];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self setupControl];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.customDatesTableViewController = [segue destinationViewController];
    self.customDatesTableViewController.selectedDates = self.datesArray;
}

- (void)rotation:(CGFloat)angle {
    self.imageAngle += angle;
    if (self.imageAngle > 360)
        self.imageAngle -= 360;
    else if (self.imageAngle < -360)
        self.imageAngle += 360;
    
    self.control.transform = CGAffineTransformMakeRotation(self.imageAngle *  M_PI / 180);
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
    [self updateButtonStateForDate:date];
}

- (void)updateButtonStateForDate:(NSInteger)date {
    for (Dates *customDate in self.datesArray) {
        if ([customDate.day integerValue] == date) {
            self.controlButton.enabled = NO;
            break;
        } else {
            self.controlButton.enabled = YES;
        }
    }
}

- (IBAction)controlButtonTapped:(id)sender {
    [self.calendarDataManager saveDate:[self.controlButton.titleLabel.text integerValue]];
    self.datesArray = [self.calendarDataManager savedDates];
    [self updateButtonStateForDate:[self.controlButton.titleLabel.text integerValue]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}


@end
