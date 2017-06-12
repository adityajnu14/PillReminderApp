//
//  ReminderTableCell.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder.h"

@interface ReminderTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* reminderTime;
@property (weak, nonatomic) IBOutlet UILabel* reminderDays;

- (void) setupCellAttributes:(Reminder*) reminder;

@end
