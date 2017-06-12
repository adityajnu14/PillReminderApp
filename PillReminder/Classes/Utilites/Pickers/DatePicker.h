//
//  DatePicker.h
//  TaskManagement
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePicker : UIDatePicker

@property (strong,nonatomic) void (^getTime)(NSString* dateString);

-(DatePicker*) initWithDatePicker:(UITextField* )textFieldToEdit;

@end
