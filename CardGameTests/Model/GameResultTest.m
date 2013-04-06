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

@end
