//
//  Pill.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "Pill.h"

@implementation Pill

- (instancetype) initPillWithDict:(NSDictionary*) dict
{
    self = [super init];
    if(self)
    {
        self.pillName       = [dict valueForKey:kPillName];
        self.PillDose       = [dict valueForKey:kPillDose];
        self.pillImageName  = [dict valueForKey:kPillImage];
        self.reminders      = [self getReminderArray:[dict valueForKey:kRemiders]];
    }
    return self;
}

// method will return pill dictionary
- (NSMutableDictionary*) getPillDict
{
    NSMutableDictionary* pillDict = [[NSMutableDictionary alloc] init];
    [pillDict setValue:self.pillName forKey:kPillName];
    [pillDict setValue:self.PillDose forKey:kPillDose];
    [pillDict setValue:self.pillImageName forKey:kPillImage];
    [pillDict setValue:[self getDictionaryArray:self.reminders] forKey:kRemiders];
    return pillDict;
}

- (NSMutableArray*) getDictionaryArray:(NSArray<Reminder*>*) reminderArray
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for(Reminder* reminder in reminderArray)
    {
        NSMutableDictionary* remDict = [[NSMutableDictionary alloc] init];
        [remDict setValue:reminder.time forKey:kTime];
        [remDict setValue:reminder.repeatDays forKey:kRepeatDays];
        [array addObject:remDict];
    }
    return array;
}

- (NSMutableArray*) getReminderArray:(NSArray*) dictArray
{
    NSMutableArray<Reminder*>* array = [[NSMutableArray alloc] init];
    for(NSDictionary* dict in dictArray)
    {
        Reminder* aReminder = [[Reminder alloc] initReminderWithDict:dict];
        [array addObject:aReminder];
    }
    return array;
    
}
@end
