//
//  Game.h
//  harbaughsim16
//
//  Created by Akshay Easwaran on 3/16/16.
//  Copyright © 2016 Akshay Easwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Team;
@class  Player;

@interface Game : NSObject {
    NSString *gameEventLog;
    NSString *tdInfo;
    
    //private variables used when simming games
    NSInteger gameTime;
    BOOL gamePoss; //1 if home, 0 if away
    NSInteger gameYardLine;
    NSInteger gameDown;
    NSInteger gameYardsNeed;
    
}
@property (nonatomic) NSInteger homeScore;
@property (nonatomic) NSInteger awayScore;
@property (strong, nonatomic) Team *homeTeam;
@property (strong, nonatomic) Team *awayTeam;
@property (nonatomic) BOOL hasPlayed;

@property (strong, nonatomic) NSString *gameName;

@property (strong, nonatomic) NSArray* homeQScore;
@property (strong, nonatomic) NSArray* awayQScore;
@property (nonatomic) NSInteger homeYards;
@property (nonatomic) NSInteger awayYards;
@property (nonatomic) NSInteger numOT;
@property (nonatomic) NSInteger homeTOs;
@property (nonatomic) NSInteger awayTOs;

@property (strong, nonatomic) NSArray* HomeQBStats;
@property (strong, nonatomic) NSArray* AwayQBStats;

@property (strong, nonatomic) NSArray* HomeRB1Stats;
@property (strong, nonatomic) NSArray* HomeRB2Stats;
@property (strong, nonatomic) NSArray* AwayRB1Stats;
@property (strong, nonatomic) NSArray* AwayRB2Stats;

@property (strong, nonatomic) NSArray* HomeWR1Stats;
@property (strong, nonatomic) NSArray* HomeWR2Stats;
@property (strong, nonatomic) NSArray* HomeWR3Stats;
@property (strong, nonatomic) NSArray* AwayWR1Stats;
@property (strong, nonatomic) NSArray* AwayWR2Stats;
@property (strong, nonatomic) NSArray* AwayWR3Stats;

@property (strong, nonatomic) NSArray* HomeKStats;
@property (strong, nonatomic) NSArray* AwayKStats;

-(void)playGame;
-(instancetype)initWithHome:(Team*)home away:(Team*)away;
+(instancetype)newGameWithHome:(Team*)home away:(Team*)away;
+(instancetype)newGameWithHome:(Team*)home away:(Team*)away name:(NSString*)name;
-(instancetype)initWithHome:(Team*)home away:(Team*)away name:(NSString*)name;
-(NSString*)getGameSummaryString;
-(NSString*)getGameScoutString;
-(NSInteger)getPassYards:(BOOL)ha;
-(NSInteger)getRushYards:(BOOL)ha;
-(NSInteger)getHFAdv;
-(NSString*)getEventPrefix;
-(NSString*)convGameTime;
-(void)addNewsStory;
-(void)runPlay:(Team*)offense defense:(Team*)defense;
-(void)passingPlay:(Team*)offense defense:(Team*)defense;
-(void)rushingPlay:(Team*)offense defense:(Team*)defense;
-(void)fieldGoalAtt:(Team*)offense defense:(Team*)defense;
-(void)kickXP:(Team*)offense defense:(Team*)defense;
-(void)kickOff:(Team*)offense defense:(Team*)defense;
-(void)puntPlay:(Team*)offense;
-(void)qbSack:(Team*)offense;
-(void)safety;
-(void)qbInterception:(Team*)offense;
-(void)passingTD:(Team*)offense receiver:(Player*)selWR stats:(NSArray*)selWRStats yardsGained:(NSInteger)yardsGained;
-(void)passCompletion:(Team*)offense defense:(Team*)defense receiver:(Player*)selWR stats:(NSArray*)selWRStats yardsGained:(NSInteger)yardsGained;
-(void)passAttempt:(Team*)offense defense:(Team*)defense receiver:(Player*)selWR stats:(NSArray*)selWRStats yardsGained:(NSInteger)yardsGained;
-(void)rushAttempt:(Team*)offense defense:(Team*)defense rusher:(Player*)selRB rb1Pref:(double)rb1Pref rb2Pref:(double)rb2Pref yardsGained:(NSInteger)yardsGained;
-(void)addPointsQuarter:(NSInteger)points;
-(void)normalize:(NSInteger)rating;
@end