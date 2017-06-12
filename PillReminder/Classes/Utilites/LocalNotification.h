//
//  LocalNotification.h
//  PillReminder
//
//  Created by Aditya Kumar on 19/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface LocalNotification : NSObject

+ (void) scheduleLocalNotificationWithAlertTitle:(NSString *)title Date:(NSDateComponents *)date Body:(NSString *)body Identifier:(NSString *)identifier;

+ (void) removeNotficationWithAlertTitle:(NSArray*) identifires;

+ (void) removeAllNotification;

@end
