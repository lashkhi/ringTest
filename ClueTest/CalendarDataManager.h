//
//  CalendarDataManager.h
//  ClueTest
//
//  Created by David Lashkhi on 18/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dates.h"


@interface CalendarDataManager : NSObject

- (void)saveDate:(NSInteger)date;
- (NSArray *)savedDates;

@end
