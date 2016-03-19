//
//  MyTeamViewController.m
//  harbaughsim16
//
//  Created by Akshay Easwaran on 3/16/16.
//  Copyright © 2016 Akshay Easwaran. All rights reserved.
//

#import "MyTeamViewController.h"
#import "SettingsViewController.h"
#import "Team.h"
#import "League.h"
#import "HBSharedUtils.h"

#import "HexColors.h"

@interface HBTeamHistoryView : UIView
@property (weak, nonatomic) IBOutlet UILabel *teamRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamPrestigeLabel;
@end

@implementation HBTeamHistoryView
@end

@interface MyTeamViewController ()
{
    IBOutlet HBTeamHistoryView *teamHeaderView;
    Team *userTeam;
}
@end

@implementation MyTeamViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Team";
    userTeam = [HBSharedUtils getLeague].userTeam;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(openSettings)];
    [self setupTeamHeader];
    self.tableView.tableHeaderView = teamHeaderView;
    [self.view setBackgroundColor:[HBSharedUtils styleColor]];
}

-(void)setupTeamHeader {
    [teamHeaderView.teamRankLabel setText:userTeam.name];
    [teamHeaderView.teamRecordLabel setText:[NSString stringWithFormat:@"%lu: %ld-%ld",[HBSharedUtils getLeague].leagueHistory.count + 1 + 2015,(long)userTeam.wins,(long)userTeam.losses]];
    [teamHeaderView.teamPrestigeLabel setText:[NSString stringWithFormat:@"Prestige: %d",userTeam.teamPrestige]];
    [teamHeaderView setBackgroundColor:[HBSharedUtils styleColor]];
}

-(void)openSettings {
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]] animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    } else {
        return [super tableView:tableView heightForHeaderInSection:section];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"StratCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"StratCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSString *title = @"";
        if (indexPath.row == 0) {
            title = @"Offensive Strategy";
        } else {
            title = @"Defensive Strategy";
        }
        
        [cell.textLabel setText:title];
        [cell.detailTextLabel setText:@"None"]; //change later
        return cell;
        
    } else {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSString *title = @"";
        

        if (indexPath.row == 0) {
            title = @"Team History";
        } else if (indexPath.row == 1) {
            title = @"Conference History";
        } else {
            title = @"League History";
        }
        [cell.textLabel setText:title];
        
        return cell;
    }
    
    
}

@end
