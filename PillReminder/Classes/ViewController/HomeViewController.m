//
//  HomeViewController.m
//  PillReminder
//
//  Created by Aditya Kumar on 18/05/17.
//  Copyright © 2017 mindfire. All rights reserved.
//

#import "HomeViewController.h"
#import "AddMedicationVC.h"
#import "DataManager.h"
#import "PillTableCell.h"

#import "Pill.h"

#define kPillTableCellIdentifiers  @"PillCell"
#define kHomeVCToAddMedicationVC   @"HomeVCToAddMedicationVC"

@interface HomeViewController ()
{
    NSArray*    _pillTableArray;
    NSInteger   _selectedIndex;
}
@end

@implementation HomeViewController

#pragma mark - Life Cycle method
- (void)viewDidLoad
{
    [super viewDidLoad];
    _pillTableArray = [[NSArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [self fetchPillData];
}

#pragma mark - Private method
// method will fetch data source array and populate it
- (void) fetchPillData
{
    _pillTableArray = [DataManager getAllPillModelData];
    [self.pillTableView reloadData];
}

#pragma mark - UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pillTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PillTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kPillTableCellIdentifiers];
    if(cell == nil)
        cell = [[PillTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPillTableCellIdentifiers];
    [cell setupCellAttributes:_pillTableArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex  = [indexPath row];
    [self performSegueWithIdentifier:kHomeVCToAddMedicationVC sender:nil];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if([segue.identifier isEqualToString:kHomeVCToAddMedicationVC])
   {
       AddMedicationVC* destVC = [segue destinationViewController];
       if(_pillTableArray.count > 0 )
           destVC.pill  = _pillTableArray[_selectedIndex];
   }
}



@end
