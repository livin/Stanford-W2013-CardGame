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

- (void) testMatchSuits
{
	PlayingCard* c1 = [[PlayingCard alloc] initWithContents: @"2♦"];
	PlayingCard* c2 = [[PlayingCard alloc] initWithContents: @"A♦"];
	
	int matchScore = [c1 match: @[c2]];
	STAssertEquals(matchScore, 1, @"Two suits must match by score 1");
}

- (void) testMatchRanks
{
	PlayingCard* c1 = [[PlayingCard alloc] initWithContents: @"2♦"];
	PlayingCard* c2 = [[PlayingCard alloc] initWithContents: @"2♥"];
	
	int matchScore = [c1 match: @[c2]];
	STAssertEquals(matchScore, 4, @"Two ranks must match by score 4");
}

- (void) testMatchSuitsIn3Cards
{
	PlayingCard* c1 = [[PlayingCard alloc] initWithContents: @"2♦"];
	PlayingCard* c2 = [[PlayingCard alloc] initWithContents: @"A♦"];
	PlayingCard* c3 = [[PlayingCard alloc] initWithContents: @"J♥"];
	
	int matchScore = [c1 match: @[c2, c3]];
	STAssertEquals(matchScore, 1, @"Two suits in 3 cards must match by score 1");
	
	c3 = [[PlayingCard alloc] initWithContents: @"J♦"];
	
	matchScore = [c1 match: @[c2, c3]];
	STAssertEquals(matchScore, 6, @"Three suits in 3 cards must match by score 6");
}

- (void) testMatchRanksIn3Cards
{
	PlayingCard* c1 = [[PlayingCard alloc] initWithContents: @"2♦"];
	PlayingCard* c2 = [[PlayingCard alloc] initWithContents: @"2♥"];
	PlayingCard* c3 = [[PlayingCard alloc] initWithContents: @"J♥"];
	
	int matchScore = [c1 match: @[c2, c3]];
	STAssertEquals(matchScore, 4, @"Two ranks in 3 cards must match by score 4");
	
	c3 = [[PlayingCard alloc] initWithContents: @"2♣"];
	matchScore = [c1 match: @[c2, c3]];
	STAssertEquals(matchScore, 10, @"Three ranks in 3 cards must match by score 10");
}


@end
