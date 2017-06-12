//
//  AddReminderVC.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "AddReminderVC.h"
#import "Reminder.h"

#import "Utility.h"
#import "PickerView.h"
#import "DatePicker.h"
#import "Define.h"

#import "NSString+PillReminder.h"

#define kEmptyString    @""

@interface AddReminderVC ()
{
    NSArray*    _repeatDays;
    Reminder*   _newReminder;
}
@end

@implementation AddReminderVC

#pragma mark - Life Cycle method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInitialValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private method
// methos will set initial values and it add text to text field
- (void) setupInitialValues
{
    _newReminder   = [[Reminder alloc] init];
    _repeatDays = @[kSunday,kMonday,kTuesday,kWednesday,kThrusday,kFriday,kSaturday,kEveryday];
    
    if(self.reminder != nil)
    {
        self.reminderTimeTextField.text = self.reminder.time;
        self.repeatDaysTextField.text   = self.reminder.repeatDays;
        _newReminder.time = self.reminder.time;
        _newReminder.repeatDays = self.reminder.repeatDays;
    }
    [self setInputViewForTime];
    [self setInputViewForRepeatDays];
}

// method will set input view for repeat day text field
- (void) setInputViewForRepeatDays
{
    __weak typeof (self) weakSelf = self;
    
    PickerView* picker = [[PickerView alloc] initWithData:_repeatDays textField:self.repeatDaysTextField];
    self.repeatDaysTextField.inputView = picker;
    picker.fetchIndexCompletionBlock = ^(NSInteger index)
    {
        _newReminder.repeatDays              = _repeatDays[index];
        weakSelf.repeatDaysTextField.text = _repeatDays[index];
    };
    [self.repeatDaysTextField reloadInputViews];
}

// method will set input view for time text field
- (void) setInputViewForTime
{
    __weak typeof (self) weakSelf = self;
    
    DatePicker *date = [[DatePicker alloc]initWithDatePicker:self.reminderTimeTextField];
    self.reminderTimeTextField.inputView = date;
    date.getTime = ^ (NSString* time)
    {
        weakSelf.reminderTimeTextField.text = time;
        _newReminder.time  = time;
    };
}

// method will validate text fild to be not empty
- (BOOL) validateTextField
{
    if([[self.reminderTimeTextField.text trim]  isEqualToString:kEmptyString] || [[self.repeatDaysTextField.text  trim] isEqualToString:kEmptyString])
    {
        [Utility promptErrorMessage:NSLocalizedString(@"Plese select time and days", nil)  sender:self];
        return NO;
    }
    return YES;
}

#pragma mark - IBActions

// method will execute when user tap on cancel button
- (IBAction)cancelButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// method will execute on save button tap. here newly created reminder will be sent in call back
- (IBAction)saveButtonAction:(id)sender
{
    if(![self validateTextField])
        return;
    else
    {
        if(self.CallBack)
        {
            if(self.reminder == nil)
                self.CallBack(_newReminder,NO);
            else
                self.CallBack(_newReminder,YES);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

// method will execute when user tap any where on screen.
- (IBAction)tapGestureAction:(id)sender
{
    [self.view endEditing:YES];
}
@end
