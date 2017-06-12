//
//  LocalNotification.m
//  PillReminder
//
//  Created by Aditya Kumar on 19/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "LocalNotification.h"

static UNUserNotificationCenter *sCenter;
static UNAuthorizationOptions sOption;

@implementation LocalNotification

// method will initilize UNUserNotificationCenter and ask for prmission
+ (void)initializeNotificationManager
{
    sCenter = [UNUserNotificationCenter currentNotificationCenter];
    sOption = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
    [sCenter  requestAuthorizationWithOptions:sOption completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(!granted)
            NSLog(@"Denied by user");
    }];
}

// method will create a notification with identifier
+ (void) scheduleLocalNotificationWithAlertTitle:(NSString *)title Date:(NSDateComponents *)date Body:(NSString *)body Identifier:(NSString *)identifier
{
    if(sCenter == nil)
        [LocalNotification initializeNotificationManager];
    
    UNMutableNotificationContent* content = [UNMutableNotificationContent new];
    content.title = title;
    content.body  = body;
    content.sound = [UNNotificationSound defaultSound];

    UNNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:date repeats:YES];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [sCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"Error");
            return;
        }
        NSLog(@"Notification Added successfully");
    }];
    
}

// methos will remove notification with given identifiers
+ (void) removeNotficationWithAlertTitle:(NSArray*) identifires
{
    [sCenter removePendingNotificationRequestsWithIdentifiers:identifires];
}

+ (void) removeAllNotification
{
    [sCenter removeAllPendingNotificationRequests];
}

@end
