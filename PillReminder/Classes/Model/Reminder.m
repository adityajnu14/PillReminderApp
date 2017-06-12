//
//  Reminder.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "Reminder.h"
#import "Define.h"

@implementation Reminder

- (instancetype) initReminderWithDict:(NSDictionary*) dict
{
    self = [super init];
    if(self)
    {
        self.time       = [dict objectForKey:kTime];
        self.repeatDays = [dict objectForKey:kRepeatDays];
    }
    return self;
}

@end
