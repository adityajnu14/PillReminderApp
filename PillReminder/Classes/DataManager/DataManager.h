//
//  DataManager.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pill.h"

@interface DataManager : NSObject

// method will fetch data from plist and return array of pill modal
+ (NSArray*) getAllPillModelData;

// method will save single pill data
+ (void) savePill:(Pill*) pill;

// method will update old pill data to new pill data
+ (void) updatePill:(Pill*)oldPill withNewPill:(Pill*)newPill;

@end
