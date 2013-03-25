//
//  CardMatchingGameTest.m
//  CardGame
//
//  Created by Vladimir on 25.03.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "CardMatchingGameTest.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "MockDeck.h"
#import "PlayingCard.h"

@implementation CardMatchingGameTest

- (void) testCreation
{
	CardMatchingGame* g = [[CardMatchingGame alloc] init];
	STAssertNil(g, @"CardMathingGame should be only initialized with designated initializer");
	
	g = [[CardMatchingGame alloc] initWithCardCount:12 usingDeck:[[PlayingCardDeck alloc] init]];
	STAssertNotNil(g, @"Game should be initialized successfully using designated initializer");
	STAssertNotNil([g cardAtIndex: 0], @"Should be a card at index 0");
	STAssertNotNil([g cardAtIndex: 1], @"Should be a card at index 1");
}

- (void) testCardAtIndex
{
	Deck* deck = [[MockDeck alloc] init];
	
	Card* c1 = [[PlayingCard alloc] initWithContents: @"2♦"];
	Card* c2 = [[PlayingCard alloc] initWithContents: @"3♦"];
	
	[deck addCard: c1 atTop: NO];
	[deck addCard: c2 atTop: NO];
	
	CardMatchingGame* game = [[CardMatchingGame alloc] initWithCardCount: 2 usingDeck: deck];
	
	STAssertEquals(c1, [game cardAtIndex: 0], @"Card at index should return first card for index 0");
	STAssertEquals(c2, [game cardAtIndex: 1], @"Card at index should return second card for index 1");
}

- (void) testUserCanFlipOnlyPlayableCards
{
	Deck* deck = [[MockDeck alloc] init];
	
	Card* playableCard = [[PlayingCard alloc] initWithContents: @"A♦"];
	playableCard.faceUp = NO;
	playableCard.unplayable = NO;
	
	Card* unplayableCard = [[PlayingCard alloc] initWithContents: @"3♦"];
	unplayableCard.faceUp = YES;
	unplayableCard.unplayable = YES;
	
	[deck addCard: playableCard atTop: NO];
	[deck addCard: unplayableCard atTop: NO];
	
	CardMatchingGame* game = [[CardMatchingGame alloc] initWithCardCount: 2 usingDeck: deck];

	[game flipCardAtIndex: 1];
	STAssertTrue(unplayableCard.isFaceUp == YES, @"Flipping second unplayable card should do nothing, card shouldn't face down");
	
	[game flipCardAtIndex: 0];
	STAssertTrue(playableCard.isFaceUp == YES, @"Flipping first playable card should work, and card should be faced up");	
}

@end
