//
//  GameResult.m
//  CardGame
//
//  Created by Vladimir on 06.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, strong, nonatomic) NSDate* startTime;
@property (readwrite, strong, nonatomic) NSDate* endTime;
@end

@implementation GameResult

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
}

- (NSTimeInterval) duration
{
    return [self.endTime timeIntervalSinceDate: self.startTime];
}

@end
