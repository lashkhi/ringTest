//
//  CalendarDataManager.m
//  ClueTest
//
//  Created by David Lashkhi on 18/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "CalendarDataManager.h"
#import "AppDelegate.h"

@interface CalendarDataManager ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation CalendarDataManager

- (instancetype)init{
    if (self = [super init]) {
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [appDelegate managedObjectContext];
    }
    return self;
}


- (void)saveDate:(NSInteger)date {
    NSArray *customDateArray = [self executeRequestWithPredicate:[NSPredicate predicateWithFormat:@"day == %d", date]];
    Dates *customDate;
    if (customDateArray.count > 0) {
        customDate = customDateArray[0];
    }
    if (!customDate) {
        customDate = [NSEntityDescription insertNewObjectForEntityForName:@"Dates"
                                                    inManagedObjectContext:self.managedObjectContext];
    }
    customDate.day = @(date);
    [self saveContext];
}

- (NSArray *)savedDates {
    return [self executeRequestWithPredicate:nil];
}

- (NSArray *)executeRequestWithPredicate:(NSPredicate *)predicate {
    NSString *entity = @"Dates";
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    if (predicate)
        [fetch setPredicate:predicate];
    [fetch setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext]];
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetch error:nil];
    return result;
}
- (void)saveContext {
    NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

}



     
     

@end
