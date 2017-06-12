//
//  AddMedicationVC.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pill.h"

@interface AddMedicationVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField* pillNameTextField;
@property (weak, nonatomic) IBOutlet UITextField* pillDoseTextField;
@property (weak, nonatomic) IBOutlet UIImageView* pillImageView;
@property (weak, nonatomic) IBOutlet UITableView* reminderTableView;

@property (strong, nonatomic) Pill* pill;

- (IBAction)saveButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)addImageButtonAction:(id)sender;
- (IBAction)setReminderButtonAction:(id)sender;

@end
