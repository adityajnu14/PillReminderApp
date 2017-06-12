//
//  ReminderTableCell.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "ReminderTableCell.h"

@implementation ReminderTableCell

#pragma mark - Life cycle method
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Private method

// method will set cell attributes values
- (void) setupCellAttributes:(Reminder*) reminder
{
    self.reminderTime.text  = reminder.time;
    self.reminderDays .text      = reminder.repeatDays;
}

@end
