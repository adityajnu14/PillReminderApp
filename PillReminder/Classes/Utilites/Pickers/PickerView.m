//
//  PickerView.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "PickerView.h"

#define kPickerRowHieght 60
#define kPickerRowTextSize 25
#define kNumberOfSectionsInPickerView 1
#define KPickerViewToolbarHieght 44
#define kPickerViewToolbarWidth  414

#define kPickerViewFontname @"Arial"
#define kPickerViewFontSize 16.0

@implementation PickerView

#pragma mark - PickerView custom method
-(instancetype)initWithData:(NSArray*)InputArray textField:(UITextField*)textFieldToBeEdited
{
    self = [super init];
    if(self)
    {
        _textField = textFieldToBeEdited;
        _pickerData = InputArray;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return  self;
}

#pragma mark - PickerView Delegate and Data Sources
// method returns number of sections in picker view
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return kNumberOfSectionsInPickerView;
}

// method returns number of rows in pickerview
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// method dispalys the content of the selected picker view row content in the textField
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.fetchIndexCompletionBlock)
        self.fetchIndexCompletionBlock(row); // block retuens the selected row index
    [_textField setText:_pickerData[row]];
}

//method manages hieght of row in picker view
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kPickerRowHieght;
}

// method manages look for each row
- ( NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:kPickerViewFontname size:kPickerViewFontSize],
                               NSForegroundColorAttributeName : [UIColor whiteColor]
                               };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_pickerData[row] attributes: attrDict];
    return attrString;
}



@end
