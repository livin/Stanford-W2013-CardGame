//
//  GameResult.h
//  CardGame
//
//  Created by Vladimir on 06.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"start"
#define END_KEY @"end"
#define SCORE_KEY @"score"
#define GAMETYPE_KEY @"gametype"

#define GAMETYPE_MATCH 0
#define GAMETYPE_SET 1

@interface GameResult : NSObject

+ (NSUserDefaults*) userDefaults;
+ (void) setUserDefaults: (NSUserDefaults*)aUserDefaults;
+ (NSArray*) allGameResults;
+ (NSArray*) gameTypeStrings;
+ (NSDateFormatter*) dateFormatter;

- (id) initFromPropertyList: (id) plist;
@property (strong, nonatomic) NSDate* startTime;
@property (strong, nonatomic) NSDate* endTime;
@property (nonatomic) int score;
@property (nonatomic) int gameType;
- (NSTimeInterval) duration;
- (void) synchronize;
- (NSString*) gameTypeString;

@end
