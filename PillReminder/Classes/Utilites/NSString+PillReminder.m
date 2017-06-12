//
//  NSString+PillReminder.m
//  PillReminder
//
//  Created by Aditya Kumar on 19/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "NSString+PillReminder.h"

@implementation NSString (PillReminder)

//method trims white spaces from the end of the string and also checks if the string is empty
-(NSString* ) trim
{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

@end
