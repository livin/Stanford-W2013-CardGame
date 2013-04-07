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

@interface GameResult : NSObject

+ (NSDateFormatter*) dateFormatter;

- (id) initFromPropertyList: (id) plist;
@property (strong, nonatomic) NSDate* startTime;
@property (strong, nonatomic) NSDate* endTime;
@property (nonatomic) int score;
- (NSTimeInterval) duration;
- (void) synchronize;

@end
