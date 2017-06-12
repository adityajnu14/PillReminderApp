//
//  Pill.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
#import "Reminder.h"

@interface Pill : NSObject

@property (strong, nonatomic)  NSString* pillName;
@property (strong, nonatomic)  NSString* PillDose;
@property (strong, nonatomic)  NSString* pillImageName;

@property (strong, nonatomic) NSArray<Reminder*>* reminders;

- (instancetype) initPillWithDict:(NSDictionary*) dict;

- (NSMutableDictionary*) getPillDict;

@end
