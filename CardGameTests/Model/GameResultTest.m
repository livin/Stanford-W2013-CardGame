//
//  GameResultTest.m
//  CardGame
//
//  Created by Vladimir on 06.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "GameResultTest.h"
#import "GameResult.h"

@implementation GameResultTest

- (GameResult*) sampleGameResultWith15Scores
{
    GameResult* gr = [[GameResult alloc] init];
    gr.score = 15;
    
    // we set dates manually for this test
    gr.startTime = [[GameResult dateFormatter] dateFromString: @"4/6/13 1:00PM"];
    gr.endTime = [[GameResult dateFormatter] dateFromString: @"4/6/13 1:05PM"];
    
    return gr;
}

- (void) testCreate
{
    GameResult* gr = [[GameResult alloc] init];
    STAssertNotNil(gr.startTime, @"When game is created the start time must be set");
}

- (void) testUpdateScore
{
    GameResult* gr = [[GameResult alloc] init];
    
    NSDate* firstEndTime = gr.endTime;
    
    gr.score += 5;
    STAssertEquals(gr.score, 5, @"Score at this point should be updated to 5");

    NSDate* endTimeAfterUpdatingScore = gr.endTime;
    STAssertTrue([firstEndTime compare: endTimeAfterUpdatingScore], @"After setting new score the end must be also updated");
}

- (void) testDuration
{
    GameResult* gr = [[GameResult alloc] init];
    gr.score += 1;
    
    NSTimeInterval duration = [gr duration];
    NSLog(@"Duration: %f", duration);
}

- (void) testDateFormatter
{
    NSDateFormatter* dateFormatter = [GameResult dateFormatter];
    NSDate* date = [dateFormatter dateFromString: @"4/6/13 2:30PM"];
    NSDateComponents* cc = [[NSCalendar currentCalendar] components: NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:date];
    STAssertEquals(cc.year, 2013, @"Year");
    STAssertEquals(cc.month, 4, @"Month");
    STAssertEquals(cc.day, 6, @"Day");
    STAssertEquals(cc.hour, 14, @"Hour");
    STAssertEquals(cc.minute, 30, @"Minute");    
}

- (void) testDescription
{
    GameResult* gr = [self sampleGameResultWith15Scores];     
    STAssertEqualObjects([gr description], @"Score: 15 (4/6/13 1:00PM 300s)", @"Game description should be 15 scores started on 4 April 2013 and took 600 secs (5 mins)");
}

- (void) testSyncronize
{
    GameResult* gr = [self sampleGameResultWith15Scores];
    [gr synchronize];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* allResults = [defaults dictionaryForKey: ALL_RESULTS_KEY];
    STAssertNotNil(allResults, @"We should have the results now after syncing");

    NSDictionary* ourGameResult = allResults[[gr.startTime description]];
    STAssertNotNil(ourGameResult, @"We should have the entry for our game result");
    
    ourGameResult = allResults[[gr.startTime description]];
    STAssertEqualObjects(ourGameResult[START_KEY], gr.startTime, @"The start time saved should match game's start time");
    STAssertEqualObjects(ourGameResult[END_KEY], gr.endTime, @"The end time saved should match game's end time");    
}

@end
