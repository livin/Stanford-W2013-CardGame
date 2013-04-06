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
    GameResult* gr = [[GameResult alloc] init];
    gr.score = 15;
    
    // we set dates manually for this test
    gr.startTime = [[GameResult dateFormatter] dateFromString: @"4/6/13 1:00PM"];
    gr.endTime = [[GameResult dateFormatter] dateFromString: @"4/6/13 1:05PM"];
     
    STAssertEqualObjects([gr description], @"Score: 15 (4/6/13 1:00PM 300s)", @"Game description should be 15 scores started on 4 April 2013 and took 600 secs (5 mins)");
}

@end
