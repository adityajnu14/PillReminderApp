//
//  DataManager.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "DataManager.h"
#import "Utility.h"
#import "Define.h"

@implementation DataManager

// method will save pill data
+ (void) savePill:(Pill*) pill
{
    NSString* documentDirectory = [Utility getDocumentDirectoryPath];
    NSString* plistPath = [NSString stringWithFormat:@"%@%@%@",documentDirectory,@"/",kPillPlistName];
    NSMutableArray* dataFromPlist = [DataManager getAllPillDataFromPlist];
    
    NSDictionary* dataDict  = [pill getPillDict];
    [dataFromPlist addObject:dataDict];
    [dataFromPlist writeToFile:plistPath atomically:YES];
}

// method will fetch pill array form plist, after converting into modal it returns it
+ (NSArray*) getAllPillModelData
{
    NSMutableArray* dataFromPlist = [DataManager getAllPillDataFromPlist];
    NSMutableArray<Pill*>* allPillData = [NSMutableArray array];
    if(dataFromPlist.count > 0)
    {
        for(NSDictionary* dict in dataFromPlist)
        {
            Pill* aPill = [[Pill alloc] initPillWithDict:dict];
            [allPillData addObject:aPill];
        }
    }
    return allPillData;
}

// method will return all pill data from plist which is in dictionary form
+ (NSMutableArray*) getAllPillDataFromPlist
{
    NSString* documentDirectory = [Utility getDocumentDirectoryPath];
    NSString* plistPath = [NSString stringWithFormat:@"%@%@%@",documentDirectory,@"/",kPillPlistName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSMutableArray* dataFromPlist;
    if ([fileManager fileExistsAtPath:plistPath])
        dataFromPlist       = [NSMutableArray arrayWithContentsOfFile:plistPath];
    else
        dataFromPlist = [NSMutableArray array];
    return dataFromPlist;
}

// method will update old pill to new one
+ (void) updatePill:(Pill*)oldPill withNewPill:(Pill*)newPill
{
    NSDictionary* newPillDict = [newPill getPillDict];
    int indexOfOldPill = [DataManager getIndexOfPillData:oldPill];
    if(indexOfOldPill != -1)
    {
        NSString* documentDirectory = [Utility getDocumentDirectoryPath];
        NSString* plistPath = [NSString stringWithFormat:@"%@%@%@",documentDirectory,@"/",kPillPlistName];
        NSMutableArray* dataFromPlist = [DataManager getAllPillDataFromPlist];
        [dataFromPlist replaceObjectAtIndex:indexOfOldPill withObject:newPillDict];
        [dataFromPlist writeToFile:plistPath atomically:YES];
    }
    
}


// method will fetch old pill index which will help to update with new pill. It return -1 if not found
+ (int) getIndexOfPillData:(Pill*) pill
{
    NSDictionary* pillDict = [pill getPillDict];
    int index;
    NSArray* dataFromPlist = [DataManager getAllPillDataFromPlist];
    for(index = 0; index<dataFromPlist.count; index++)
    {
        if([pillDict isEqualToDictionary:dataFromPlist[index]])
            return index;
    }
    return -1;
}

@end
