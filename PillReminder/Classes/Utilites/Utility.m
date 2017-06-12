//
//  Utility.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "Utility.h"

#define kPlistFileName  @"Pill.plist"


@implementation Utility

// method will return doucment directory address path
+ (NSString*) getDocumentDirectoryPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsPath = [paths objectAtIndex:0];
    return documentsPath;
}

// method will pop up on  view showing eror
+ (void) promptErrorMessage:(NSString*)message sender:(UIViewController*)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [sender presentViewController:alert animated:YES completion:nil];
}

// method will save image in document directory path with specified name
+ (void) saveImage:(UIImage*)image withName:(NSString*)imageName
{
    NSString* documentsDirectory = [Utility getDocumentDirectoryPath];
    NSString* imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:imagePath atomically:YES];
}

// method will return image from document directory 
+ (UIImage*) getImageWithNamed:(NSString*) imageName
{
    UIImage* image;
    if(imageName == nil)
        image = [UIImage imageNamed:@"Default.png"];
    else
    {
        NSString* documentDirectory = [Utility getDocumentDirectoryPath];
        NSString* imagePath = [NSString stringWithFormat:@"%@%@%@",documentDirectory,@"/",imageName];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}

@end
