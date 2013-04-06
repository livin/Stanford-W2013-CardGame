//
//  GameResult.m
//  CardGame
//
//  Created by Vladimir on 06.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "GameResult.h"

static NSDateFormatter* dateFormatter;

@implementation GameResult

+ (NSDateFormatter*) dateFormatter
{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M/d/yy h:mma"];
    }
    return dateFormatter;
}

- (id) init
{
    self = [super init];
    if (self) {
        _startTime = [NSDate date];
        _endTime = _startTime;
        _score = 0;
    }
    return self;
}

- (void) setScore:(int)score
{
    _score = score;
    self.endTime = [NSDate date];
    [self synchronize];
}

- (NSTimeInterval) duration
{
    return [self.endTime timeIntervalSinceDate: self.startTime];
}

- (NSString*) description
{
    NSString* startTimeString = [[[self class] dateFormatter] stringFromDate: self.startTime];
    return [NSString stringWithFormat: @"Score: %d (%@ %.0fs)", self.score, startTimeString, [self duration]];
}

- (void) synchronize
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* allResults = [[defaults dictionaryForKey: ALL_RESULTS_KEY] mutableCopy];
    
    if (!allResults)
        allResults = [[NSMutableDictionary alloc] init];
    
    allResults[[self.startTime description]] = [self asPropertyList];
    [defaults setObject: allResults forKey: ALL_RESULTS_KEY];
    [defaults synchronize];
}

- (NSDictionary*) asPropertyList
{
    return @{START_KEY: self.startTime, END_KEY: self.endTime, SCORE_KEY: @(self.score)};
}

@end
