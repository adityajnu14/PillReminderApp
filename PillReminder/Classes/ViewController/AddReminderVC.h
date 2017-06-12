//
//  AddReminderVC.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder.h"

@interface AddReminderVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *reminderTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatDaysTextField;

@property (strong, nonatomic) void (^CallBack)(Reminder* reminder, BOOL isUpdate);
@property (strong, nonatomic) Reminder* reminder;

- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)tapGestureAction:(id)sender;

@end
