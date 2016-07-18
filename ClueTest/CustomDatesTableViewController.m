//
//  CustomDatesTableViewController.m
//  ClueTest
//
//  Created by David Lashkhi on 17/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "CustomDatesTableViewController.h"
#import "Dates.h"

@implementation CustomDatesTableViewController

static NSString * const reuseIdentifier = @"DatesTableViewCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedDates.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    Dates *selectedDate = self.selectedDates[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"January %ld", [selectedDate.day integerValue]];
    return cell;
}

@end
