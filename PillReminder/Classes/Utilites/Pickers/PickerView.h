//
//  PickerView.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIPickerView <UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray*        _pickerData;
    UITextField*    _textField;
}

@property (strong,nonatomic) void (^fetchIndexCompletionBlock)(NSInteger index);

-(instancetype)initWithData:(NSArray*)InputArray textField:(UITextField*)textField;

@end
