//
//  PlayingCardTest.m
//  CardGame
//
//  Created by Vladimir on 23.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "PlayingCardTest.h"
#import "PlayingCard.h"

@implementation PlayingCardTest

- (void) testCreation
{
    PlayingCard* card = [[PlayingCard alloc] init];
    card.rank = 0;
    card.suit = @"♦";
    STAssertEqualObjects([card contents], @"?♦", @"Card with zero rank should be undefined card");
    
    card = [[PlayingCard alloc] init];
    card.rank = 1;
    card.suit = @"♦";
    STAssertEqualObjects([card contents], @"A♦", @"Card with rank 1 should be Ace");
    
    card = [[PlayingCard alloc] init];
    card.rank = 12;
    card.suit = @"♥";
    STAssertEqualObjects([card contents], @"Q♥", @"Card with rank 12 should be Queen");
}

@end
