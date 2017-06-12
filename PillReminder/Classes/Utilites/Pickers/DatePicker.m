//
//  DatePicker.m
//  TaskManagement
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "DatePicker.h"

#define k24HoursTimeFormat @"HH:mm"

@implementation DatePicker
{
    UITextField* _textField;
}
// method gets instance of Date picker
- (DatePicker*) initWithDatePicker:(UITextField* )textFieldToEdit
{
    self = [super init];
    if(self)
    {
        _textField = textFieldToEdit;
        self.datePickerMode = UIDatePickerModeTime;// only time will be dispalyed in the Date picker
        self.backgroundColor = [UIColor darkGrayColor];
        [self setLocale:[NSLocale systemLocale]];
        [self addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void) datePickerValueChanged:(UIDatePicker*) selectedPicker
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:k24HoursTimeFormat];
    NSString* dateString = [outputFormatter stringFromDate:self.date];
    if(self.getTime)
        self.getTime(dateString);
}

@end
