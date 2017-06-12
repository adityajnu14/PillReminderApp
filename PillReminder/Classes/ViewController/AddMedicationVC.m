//
//  AddMedicationVC.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "AddMedicationVC.h"
#import "AddReminderVC.h"

#import "Utility.h"
#import "DataManager.h"
#import "LocalNotification.h"

#import "Reminder.h"
#import "ReminderTableCell.h"

#import "NSString+PillReminder.h"

#define kReminderCellIdentifiers                @"ReminderCell"
#define kMedicationToReminderVCIdentifire       @"MedicationVToReminderVC"

#define kImageFileReferenceURL          @"UIImagePickerControllerReferenceURL"

#define kEmptyString  @""

@interface AddMedicationVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray<Reminder*>*    _remiderDataSource;
    NSMutableArray*               _toBeDeletedNotification;// will contain notification that has been modified
    NSMutableArray*               _allNotificationArray; // will contain list of notification when name of pill is change
    Pill*           _newPill;
    NSString*       _pillImageName;
    NSInteger       _selectedIndex;
    BOOL            _isNewReminder;
}
@end

@implementation AddMedicationVC

#pragma mark - Life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInitialValues];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.reminderTableView reloadData];
}

#pragma mark - Private method

- (BOOL) shouldSavePill
{
    if([[self.pillNameTextField.text trim] isEqualToString:kEmptyString] || [[self.pillDoseTextField.text trim] isEqualToString:kEmptyString] || _remiderDataSource.count == 0 || _pillImageName == nil)
            return NO;
    _newPill.pillName = self.pillNameTextField.text;
    _newPill.PillDose = self.pillDoseTextField.text;
    _newPill.reminders = _remiderDataSource;
    return YES;
}

- (void) setupInitialValues
{
    _remiderDataSource          = [[NSMutableArray alloc] init];
    _toBeDeletedNotification    = [[NSMutableArray alloc] init];
    _newPill           = [[Pill alloc] init];
    if(self.pill != nil)
    {
        self.pillNameTextField.text = self.pill.pillName;
        self.pillDoseTextField.text = self.pill.PillDose;
        self.pillImageView.image    = [Utility getImageWithNamed:self.pill.pillImageName];
        _pillImageName              = self.pill.pillImageName;
        _remiderDataSource          = [NSMutableArray arrayWithArray:self.pill.reminders];
        [self getAllListOfNotificationForCurrentPill];
    }
}

// method will add Add notification
- (void) addNotification
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    for(Reminder* aReminder in _remiderDataSource)
    {
        NSDate *date = [dateFormatter dateFromString:aReminder.time];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
        int repeatDayVaue = [self getDayValueForNSDateComponent:aReminder.repeatDays];
        if(repeatDayVaue < 7)
        {
            components.weekday = repeatDayVaue;
        }
        // creating unique identifiers
        NSString* identifier = [NSString stringWithFormat:@"%@%@",_newPill.pillName,aReminder.time];
        [LocalNotification scheduleLocalNotificationWithAlertTitle:_newPill.pillName Date:components Body:_newPill.PillDose Identifier:identifier];
    }
}

// method will remove previous notification which is now chagned
- (void) deletePriviousNotitification
{
    // name of the pill has not been changed
    if([self.pill.pillName isEqualToString:_newPill.pillName])
        [LocalNotification removeNotficationWithAlertTitle:_toBeDeletedNotification];
    else
        [LocalNotification removeNotficationWithAlertTitle:_allNotificationArray];
    
}

// will set all notification identifer in array
- (void) getAllListOfNotificationForCurrentPill
{
    _allNotificationArray = [[NSMutableArray alloc] init];
    for(Reminder* aReminder in _remiderDataSource)
    {
        NSString* identifier = [NSString stringWithFormat:@"%@%@",self.pill.pillName,aReminder.time];
        [_allNotificationArray addObject:identifier];
    }
}
- (int) getDayValueForNSDateComponent:(NSString*) day
{
    int dayValue;
    if([day isEqualToString:kSunday])
        dayValue = 1;
    else if([day isEqualToString:kMonday])
        dayValue = 2;
    else if([day isEqualToString:kTuesday])
        dayValue = 3;
    else if([day isEqualToString:kWednesday])
        dayValue = 4;
    else if([day isEqualToString:kThrusday])
        dayValue = 5;
    else if([day isEqualToString:kFriday])
        dayValue = 6;
    else if([day isEqualToString:kEveryday])
        dayValue = 7;
    return dayValue;
    
}

#pragma mark - IBActions
// method will execute when user tap on save button
- (IBAction)saveButtonAction:(id)sender
{
    
    if([self shouldSavePill])
    {
        _newPill.pillImageName = [_newPill.pillName stringByAppendingString:_pillImageName];
        [Utility saveImage:self.pillImageView.image withName:_newPill.pillImageName];
        if(self.pill == nil)
        {
            [DataManager savePill:_newPill];
        }
        else
        {
            [self deletePriviousNotitification];
            [DataManager updatePill:self.pill withNewPill:_newPill];
        }
        [self addNotification];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [Utility promptErrorMessage:NSLocalizedString(@"Please fill all details", nil)  sender:self];
}

// method will execute when user tap on cancel button
- (IBAction)cancelButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// method will show image picker
- (IBAction)addImageButtonAction:(id)sender
{
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

// method will execute when user clik to add new remider
- (IBAction)setReminderButtonAction:(id)sender
{
    _isNewReminder = YES;
    [self performSegueWithIdentifier:kMedicationToReminderVCIdentifire sender:nil];
}

// method will hide textfield input view on tap
- (IBAction)tapGestureAction:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _remiderDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReminderTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kReminderCellIdentifiers];
    if(cell == nil)
        cell = [[ReminderTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReminderCellIdentifiers];
    [cell setupCellAttributes:_remiderDataSource[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex  = indexPath.row;
    _isNewReminder  = NO;
    [self performSegueWithIdentifier:kMedicationToReminderVCIdentifire sender:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:kMedicationToReminderVCIdentifire])
    {
        AddReminderVC* destVC = [segue destinationViewController];
        if(_remiderDataSource.count > 0 && _isNewReminder == NO)
            destVC.reminder = _remiderDataSource[_selectedIndex];
        __weak typeof (self) weakSelf = self;
        destVC.CallBack = ^ (Reminder* newReminder, BOOL isUpdate)
        {
            if(isUpdate)
            {
                NSString* priviousNotification = [NSString stringWithFormat:@"%@%@",weakSelf.pill.pillName,_remiderDataSource[_selectedIndex].time];
                [_toBeDeletedNotification addObject:priviousNotification];
                [_remiderDataSource replaceObjectAtIndex:_selectedIndex withObject:newReminder];
            }
            else
                [_remiderDataSource addObject:newReminder];
        };
    }
}

#pragma mark - UIImagePicker delegate method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* chosenImage = info[UIImagePickerControllerEditedImage];
    self.pillImageView.image = chosenImage;
    NSURL* imagePath = [info objectForKey:kImageFileReferenceURL];
    _pillImageName   = [imagePath lastPathComponent];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
