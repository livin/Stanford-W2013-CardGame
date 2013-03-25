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
    STAssertEqualObjects([card contents], @"??", @"Card with zero rank and no suit should be undefined card");
    
    card = [[PlayingCard alloc] init];
    card.rank = 1;
    card.suit = @"♦";
    STAssertEqualObjects([card contents], @"A♦", @"Card with rank 1 should be Ace");
    
    card = [[PlayingCard alloc] init];
    card.rank = 12;
    card.suit = @"♥";
    STAssertEqualObjects([card contents], @"Q♥", @"Card with rank 12 should be Queen");
    
    card = [[PlayingCard alloc] init];
    card.rank = 2;
    card.suit = @"x";
    STAssertEqualObjects([card contents], @"2?", @"The invalid suit should not be set");
    
    card = [[PlayingCard alloc] init];
    card.rank = 14;
    STAssertEqualObjects([card contents], @"??", @"Rank should not be set to improper value");    
}

- (void) testCreationWithContents
{
	PlayingCard* card = [[PlayingCard alloc] initWithContents: @"A♦"];
	STAssertEqualObjects(@"A♦", [card contents], @"Initialized card should be A♦");
	
	card = [[PlayingCard alloc] initWithContents: @"10♦"];
	STAssertEqualObjects(@"10♦", [card contents], @"Initialized card should be 10♦");
}

- (void) testMaxRank
{
    STAssertEquals((NSUInteger)13, [PlayingCard maxRank], @"Max rank of the playing card should be 13");
}

@end
