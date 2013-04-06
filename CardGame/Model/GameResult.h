//
//  GameResult.h
//  CardGame
//
//  Created by Vladimir on 06.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, strong, nonatomic) NSDate* startTime;
@property (readonly, strong, nonatomic) NSDate* endTime;
@property (nonatomic) int score;
- (NSTimeInterval) duration;

@end
