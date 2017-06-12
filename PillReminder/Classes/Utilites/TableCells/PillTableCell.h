//
//  PillTableCell.h
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pill.h"

@interface PillTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel* pillNameLabel;
@property (strong, nonatomic) IBOutlet UILabel* pillDateLabel;
@property (strong, nonatomic) IBOutlet UILabel* PillDoseLabel;
@property (strong, nonatomic) IBOutlet UIImageView* pillImageView;

- (void) setupCellAttributes:(Pill*) pill;

@end
