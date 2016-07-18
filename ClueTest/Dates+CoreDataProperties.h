//
//  Dates+CoreDataProperties.h
//  ClueTest
//
//  Created by David Lashkhi on 18/07/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dates.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dates (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *day;

@end

NS_ASSUME_NONNULL_END
