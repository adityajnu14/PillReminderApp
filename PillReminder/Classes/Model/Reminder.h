//
//  Reminder.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reminder : NSObject

@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSString* repeatDays;

- (instancetype) initReminderWithDict:(NSDictionary*) dict;

@end
