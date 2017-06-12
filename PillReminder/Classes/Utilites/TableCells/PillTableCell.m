//
//  PillTableCell.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "PillTableCell.h"
#import "Utility.h"

@implementation PillTableCell

#pragma mark- life cycle method
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Private method

// method will set values in table cell attributes
- (void) setupCellAttributes:(Pill*) pill
{
    self.pillNameLabel.text     = pill.pillName;
    self.pillDateLabel.text     = [[pill.reminders firstObject] time];
    self.PillDoseLabel.text     = pill.PillDose;
    self.pillImageView.image    = [Utility getImageWithNamed:pill.pillImageName];
}

@end
