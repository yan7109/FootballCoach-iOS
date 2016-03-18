//
//  League.m
//  harbaughsim16
//
//  Created by Akshay Easwaran on 3/16/16.
//  Copyright © 2016 Akshay Easwaran. All rights reserved.
//

#import "League.h"
#import "Player.h"
#import "Conference.h"
#import "Game.h"
#import "Team.h"

#import "PlayerQB.h"
#import "PlayerRB.h"
#import "PlayerWR.h"
#import "PlayerK.h"
#import "PlayerOL.h"
#import "PlayerF7.h"
#import "PlayerCB.h"
#import "PlayerS.h"

@implementation League

+(NSArray*)bowlGameTitles {
    return @[@"Lilac Bowl", @"Apple Bowl", @"Salty Bowl", @"Salsa Bowl", @"Mango Bowl",@"Patriot Bowl", @"Salad Bowl", @"Frost Bowl", @"Tropical Bowl", @"Music Bowl"];
}

+(instancetype)newLeagueFromCSV:(NSString*)namesCSV {
    return [[League alloc] initFromCSV:namesCSV];
}

+(instancetype)newLeagueFromSaveFile:(NSData*)saveFileData names:(NSString*)namesCSV {
    return [[League alloc] initWithSaveFile:saveFileData names:namesCSV];
}

-(instancetype)initFromCSV:(NSString*)namesCSV {
    self = [super init];
    if (self){
        heismanDecided = NO;
        _hasScheduledBowls = NO;
        _leagueHistory = [NSMutableArray array];
        _heismanHistory = [NSMutableArray array];
        _currentWeek = 0;
        _bowlGames = [NSMutableArray array];
        _conferences = [NSMutableArray array];
        [_conferences addObject:[Conference newConferenceWithName:@"SOUTH" league:self]];
        [_conferences addObject:[Conference newConferenceWithName:@"LAKES" league:self]];
        [_conferences addObject:[Conference newConferenceWithName:@"NORTH" league:self]];
        [_conferences addObject:[Conference newConferenceWithName:@"COWBY" league:self]];
        [_conferences addObject:[Conference newConferenceWithName:@"PACIF" league:self]];
        [_conferences addObject:[Conference newConferenceWithName:@"MOUNT" league:self]];
        
        _newsStories = [NSMutableArray array];
        for (int i = 0; i < 16; i++) {
            [_newsStories addObject:[NSMutableArray array]];
        }
        
        NSMutableArray *first = _newsStories[0];
        [first addObject:@"New Season!\nReady for the new season, coach? Whether the National Championship is on your mind, or just a winning season, good luck!"];
        
        _nameList = [NSMutableArray array];
        NSArray *namesSplit = [namesCSV componentsSeparatedByString:@","];
        for (NSString *n in namesSplit) {
            [_nameList addObject:[n stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceCharacterSet]]];
        }
        
        Conference *south = _conferences[0];
        [south.confTeams addObject:[Team newTeamWithName:@"Alabama" abbreviation:@"ALA" conference:@"SOUTH" league:self prestige:95 rivalTeam:@"GEO"]]; //"Alabama", "ALA", "SOUTH", this, 95, "GEO" )
        [south.confTeams addObject:[Team newTeamWithName:@"Georgia" abbreviation:@"GEO" conference:@"SOUTH" league:self prestige:90 rivalTeam:@"ALA"]];//south.confTeams.add( new Team( "Georgia", "GEO", "SOUTH", this, 90, "ALA" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Florida" abbreviation:@"FLA" conference:@"SOUTH" league:self prestige:85 rivalTeam:@"TEN"]];//south.confTeams.add( new Team( "Florida", "FLA", "SOUTH", this, 85, "TEN" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Tennessee" abbreviation:@"TEN" conference:@"SOUTH" league:self prestige:80 rivalTeam:@"FLA"]];//south.confTeams.add( new Team( "Tennessee", "TEN", "SOUTH", this, 80, "FLA" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Atlanta" abbreviation:@"ATL" conference:@"SOUTH" league:self prestige:75 rivalTeam:@"KYW"]];//south.confTeams.add( new Team( "Atlanta", "ATL", "SOUTH", this, 75, "KYW" ));
        [south.confTeams addObject:[Team newTeamWithName:@"New Orleans" abbreviation:@"NOR" conference:@"SOUTH" league:self prestige:75 rivalTeam:@"LOU"]];//south.confTeams.add( new Team( "New Orleans", "NOR", "SOUTH", this, 75, "LOU" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Arkansas" abbreviation:@"ARK" conference:@"SOUTH" league:self prestige:70 rivalTeam:@"KTY"]];//south.confTeams.add( new Team( "Arkansas", "ARK", "SOUTH", this, 70, "KTY" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Louisiana" abbreviation:@"LOU" conference:@"SOUTH" league:self prestige:65 rivalTeam:@"NOR"]];//south.confTeams.add( new Team( "Louisiana", "LOU", "SOUTH", this, 65, "NOR" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Key West" abbreviation:@"KYW" conference:@"SOUTH" league:self prestige:65 rivalTeam:@"ATL"]];//south.confTeams.add( new Team( "Key West", "KYW", "SOUTH", this, 65, "ATL" ));
        [south.confTeams addObject:[Team newTeamWithName:@"Kentucky" abbreviation:@"KTY" conference:@"SOUTH" league:self prestige:50 rivalTeam:@"ARK"]];//south.confTeams.add( new Team( "Kentucky", "KTY", "SOUTH", this, 50, "ARK" ));
        
        
        Conference *lakes = _conferences[1];
        Conference *north = _conferences[2];
        Conference *cowboy = _conferences[3];
        Conference *pacific = _conferences[4];
        Conference *mountain = _conferences[5];
        
        /*
         
         
         
         //LAKES
         conferences.get(1).confTeams.add( new Team( "Ohio State", "OHI", "LAKES", this, 90, "MIC" ));
         conferences.get(1).confTeams.add( new Team( "Michigan", "MIC", "LAKES", this, 90, "OHI" ));
         conferences.get(1).confTeams.add( new Team( "Michigan St", "MSU", "LAKES", this, 80, "MIN" ));
         conferences.get(1).confTeams.add( new Team( "Wisconsin", "WIS", "LAKES", this, 70, "IND" ));
         conferences.get(1).confTeams.add( new Team( "Minnesota", "MIN", "LAKES", this, 70, "MSU" ));
         conferences.get(1).confTeams.add( new Team( "Univ of Chicago", "CHI", "LAKES", this, 70, "DET" ));
         conferences.get(1).confTeams.add( new Team( "Detroit St", "DET", "LAKES", this, 65, "CHI" ));
         conferences.get(1).confTeams.add( new Team( "Indiana", "IND", "LAKES", this, 65, "WIS" ));
         conferences.get(1).confTeams.add( new Team( "Cleveland St", "CLE", "LAKES", this, 55, "MIL" ));
         conferences.get(1).confTeams.add( new Team( "Milwaukee", "MIL", "LAKES", this, 45, "CLE" ));
         
         //NORTH
         conferences.get(2).confTeams.add( new Team( "New York St", "NYS", "NORTH", this, 90, "NYC" ));
         conferences.get(2).confTeams.add( new Team( "New Jersey", "NWJ", "NORTH", this, 85, "PEN" ));
         conferences.get(2).confTeams.add( new Team( "New York City", "NYC", "NORTH", this, 75, "NYS" ));
         conferences.get(2).confTeams.add( new Team( "Pennsylvania", "PEN", "NORTH", this, 75, "NWJ" ));
         conferences.get(2).confTeams.add( new Team( "Maryland", "MAR", "NORTH", this, 70, "WDC" ));
         conferences.get(2).confTeams.add( new Team( "Washington DC", "WDC", "NORTH", this, 70, "MAR" ));
         conferences.get(2).confTeams.add( new Team( "Boston St", "BOS", "NORTH", this, 65, "VER" ));
         conferences.get(2).confTeams.add( new Team( "Pittsburgh", "PIT", "NORTH", this, 60, "MAI" ));
         conferences.get(2).confTeams.add( new Team( "Maine", "MAI", "NORTH", this, 50, "PIT" ));
         conferences.get(2).confTeams.add( new Team( "Vermont", "VER", "NORTH", this, 45, "BOS" ));
         
         //COWBY
         conferences.get(3).confTeams.add( new Team( "Oklahoma", "OKL", "COWBY", this, 90, "TEX" ));
         conferences.get(3).confTeams.add( new Team( "Texas", "TEX", "COWBY", this, 90, "OKL" ));
         conferences.get(3).confTeams.add( new Team( "Houston", "HOU", "COWBY", this, 80, "DAL" ));
         conferences.get(3).confTeams.add( new Team( "Dallas", "DAL", "COWBY", this, 80, "HOU" ));
         conferences.get(3).confTeams.add( new Team( "Alamo St", "AMO", "COWBY", this, 70, "PAS" ));
         conferences.get(3).confTeams.add( new Team( "Oklahoma St", "OKS", "COWBY", this, 70, "TUL" ));
         conferences.get(3).confTeams.add( new Team( "El Paso St", "PAS", "COWBY", this, 60, "AMO" ));
         conferences.get(3).confTeams.add( new Team( "Texas St", "TXS", "COWBY", this, 60, "AUS" ));
         conferences.get(3).confTeams.add( new Team( "Tulsa", "TUL", "COWBY", this, 55, "OKS" ));
         conferences.get(3).confTeams.add( new Team( "Univ of Austin", "AUS", "COWBY", this, 50, "TXS" ));
         
         //PACIF
         conferences.get(4).confTeams.add( new Team( "California", "CAL", "PACIF", this, 90, "ULA" ));
         conferences.get(4).confTeams.add( new Team( "Oregon", "ORE", "PACIF", this, 85, "WAS" ));
         conferences.get(4).confTeams.add( new Team( "Los Angeles", "ULA", "PACIF", this, 80, "CAL" ));
         conferences.get(4).confTeams.add( new Team( "Oakland St", "OAK", "PACIF", this, 75, "HOL" ));
         conferences.get(4).confTeams.add( new Team( "Washington", "WAS", "PACIF", this, 75, "ORE" ));
         conferences.get(4).confTeams.add( new Team( "Hawaii", "HAW", "PACIF", this, 70, "SAM" ));
         conferences.get(4).confTeams.add( new Team( "Seattle", "SEA", "PACIF", this, 70, "SAN" ));
         conferences.get(4).confTeams.add( new Team( "Hollywood St", "HOL", "PACIF", this, 70, "OAK" ));
         conferences.get(4).confTeams.add( new Team( "San Diego St", "SAN", "PACIF", this, 60, "SEA" ));
         conferences.get(4).confTeams.add( new Team( "American Samoa", "SAM", "PACIF", this, 25, "HAW" ));
         
         //MOUNT
         conferences.get(5).confTeams.add( new Team( "Colorado", "COL", "MOUNT", this, 80, "DEN" ));
         conferences.get(5).confTeams.add( new Team( "Yellowstone St", "YEL", "MOUNT", this, 75, "ALB" ));
         conferences.get(5).confTeams.add( new Team( "Utah", "UTA", "MOUNT", this, 75, "SAL" ));
         conferences.get(5).confTeams.add( new Team( "Univ of Denver", "DEN", "MOUNT", this, 75, "COL" ));
         conferences.get(5).confTeams.add( new Team( "Albuquerque", "ALB", "MOUNT", this, 70, "YEL" ));
         conferences.get(5).confTeams.add( new Team( "Salt Lake St", "SAL", "MOUNT", this, 65, "UTA" ));
         conferences.get(5).confTeams.add( new Team( "Wyoming", "WYO", "MOUNT", this, 60, "MON" ));
         conferences.get(5).confTeams.add( new Team( "Montana", "MON", "MOUNT", this, 55, "WYO" ));
         conferences.get(5).confTeams.add( new Team( "Las Vegas", "LSV", "MOUNT", this, 50, "PHO" ));
         conferences.get(5).confTeams.add( new Team( "Phoenix", "PHO", "MOUNT", this, 45, "LSV" ));
         
         */
        
        
        _teamList = [NSMutableArray array];
        for (int i = 0; i < _conferences.count; ++i ) {
            for (int j = 0; j < [[_conferences[i] confTeams] count]; j++ ) {
                [_teamList addObject:[_conferences[i] confTeams][j]];
            }
        }
        
        //set up schedule
        for (int i = 0; i < _conferences.count; ++i ) {
            [_conferences[i] setUpSchedule];
        }
        for (int i = 0; i < _conferences.count; ++i ) {
            [_conferences[i] setUpOOCSchedule ];
        }
        for (int i = 0; i < _conferences.count; ++i ) {
            [_conferences[i] insertOOCSchedule];
        }
    }
    return self;
}

-(instancetype)initWithSaveFile:(NSData*)saveFileData names:(NSString*)nameCSV {
    self = [super init];
    if (self) {
        heismanDecided = NO;
        _hasScheduledBowls = NO;
        //NSString *line = nil;
        _currentWeek = 0;
        
        /*
        try {
            // Always wrap FileReader in BufferedReader.
            BufferedReader bufferedReader = new BufferedReader( new FileReader(saveFile) );
            
            //First ignore the save file info
            bufferedReader.readLine();
            
            //Next get league history
            leagueHistory = new ArrayList<String[]>();
            while((line = bufferedReader.readLine()) != null && !line.equals("END_LEAGUE_HIST")) {
                leagueHistory.add(line.split("%"));
            }
            
            //Next get heismans
            heismanHistory = new ArrayList<String>();
            while((line = bufferedReader.readLine()) != null && !line.equals("END_HEISMAN_HIST")) {
                heismanHistory.add(line);
            }
            
            //Next make all the teams
            conferences = new ArrayList<Conference>();
            teamList = new ArrayList<Team>();
            conferences.add( new Conference("SOUTH", this) );
            conferences.add( new Conference("LAKES", this) );
            conferences.add( new Conference("NORTH", this) );
            conferences.add( new Conference("COWBY", this) );
            conferences.add( new Conference("PACIF", this) );
            conferences.add( new Conference("MOUNT", this) );
            String[] splits;
            for(int i = 0; i < 60; ++i) { //Do for every team (60)
                StringBuilder sbTeam = new StringBuilder();
                while((line = bufferedReader.readLine()) != null && !line.equals("END_PLAYERS")) {
                    sbTeam.append(line);
                }
                Team t = new Team(sbTeam.toString(), this);
                conferences.get( getConfNumber(t.conference) ).confTeams.add(t);
                teamList.add(t);
            }
            
            //Set up user team
            if ((line = bufferedReader.readLine()) != null) {
                for (Team t : teamList) {
                    if (t.name.equals(line)) {
                        userTeam = t;
                        userTeam.userControlled = true;
                    }
                }
            }
            while((line = bufferedReader.readLine()) != null && !line.equals("END_USER_TEAM")) {
                userTeam.teamHistory.add(line);
            }
            
            // Always close files.
            bufferedReader.close();
            
            //read names from file
            nameList = new ArrayList<String>();
            String[] namesSplit = namesCSV.split(",");
            for (String n : namesSplit) {
                nameList.add(n.trim());
            }
            
            //set up schedule
            for (int i = 0; i < conferences.size(); ++i ) {
                conferences.get(i).setUpSchedule();
            }
            for (int i = 0; i < conferences.size(); ++i ) {
                conferences.get(i).setUpOOCSchedule();
            }
            for (int i = 0; i < conferences.size(); ++i ) {
                conferences.get(i).insertOOCSchedule();
            }
            
            // Initialize new stories lists
            newsStories = new ArrayList< ArrayList<String> >();
            for (int i = 0; i < 16; ++i) {
                newsStories.add(new ArrayList<String>());
            }
            newsStories.get(0).add("New Season!>Ready for the new season, coach? Whether the National Championship is " +
                                   "on your mind, or just a winning season, good luck!");
            
        }
        catch(FileNotFoundException ex) {
            System.out.println(
                               "Unable to open file");
        }
        catch(IOException ex) {
            System.out.println(
                               "Error reading file");
        }
        */
        
    }
    return self;
}


-(NSInteger)getConfNumber:(NSString*)conf {
    if ([conf isEqualToString:@"SOUTH"]) return 0;
    if ([conf isEqualToString:@"LAKES"]) return 1;
    if ([conf isEqualToString:@"NORTH"]) return 2;
    if ([conf isEqualToString:@"COWBY"]) return 3;
    if ([conf isEqualToString:@"PACIF"]) return 4;
    if ([conf isEqualToString:@"MOUNT"]) return 5;
    return 0;
}

-(void)playWeek {
    if (_currentWeek <= 12 ) {
        for (int i = 0; i < _conferences.count; ++i) {
            [_conferences[i] playWeek];
        }
    }
    
    if (_currentWeek == 12 ) {
        //bowl week
        for (int i = 0; i < _teamList.count; ++i) {
            [_teamList[i] updatePollScore];
        }
        
        _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            Team *a = (Team*)obj1;
            Team *b = (Team*)obj2;
            return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
            
        }] copy];
        
        [self scheduleBowlGames];
    } else if (_currentWeek == 13 ) {
        heisman = [self getHeisman][0];
        [_heismanHistory addObject:[NSString stringWithFormat:@"%@ %@ [%@], %@ (%ld-%ld)",heisman.position,heisman.getInitialName,heisman.getYearString,heisman.team.abbreviation,(long)heisman.team.wins,(long)heisman.team.losses]];
        [self playBowlGames];
        
    } else if (_currentWeek == 14 ) {
        [_ncg playGame];
        if (_ncg.homeScore > _ncg.awayScore ) {
            _ncg.homeTeam.semifinalWL = @"";
            _ncg.awayTeam.semifinalWL = @"";
            _ncg.homeTeam.natlChampWL = @"NCW";
            _ncg.awayTeam.natlChampWL = @"NCL";
            _ncg.homeTeam.totalNCs++;
            NSMutableArray *week15 = _newsStories[15];
            [week15 addObject:[NSString stringWithFormat:@"%@ wins the National Championship\n%@ defeats %@ in the national championship game %ld to %ld. Congratulations %@!", _ncg.homeTeam.name, [_ncg.homeTeam strRep], [_ncg.awayTeam strRep], (long)_ncg.homeScore, (long)_ncg.awayScore, _ncg.homeTeam.name]];
            
        } else {
            _ncg.homeTeam.semifinalWL = @"";
            _ncg.awayTeam.semifinalWL = @"";
            _ncg.awayTeam.natlChampWL = @"NCW";
            _ncg.homeTeam.natlChampWL = @"NCL";
            _ncg.awayTeam.totalNCs++;
            NSMutableArray *week15 = _newsStories[15];
            [week15 addObject:[NSString stringWithFormat:@"%@ wins the National Championship\n%@ defeats %@ in the national championship game %ld to %ld. Congratulations %@!", _ncg.awayTeam.name, [_ncg.awayTeam strRep], [_ncg.homeTeam strRep], (long)_ncg.awayScore, (long)_ncg.homeScore, _ncg.awayTeam.name]];
        }
    }
    
    [self setTeamRanks];
    _currentWeek++;
}

-(void)scheduleBowlGames {
    //bowl week
    for (int i = 0; i < _teamList.count; ++i) {
        [_teamList[i] updatePollScore];
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
        
    }] copy];
    
    //semifinals
    _semiG14 = [Game newGameWithHome:_teamList[0] away:_teamList[3] name:@"Semis, 1v4"];
    [[_teamList[0] gameSchedule] addObject:_semiG14];
    [[_teamList[3] gameSchedule] addObject:_semiG14];
    
    _semiG23 = [Game newGameWithHome:_teamList[1] away:_teamList[2] name:@"Semis, 2v3"];
    [[_teamList[1] gameSchedule] addObject:_semiG23];
    [[_teamList[2] gameSchedule] addObject:_semiG23];
    
    //other bowl games
    /*_bowlGames[0] = new Game( teamList.get(4), teamList.get(6), bowlNames[0] );
    _teamList.get(4).gameSchedule.add(bowlGames[0]);
    _teamList.get(6).gameSchedule.add(bowlGames[0]);
    
    _bowlGames[1] = new Game( teamList.get(5), teamList.get(7), bowlNames[1] );
    _teamList.get(5).gameSchedule.add(bowlGames[1]);
    _teamList.get(7).gameSchedule.add(bowlGames[1]);
    
    _bowlGames[2] = new Game( teamList.get(8), teamList.get(14), bowlNames[2] );
    _teamList.get(8).gameSchedule.add(bowlGames[2]);
    _teamList.get(14).gameSchedule.add(bowlGames[2]);
    
    _bowlGames[3] = new Game( teamList.get(9), teamList.get(15), bowlNames[3] );
    _teamList.get(9).gameSchedule.add(bowlGames[3]);
    _teamList.get(15).gameSchedule.add(bowlGames[3]);
    
    _bowlGames[4] = new Game( teamList.get(10), teamList.get(11), bowlNames[4] );
    _teamList.get(10).gameSchedule.add(bowlGames[4]);
    _teamList.get(11).gameSchedule.add(bowlGames[4]);
    
    _bowlGames[5] = new Game( teamList.get(12), teamList.get(13), bowlNames[5] );
    _teamList.get(12).gameSchedule.add(bowlGames[5]);
    _teamList.get(13).gameSchedule.add(bowlGames[5]);
    
    _bowlGames[6] = new Game( teamList.get(16), teamList.get(20), bowlNames[6] );
    _teamList.get(16).gameSchedule.add(bowlGames[6]);
    _teamList.get(20).gameSchedule.add(bowlGames[6]);
    
    _bowlGames[7] = new Game( teamList.get(17), teamList.get(21), bowlNames[7] );
    _teamList.get(17).gameSchedule.add(bowlGames[7]);
    _teamList.get(21).gameSchedule.add(bowlGames[7]);
    
    _bowlGames[8] = new Game( teamList.get(18), teamList.get(22), bowlNames[8] );
    _teamList.get(18).gameSchedule.add(bowlGames[8]);
    _teamList.get(22).gameSchedule.add(bowlGames[8]);
    
    _bowlGames[9] = new Game( teamList.get(19), teamList.get(23), bowlNames[9] );
    _teamList.get(19).gameSchedule.add(bowlGames[9]);
    _teamList.get(23).gameSchedule.add(bowlGames[9]);*/
    
    if ([[self class] bowlGameTitles].count > _teamList.count) {
        for (int i = 0; i < 20; i+=2) {
            NSString *bowlName = [[self class] bowlGameTitles][i];
            Team *home = _teamList[i + 4];
            Team *away = _teamList[i + 5];
            Game *bowl = [Game newGameWithHome:home away:away name:bowlName];
            [_bowlGames addObject:bowl];
            [home.gameSchedule addObject:bowl];
            [away.gameSchedule addObject:bowl];
        }
    } else {
        for (int i = 0; i < [[self class] bowlGameTitles].count; i+=2) {
            NSString *bowlName = [[self class] bowlGameTitles][i];
            Team *home = _teamList[i + 4];
            Team *away = _teamList[i + 5];
            Game *bowl = [Game newGameWithHome:home away:away name:bowlName];
            [_bowlGames addObject:bowl];
            [home.gameSchedule addObject:bowl];
            [away.gameSchedule addObject:bowl];
        }
    }
    
    
    _hasScheduledBowls = true;
    
}

-(void)playBowlGames {
    for (Game *g in _bowlGames) {
        [self playBowl:g];
    }
    
    [_semiG14 playGame];
    [_semiG23 playGame];
    Team *semi14winner;
    Team *semi23winner;
    if (_semiG14.homeScore > _semiG14.awayScore ) {
        _semiG14.homeTeam.semifinalWL = @"SFW";
        _semiG14.awayTeam.semifinalWL = @"SFL";
        semi14winner = _semiG14.homeTeam;
        //_newsStories.get(14).add(semiG14.homeTeam.name + " wins the " + semiG14.gameName +"!\n" + semiG14.homeTeam.strRep() + " defeats " + semiG14.awayTeam.strRep() + " in the semifinals, winning " + semiG14.homeScore + " to " + semiG14.awayScore + ". " + semiG14.homeTeam.name + " advances to the National Championship!" );
        NSMutableArray *week14 = _newsStories[14];
        [week14 addObject:[NSString stringWithFormat:@"%@ wins the %@!\n%@ defeats %@ in the semifinals, winning %ld to %ld. %@ advances to the National Championship!",_semiG14.homeTeam.name, _semiG14.gameName, _semiG14.homeTeam.strRep, _semiG14.awayTeam.strRep, (long)_semiG14.homeScore, (long)_semiG14.awayScore, _semiG14.homeTeam.name]];
        
    } else {
        _semiG14.homeTeam.semifinalWL = @"SFL";
        _semiG14.awayTeam.semifinalWL = @"SFW";
        semi14winner = _semiG14.awayTeam;
        NSMutableArray *week14 = _newsStories[14];
        [week14 addObject:[NSString stringWithFormat:@"%@ wins the %@!\n%@ defeats %@ in the semifinals, winning %ld to %ld. %@ advances to the National Championship!",_semiG14.awayTeam.name, _semiG14.gameName, _semiG14.awayTeam.strRep, _semiG14.homeTeam.strRep, (long)_semiG14.awayScore, (long)_semiG14.homeScore, _semiG14.awayTeam.name]];
       
    }
    
    if (_semiG23.homeScore > _semiG23.awayScore ) {
        _semiG23.homeTeam.semifinalWL = @"SFW";
        _semiG23.awayTeam.semifinalWL = @"SFL";
        semi23winner = _semiG23.homeTeam;
        //_newsStories.get(14).add(semiG14.homeTeam.name + " wins the " + semiG14.gameName +"!\n" + semiG14.homeTeam.strRep() + " defeats " + semiG14.awayTeam.strRep() + " in the semifinals, winning " + semiG14.homeScore + " to " + semiG14.awayScore + ". " + semiG14.homeTeam.name + " advances to the National Championship!" );
        NSMutableArray *week14 = _newsStories[14];
        [week14 addObject:[NSString stringWithFormat:@"%@ wins the %@!\n%@ defeats %@ in the semifinals, winning %ld to %ld. %@ advances to the National Championship!",_semiG23.homeTeam.name, _semiG23.gameName, _semiG23.homeTeam.strRep, _semiG23.awayTeam.strRep, (long)_semiG23.homeScore, (long)_semiG23.awayScore, _semiG23.homeTeam.name]];
        
    } else {
        _semiG23.homeTeam.semifinalWL = @"SFL";
        _semiG23.awayTeam.semifinalWL = @"SFW";
        semi23winner = _semiG23.awayTeam;
        NSMutableArray *week14 = _newsStories[14];
        [week14 addObject:[NSString stringWithFormat:@"%@ wins the %@!\n%@ defeats %@ in the semifinals, winning %ld to %ld. %@ advances to the National Championship!",_semiG23.awayTeam.name, _semiG23.gameName, _semiG23.awayTeam.strRep, _semiG23.homeTeam.strRep, (long)_semiG23.awayScore, (long)_semiG23.homeScore, _semiG23.awayTeam.name]];
        
    }
    
    //schedule NCG
    _ncg = [Game newGameWithHome:semi14winner away:semi23winner name:@"NCG"];
    [semi14winner.gameSchedule addObject:_ncg];
    [semi23winner.gameSchedule addObject:_ncg];
    
}

-(void)playBowl:(Game*)g {
    [g playGame];
    if (g.homeScore > g.awayScore ) {
        g.homeTeam.semifinalWL = @"BW";
        g.awayTeam.semifinalWL = @"BL";
        //newsStories.get(14).add( g.homeTeam.name + " wins the " + g.gameName +"!>" + g.homeTeam.strRep() + " defeats " + g.awayTeam.strRep() + " in the " + g.gameName + ", winning " + g.homeScore + " to " + g.awayScore + "." );
        NSMutableArray *week14 = _newsStories[14];
        [week14 addObject:[NSString stringWithFormat:@"%@ wins the %@!\n%@ defeats %@ in the %@, winning %ld to %ld.",g.homeTeam, g.gameName, g.homeTeam.strRep, g.awayTeam.strRep, g.gameName, g.homeScore, g.awayScore]];
    } else {
        g.homeTeam.semifinalWL = @"BL";
        g.awayTeam.semifinalWL = @"BW";
        NSMutableArray *week14 = _newsStories[14];
        [week14 addObject:[NSString stringWithFormat:@"%@ wins the %@!\n%@ defeats %@ in the %@, winning %ld to %ld.",g.awayTeam, g.gameName, g.awayTeam.strRep, g.homeTeam.strRep, g.gameName, g.awayScore, g.homeScore]];
    }
}

-(void)updateLeagueHistory {
    //update league history
    for (int i = 0; i < _teamList.count; ++i) {
        [_teamList[i] updatePollScore];
    }
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
        
    }] copy];
    NSMutableArray *yearTop10 = [NSMutableArray array];
    Team *tt;
    for (int i = 0; i < 10; ++i) {
        tt = _teamList[i];
        [yearTop10  addObject:[NSString stringWithFormat:@"%@ (%ld-%ld)",tt.abbreviation, (long)tt.wins, (long)tt.losses]];
    }
    [_leagueHistory addObject:yearTop10];
}

-(void)advanceSeason {
    _currentWeek = 0;
    //updateTeamHistories();
    for (int t = 0; t < _teamList.count; ++t) {
        [_teamList[t] advanceSeason];
    }
    for (int c = 0; c < _conferences.count; ++c) {
        _conferences[c].robinWeek = 0;
        _conferences[c].week = 0;
    }
    //set up schedule
    for (int i = 0; i < _conferences.count; ++i ) {
        [_conferences[i] setUpSchedule];
    }
    for (int i = 0; i < _conferences.count; ++i ) {
        [_conferences[i] setUpOOCSchedule];
    }
    for (int i = 0; i < _conferences.count; ++i ) {
        [_conferences[i] insertOOCSchedule];
    }
    
    _hasScheduledBowls = false;
}

-(void)updateTeamHistories {
    for (int i = 0; i < _teamList.count; ++i) {
        [_teamList[i] updateTeamHistory];
    }
}

-(void)updateTeamTalentRatings {
    for (Team *t in _teamList) {
        [t updateTalentRatings];
    }
}

-(NSString*)getRandName {
    int fn = (int)(arc4random()*_nameList.count);
    int ln = (int)(arc4random()*_nameList.count);
    return [NSString stringWithFormat:@"%@ %@",_nameList[fn],_nameList[ln]];
}


-(NSArray<Player*>*)getHeisman {
    heisman = nil;
    NSInteger heismanScore = 0;
    NSInteger tempScore = 0;
    heismanCandidates = [NSMutableArray array];
    for ( int i = 0; i < _teamList.count; ++i ) {
        //qb
        [heismanCandidates addObject:_teamList[i].teamQBs[0]];
        tempScore = [_teamList[i].teamQBs[0] getHeismanScore] + _teamList[i].wins*100;
        if ( tempScore > heismanScore ) {
            heisman = _teamList[i].teamQBs[0];
            heismanScore = tempScore;
        }
        
        //rb
        for (int rb = 0; rb < 2; ++rb) {
            [heismanCandidates addObject:_teamList[i].teamRBs[rb]];
            tempScore = [_teamList[i].teamRBs[rb] getHeismanScore] + _teamList[i].wins*100;
            if ( tempScore > heismanScore ) {
                heisman = _teamList[i].teamRBs[rb];
                heismanScore = tempScore;
            }
        }
        
        //wr
        for (int wr = 0; wr < 3; ++wr) {
            [heismanCandidates addObject:_teamList[i].teamWRs[wr]];
            tempScore = [_teamList[i].teamWRs[wr] getHeismanScore] + _teamList[i].wins*100;
            if ( tempScore > heismanScore ) {
                heisman = _teamList[i].teamWRs[wr];
                heismanScore = tempScore;
            }
        }
    }
    
    heismanCandidates = [[heismanCandidates sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Player *a = (Player*)obj1;
        Player *b = (Player*)obj2;
        return [a getHeismanScore] > [b getHeismanScore] ? -1 : [a getHeismanScore] == [b getHeismanScore] ? 0 : 1;
        
    }] mutableCopy];
    
    return heismanCandidates;
}

-(NSString*)getTop5HeismanStr {
    if (heismanDecided) {
        return [self getHeismanCeremonyStr];
    } else {
        heismanCandidates = [[self getHeisman] mutableCopy];
        //full results string
        NSString *heismanTop5 = @"";
        for (int i = 0; i < 5; ++i) {
            Player *p = heismanCandidates[i];
            heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@"%d. %@ (%ld-%ld) - ",(i+1),p.team.abbreviation,(long)p.team.wins,(long)p.team.losses]];
            if ([p isKindOfClass:[PlayerQB class]]) {
                PlayerQB *pqb = (PlayerQB*)p;
                heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@" QB %@: %ld votes\n\t(%ld TDs, %ld Int, %ld Yds)\n",[pqb getInitialName],(long)[pqb getHeismanScore],(long)pqb.statsTD,(long)pqb.statsInt,(long)pqb.statsPassYards]];
            } else if ([p isKindOfClass:[PlayerRB class]]) {
                PlayerRB *prb = (PlayerRB*)p;
                heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@" RB %@: %ld votes\n\t(%ld TDs, %ld Fum, %ld Yds)\n",[prb getInitialName],(long)[prb getHeismanScore],(long)prb.statsTD,(long)prb.statsFumbles,(long)prb.statsRushYards]];
            } else if ([p isKindOfClass:[PlayerWR class]]) {
                PlayerWR *pwr = (PlayerWR*)p;
                heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@" WR %@: %ld votes\n\t(%ld TDs, %ld Fum, %ld Yds)\n",[pwr getInitialName],(long)[pwr getHeismanScore],(long)pwr.statsTD,(long)pwr.statsFumbles,(long)pwr.statsRecYards]];
            }
        }
        return heismanTop5;
    }
}

-(NSString*)getHeismanCeremonyStr {
    BOOL putNewsStory = false;
    if (!heismanDecided) {
        heismanDecided = true;
        heismanCandidates = [[self getHeisman] mutableCopy];
        heisman = heismanCandidates[0];
        putNewsStory = true;
    
        NSString* heismanTop5 = @"\n";
        NSMutableString* heismanStats = [NSMutableString string];
        NSString* heismanWinnerStr = @"";
        
        //full results string
        
        for (int i = 0; i < 5; ++i) {
            Player *p = heismanCandidates[i];
            heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@"%d. %@ (%ld-%ld) - ",(i+1),p.team.abbreviation,(long)p.team.wins,(long)p.team.losses]];
            if ([p isKindOfClass:[PlayerQB class]]) {
                PlayerQB *pqb = (PlayerQB*)p;
                heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@" QB %@: %ld votes\n\t(%ld TDs, %ld Int, %ld Yds)\n",[pqb getInitialName],(long)[pqb getHeismanScore],(long)pqb.statsTD,(long)pqb.statsInt,(long)pqb.statsPassYards]];
            } else if ([p isKindOfClass:[PlayerRB class]]) {
                PlayerRB *prb = (PlayerRB*)p;
                heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@" RB %@: %ld votes\n\t(%ld TDs, %ld Fum, %ld Yds)\n",[prb getInitialName],(long)[prb getHeismanScore],(long)prb.statsTD,(long)prb.statsFumbles,(long)prb.statsRushYards]];
            } else if ([p isKindOfClass:[PlayerWR class]]) {
                PlayerWR *pwr = (PlayerWR*)p;
                heismanTop5 = [heismanTop5 stringByAppendingString:[NSString stringWithFormat:@" WR %@: %ld votes\n\t(%ld TDs, %ld Fum, %ld Yds)\n",[pwr getInitialName],(long)[pwr getHeismanScore],(long)pwr.statsTD,(long)pwr.statsFumbles,(long)pwr.statsRecYards]];
            }
        }
        
        if ([heisman isKindOfClass:[PlayerQB class]]) {
            //qb heisman
            PlayerQB *heisQB = (PlayerQB*) heisman;
            heismanWinnerStr = [NSString stringWithFormat:@"Congratulations to the Player of the Year, %@ QB %@ [%@], who had %ld TDs, just %ld interceptions, and %ld passing yards. He led %@ to a %ld-%ld record and a #%ld poll ranking.",heisQB.team.abbreviation, heisQB.name, [heisman getYearString], (long)heisQB.statsTD, (long)heisQB.statsInt, (long)heisQB.statsPassYards, heisQB.team.name, (long)heisQB.team.wins,(long)heisQB.team.losses,(long)heisQB.team.rankTeamPollScore];

            [heismanStats appendString:[NSString stringWithFormat:@"%@\n\nFull Results: %@",heismanWinnerStr, heismanTop5]];
        } else if ([heisman isKindOfClass:[PlayerRB class]]) {
            //rb heisman
            PlayerRB *heisRB = (PlayerRB*) heisman;
            heismanWinnerStr = [NSString stringWithFormat:@"Congratulations to the Player of the Year, %@ RB %@ [%@], who had %ld TDs, just %ld fumbles, and %ld rushing yards. He led %@ to a %ld-%ld record and a #%ld poll ranking.",heisRB.team.abbreviation, heisRB.name, [heisman getYearString], (long)heisRB.statsTD, (long)heisRB.statsFumbles, (long)heisRB.statsRushYards, heisRB.team.name, (long)heisRB.team.wins,(long)heisRB.team.losses,(long)heisRB.team.rankTeamPollScore];
            
            [heismanStats appendString:[NSString stringWithFormat:@"%@\n\nFull Results: %@",heismanWinnerStr, heismanTop5]];
        } else if ([heisman isKindOfClass:[PlayerWR class]]) {
            //wr heisman
            PlayerWR *heisWR = (PlayerWR*) heisman;
            heismanWinnerStr = [NSString stringWithFormat:@"Congratulations to the Player of the Year, %@ WR %@ [%@], who had %ld TDs, just %ld fumbles, and %ld receiving yards. He led %@ to a %ld-%ld record and a #%ld poll ranking.",heisWR.team.abbreviation, heisWR.name, [heisman getYearString], (long)heisWR.statsTD, (long)heisWR.statsFumbles, (long)heisWR.statsRecYards, heisWR.team.name, (long)heisWR.team.wins,(long)heisWR.team.losses,(long)heisWR.team.rankTeamPollScore];
            
            [heismanStats appendString:[NSString stringWithFormat:@"%@\n\nFull Results: %@",heismanWinnerStr, heismanTop5]];
        }
        
        // Add news story
        if (putNewsStory) {
            NSMutableArray *week13 = _newsStories[13];
            [week13 addObject:[NSString stringWithFormat:@"%@ is the Player of the Year!\n",heismanWinnerStr]];
        }
        
        heismanWinnerStrFull = heismanStats;
        return heismanStats;
    } else {
        return heismanWinnerStrFull;
    }
}

-(NSString*)getLeagueHistoryStr {
    NSMutableString *hist = [NSMutableString string];
    for (int i = 0; i < _leagueHistory.count; ++i) {
        [hist appendString:[NSString stringWithFormat:@"%d:\n",(2015+i)]];
        [hist appendString:[NSString stringWithFormat:@"\tChampions: %@\n",_leagueHistory[i][0]]];
        [hist appendString:[NSString stringWithFormat:@"\tPOTY: %@\n",_heismanHistory[i]]];
    }
    return hist;
}

-(NSArray*)getTeamListStr {
    NSMutableArray* teams = [NSMutableArray arrayWithCapacity:_teamList.count];
    for (int i = 0; i < _teamList.count; ++i){
        teams[i] = [NSString stringWithFormat:@"%@: %@, Pres: %ld",_teamList[i].conference, _teamList[i].name,(long)_teamList[i].teamPrestige];
    }
    return teams;
}

-(NSString*)getBowlGameWatchStr {
    //if bowls arent scheduled yet, give predictions
    if (!_hasScheduledBowls) {
        
        for (int i = 0; i < _teamList.count; ++i) {
            [_teamList[i] updatePollScore];
        }
        _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            Team *a = (Team*)obj1;
            Team *b = (Team*)obj2;
            return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
            
        }] copy];
        
        
        NSMutableString* sb = [NSMutableString stringWithString:@"Bowl Game Forecast:\n\n"];
        Team *t1;
        Team *t2;
        
        [sb appendString:@"Semifinal 1v4:\n\t\t"];
        t1 = _teamList[0];
        t2 = _teamList[3];
        [sb appendString:[NSString stringWithFormat:@"%@ vs %@\n\n", t1.strRep, t2.strRep]];
        
        [sb appendString:@"Semifinal 2v3:\n\t\t"];
        t1 = _teamList[1];
        t2 = _teamList[2];
        [sb appendString:[NSString stringWithFormat:@"%@ vs %@\n\n", t1.strRep, t2.strRep]];
        
        for (int i = 0; i < [[self class] bowlGameTitles].count; i+=2) {
            NSString *bowlName = [[self class] bowlGameTitles][i];
            Team *home = _teamList[i + 4];
            Team *away = _teamList[i + 5];
            [sb appendString:[NSString stringWithFormat:@"%@:\n\t\t", bowlName]];
            [sb appendString:[NSString stringWithFormat:@"%@ vs %@\n\n", away.strRep, home.strRep]];
        }
        
        return [sb copy];
        
    } else {
        // Games have already been scheduled, give actual teams
        NSMutableString *sb = [NSMutableString string];
        [sb appendString:@"Bowl Game Results:\n\n"];
        
        [sb appendString:@"Semifinal 1v4:\n"];
        [sb appendString:[self getGameSummaryBowl:_semiG14]];
        
        [sb appendString:@"Semifinal 2v3:\n"];
        [sb appendString:[self getGameSummaryBowl:_semiG23]];
        
        for (Game *bowl in _bowlGames) {
            [sb appendString:[NSString stringWithFormat:@"\n\n%@:\n", bowl.gameName]];
            [sb appendString:[self getGameSummaryBowl:bowl]];
        }
        
        return [sb copy];
    }
}

-(NSString*)getGameSummaryBowl:(Game*)g {
    if (!g.hasPlayed) {
        return [NSString stringWithFormat: @"%@ vs %@", g.homeTeam.strRep,g.awayTeam.strRep];
    } else {
        if (g.homeScore > g.awayScore) {
            return [NSString stringWithFormat:@"%@ W %ld-%ld vs %@", g.homeTeam.strRep, (long)g.homeScore, (long)g.awayScore, g.awayTeam.strRep];
        } else {
            return [NSString stringWithFormat:@"%@ W %ld-%ld vs %@", g.awayTeam.strRep, (long)g.awayScore, (long)g.homeScore, g.homeTeam.strRep];
        }
    }
}

-(NSString*)getCCGsStr {
    NSMutableString *sb = [NSMutableString string];
    for (Conference *c in _conferences) {
        [sb appendString:[NSString stringWithFormat:@"%@\n\n",[c getCCGString]]];
    }
    return [sb copy];
}

-(Team*)findTeam:(NSString*)name {
    for (int i = 0; i < _teamList.count; i++){
        if ([_teamList[i].name isEqualToString:name]) {
            return _teamList[i];
        }
    }
    return _teamList[0];
}

-(Conference*)findConference:(NSString*)name {
    for (int i = 0; i < _teamList.count; i++){
        if ([_conferences[i].confName isEqualToString:name]) {
            return _conferences[i];
        }
    }
    return _conferences[0];
}

-(NSString*)ncgSummaryStr {
    // Give summary of what happened in the NCG
    if (_ncg.homeScore > _ncg.awayScore) {
        return [NSString stringWithFormat:@"%@ (%ld-%ld) won the National Championship, winning against %@ (%ld-%ld) in the NCG %ld-%ld.",_ncg.homeTeam.name,(long)_ncg.homeTeam.wins,(long)_ncg.homeTeam.losses,_ncg.awayTeam.name, (long)_ncg.awayTeam.wins,(long)_ncg.awayTeam.losses, (long)_ncg.homeScore, (long)_ncg.awayScore];
    } else {
        return [NSString stringWithFormat:@"%@ (%ld-%ld) won the National Championship, winning against %@ (%ld-%ld) in the NCG %ld-%ld.",_ncg.awayTeam.name,(long)_ncg.awayTeam.wins,(long)_ncg.awayTeam.losses,_ncg.homeTeam.name, (long)_ncg.homeTeam.wins,(long)_ncg.homeTeam.losses, (long)_ncg.awayScore, (long)_ncg.homeScore];
    }
}

-(NSString*)seasonSummaryStr {
    NSMutableString *sb = [NSMutableString string];
    [sb appendString:[self ncgSummaryStr]];
    [sb appendString:[NSString stringWithFormat:@"\n\n%@",[_userTeam getSeasonSummaryString]]];
    return [sb copy];
}

-(BOOL)saveLeague:(NSData*)saveFile {
    /*StringBuilder sb = new StringBuilder();
    sb.append((2015+leagueHistory.size())+": " + userTeam.abbr + " (" + userTeam.totalWins + "-" + userTeam.totalLosses + ") " +
              userTeam.totalCCs + " CCs, " + userTeam.totalNCs + " NCs%\n");
    
    for (int i = 0; i < leagueHistory.size(); ++i) {
        for (int j = 0; j < leagueHistory.get(i).length; ++j) {
            sb.append(leagueHistory.get(i)[j] + "%");
        }
        sb.append("\n");
    }
    sb.append("END_LEAGUE_HIST\n");
    
    for (int i = 0; i < heismanHistory.size(); ++i) {
        sb.append(heismanHistory.get(i) + "\n");
    }
    sb.append("END_HEISMAN_HIST\n");
    
    for (Team t : teamList) {
        sb.append(t.conference + "," + t.name + "," + t.abbr + "," + t.teamPrestige + "," +
                  t.totalWins + "," + t.totalLosses + "," + t.totalCCs + "," + t.totalNCs + "," + t.rivalTeam + "%\n");
        sb.append(t.getPlayerInfoSaveFile());
        sb.append("END_PLAYERS\n");
    }
    
    sb.append(userTeam.name + "\n");
    for (String s : userTeam.teamHistory) {
        sb.append(s + "\n");
    }
    sb.append("END_USER_TEAM\n");
    
    try (Writer writer = new BufferedWriter(new OutputStreamWriter(
                                                                   new FileOutputStream(saveFile), "utf-8"))) {
        writer.write(sb.toString());
        return true;
    } catch (Exception e) {
        return false;
    }*/
    return YES;
}


-(void)setTeamRanks {
    //get team ranks for PPG, YPG, etc
    for (int i = 0; i < _teamList.count; ++i) {
        [_teamList[i] updatePollScore];
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
        
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamPollScore = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamStrengthOfWins > b.teamStrengthOfWins ? -1 : a.teamStrengthOfWins == b.teamStrengthOfWins ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamStrengthOfWins = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamPoints/[a numGames] > b.teamPoints/b.numGames ? -1 : a.teamPoints/a.numGames == b.teamPoints/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamPoints = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamOppPoints/a.numGames < b.teamOppPoints/b.numGames ? -1 : a.teamOppPoints/a.numGames == b.teamOppPoints/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamOppPoints = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamYards/a.numGames > b.teamYards/b.numGames ? -1 : a.teamYards/a.numGames == b.teamYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamYards = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamOppYards/a.numGames < b.teamOppYards/b.numGames ? -1 : a.teamOppYards/a.numGames == b.teamOppYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamOppYards = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamPassYards/a.numGames < b.teamPassYards/b.numGames ? -1 : a.teamPassYards/a.numGames == b.teamPassYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamPassYards = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamRushYards/a.numGames < b.teamRushYards/b.numGames ? -1 : a.teamRushYards/a.numGames == b.teamRushYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamRushYards = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamOppPassYards/a.numGames < b.teamOppPassYards/b.numGames ? -1 : a.teamOppPassYards/a.numGames == b.teamOppPassYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamOppPassYards = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamOppRushYards/a.numGames < b.teamOppRushYards/b.numGames ? -1 : a.teamOppRushYards/a.numGames == b.teamOppRushYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamOppRushYards = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamTODiff > b.teamTODiff ? -1 : a.teamTODiff == b.teamTODiff ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamTODiff= t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamOppYards/a.numGames < b.teamOppYards/b.numGames ? -1 : a.teamOppYards/a.numGames == b.teamOppYards/b.numGames ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamOffTalent = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamOffTalent > b.teamOffTalent ? -1 : a.teamOffTalent == b.teamOffTalent ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamDefTalent = t+1;
    }
    
    _teamList = [[_teamList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Team *a = (Team*)obj1;
        Team *b = (Team*)obj2;
        return a.teamPrestige > b.teamPrestige ? -1 : a.teamPrestige == b.teamPrestige ? 0 : 1;
    }] mutableCopy];
    for (int t = 0; t < _teamList.count; ++t) {
        _teamList[t].rankTeamPrestige = t+1;
    }

}

-(NSArray*)getTeamRankingsStr:(NSInteger)selection {
    //0 = poll score
    //1 = sos
    //2 = points
    //3 = opp points
    //4 = yards
    //5 = opp yards
    //6 = pass yards
    //7 = rush yards
    //8 = opp pass yards
    //9 = opp rush yards
    //10 = TO diff
    //11 = off talent
    //12 = def talent
    //13 = prestige
    
    NSMutableArray *teams = _teamList;
    NSMutableArray *rankings = [NSMutableArray array];
    Team *t;
    switch (selection) {
        case 0:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
                
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)[t teamPollScore]]];
            }
            break;
        case 1:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamStrengthOfWins > b.teamStrengthOfWins ? -1 : a.teamStrengthOfWins == b.teamStrengthOfWins ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)[t teamStrengthOfWins]]];
            }
            break;
        case 2:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamPoints/[a numGames] > b.teamPoints/b.numGames ? -1 : a.teamPoints/a.numGames == b.teamPoints/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamPoints/t.numGames)]];
            }
            break;
        case 3:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamOppPoints/a.numGames < b.teamOppPoints/b.numGames ? -1 : a.teamOppPoints/a.numGames == b.teamOppPoints/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamOppPoints/t.numGames)]];
            }
            break;
        case 4:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamYards/a.numGames > b.teamYards/b.numGames ? -1 : a.teamYards/a.numGames == b.teamYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamYards/t.numGames)]];
            }
            break;
        case 5:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamOppYards/a.numGames < b.teamOppYards/b.numGames ? -1 : a.teamOppYards/a.numGames == b.teamOppYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamOppYards/t.numGames)]];
            }
            break;
        case 6: //Collections.sort( teams, new TeamCompPYPG() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamPassYards/a.numGames < b.teamPassYards/b.numGames ? -1 : a.teamPassYards/a.numGames == b.teamPassYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamPassYards/t.numGames)]];
            }
            break;
        case 7: //Collections.sort( teams, new TeamCompRYPG() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamRushYards/a.numGames < b.teamRushYards/b.numGames ? -1 : a.teamRushYards/a.numGames == b.teamRushYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamRushYards/t.numGames)]];
            }
            break;
        case 8: //Collections.sort( teams, new TeamCompOPYPG() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamOppPassYards/a.numGames < b.teamOppPassYards/b.numGames ? -1 : a.teamOppPassYards/a.numGames == b.teamOppPassYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamOppPassYards/t.numGames)]];
            }
            break;
        case 9: //Collections.sort( teams, new TeamCompORYPG() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamOppRushYards/a.numGames < b.teamOppRushYards/b.numGames ? -1 : a.teamOppRushYards/a.numGames == b.teamOppRushYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(t.teamOppRushYards/t.numGames)]];
            }
            break;
        case 10: //Collections.sort( teams, new TeamCompTODiff() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamTODiff > b.teamTODiff ? -1 : a.teamTODiff == b.teamTODiff ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                if (t.teamTODiff > 0) {
                    [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)t.teamTODiff]];
                } else {
                    [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)t.teamTODiff]];
                }
            }
            break;
        case 11: //Collections.sort( teams, new TeamCompOffTalent() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamOppYards/a.numGames < b.teamOppYards/b.numGames ? -1 : a.teamOppYards/a.numGames == b.teamOppYards/b.numGames ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)t.teamOffTalent]];
            }
            break;
        case 12: //Collections.sort( teams, new TeamCompDefTalent() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamOffTalent > b.teamOffTalent ? -1 : a.teamOffTalent == b.teamOffTalent ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)t.teamDefTalent]];
            }
            break;
        case 13: //Collections.sort( teams, new TeamCompPrestige() );
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamPrestige > b.teamPrestige ? -1 : a.teamPrestige == b.teamPrestige ? 0 : 1;
            }] mutableCopy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)t.teamPrestige]];
            }
            break;
        default:
            teams = [[teams sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                Team *a = (Team*)obj1;
                Team *b = (Team*)obj2;
                return a.teamPollScore > b.teamPollScore ? -1 : a.teamPollScore == b.teamPollScore ? 0 : 1;
                
            }] copy];
            for (int i = 0; i < teams.count; ++i) {
                t = teams[i];
                [rankings addObject:[NSString stringWithFormat:@"%@,%@,%ld",[t getRankStringStarUser:(i+1)],[t strRepWithBowlResults],(long)[t teamPollScore]]];
            }
            break;
    }
    
    return rankings;
}

@end