//
//  Utility.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

+ (NSString*) getDocumentDirectoryPath;

+ (void) promptErrorMessage:(NSString*)message sender:(UIViewController*)sender;
+ (void) saveImage:(UIImage*)image withName:(NSString*)imageName;

+ (UIImage*) getImageWithNamed:(NSString*) imageName;

@end
